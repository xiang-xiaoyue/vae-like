import 'package:flutter/material.dart';
import 'package:trump/models/resp/models/checkin.dart';
import 'package:trump/service/api.dart';
import 'package:trump/util/util.dart';

class CheckinViewModel with ChangeNotifier {
  Checkin? checkinRecord;
  List<CheckinItem> items = [];
  CheckinViewModel() {
    getCheckinList();
    getCheckedCardCount();
    yearMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  }
  bool isCheckedin = false;
  DateTime yearMonth = DateTime.now();

  dynamic checkedInCardCount = "0";

  int daysInMonth(int stamp) {
    int year = DateTime.fromMillisecondsSinceEpoch(stamp).year;
    int month = DateTime.fromMillisecondsSinceEpoch(stamp).month;
    int getDaysInFeb() {
      if (year % 400 == 0) {
        return 29;
      } else if (year % 400 != 0 && year % 100 == 0) {
        return 29;
      } else if (year % 4 == 0) {
        return 29;
      } else if (year % 4 != 0) {
        return 28;
      }
      return 28;
    }

    Map<int, int> maps = {
      1: 31,
      2: getDaysInFeb(),
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31,
    };
    return maps[month] ?? 30;
  }

  // 获得上一月，
  void preMonth() {
    if (yearMonth.month > 1) {
      yearMonth = DateTime(yearMonth.year, yearMonth.month - 1, 1);
      notifyListeners();
    } else {
      yearMonth = DateTime(yearMonth.year - 1, 12, 1);
      notifyListeners();
    }
    notifyListeners();
  }

  // 下一月
  void nextMonth() {
    if (yearMonth.month < 12) {
      yearMonth = DateTime(yearMonth.year, yearMonth.month + 1, 1);
      notifyListeners();
    } else {
      yearMonth = DateTime(yearMonth.year + 1, 1, 1);
      notifyListeners();
    }
    notifyListeners();
  }

  // 签到
  Future checkin() async {
    isCheckedin = await Api.instance.checkin();
    await getCheckinList();
    notifyListeners();
    return isCheckedin;
  }

  // 补签
  Future reCheckin(int year, int month, int day) async {
    bool success =
        await Api.instance.reCheckin(year: year, month: month, day: day);
    if (success == true) {
      await getCheckinList();
      await getCheckedCardCount();
      notifyListeners();
      return success;
    }
  }

  // 查询签到记录,不传参数则查询当前用户当月的签到记录
  Future getCheckinList() async {
    checkinRecord = await Api.instance.getCheckinList();
    String currentDatetimeStr =
        absoluteTime(DateTime.now().millisecondsSinceEpoch, onlyDate: true);
    if (checkinRecord != null && checkinRecord!.items != null) {
      items = checkinRecord!.items!;
      isCheckedin = items.any((i) => i.date == currentDatetimeStr);
    }
    notifyListeners();
  }

  // 获得补签卡数量(返回全部已购商品，从中筛选出补签卡)
  Future getCheckedCardCount() async {
    checkedInCardCount = await Api.instance.getGoodsCount("补签卡");
    notifyListeners();
  }
}
