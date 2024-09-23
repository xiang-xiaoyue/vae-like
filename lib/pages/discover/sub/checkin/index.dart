import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/models/resp/models/checkin.dart';
import 'package:trump/pages/discover/sub/checkin/vm.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/util/util.dart';

// 自己的每日签到页面
class CheckinPage extends StatelessWidget {
  const CheckinPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = CommonAppBar(
      backgrounColor: Colors.grey.shade200,
      title: "每日签到",
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            "补签记录",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Icon(
          Icons.help_outline,
          size: 28,
          color: Colors.blueAccent,
        ),
      ],
    );
    return ChangeNotifierProvider<CheckinViewModel>(
      create: (context) => CheckinViewModel(),
      child: Consumer<CheckinViewModel>(builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: appBar,
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  height: 260,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "连续签到6天，总签到10天",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(height: 15),
                      Consumer<CurrentUserViewModel>(
                          builder: (context, curUser, _) {
                        return TrumpButton(
                          text: vm.isCheckedin ? "已签到" : "签到",
                          backgroundColor: Colors.white,
                          textColor: vm.isCheckedin ? Colors.blue : Colors.red,
                          borderRadius: 32,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: 120,
                          onTap: () {
                            if (curUser.isLoggedIn == true) {
                              return vm.checkin();
                            } else {
                              context.showToast("未登录，请登录后签到");
                            }
                          },
                        );
                      }),
                      SizedBox(height: 30),
                      // 日历
                      //_SignCalendar(),
                      NewWidget(),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Text("剩余补签卡数量：${vm.checkedInCardCount}"),
                            Spacer(),
                            Consumer<CurrentUserViewModel>(
                                builder: (context, cur, _) {
                              return TrumpButton(
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                text: "购买",
                                borderRadius: 8,
                                onTap: () {
                                  if (cur.isLoggedIn == true) {
                                    context.pushReplacementNamed("shop");
                                  } else {
                                    context.showToast("未登录，请登录后操作");
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
  });

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  CrCalendarController controller = CrCalendarController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(0.2, 0.5),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(2)),
      height: 400,
      child: Consumer<CheckinViewModel>(builder: (context, vm, _) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () => context.showToast("现在不支持"),
                      child: Icon(Icons.chevron_left)),
                  Text(
                      "${vm.yearMonth.year} - ${vm.yearMonth.month < 10 ? "0" : ""}${vm.yearMonth.month}"),
                  GestureDetector(
                      onTap: () => context.showToast("现在不支持"),
                      child: Icon(Icons.chevron_right)),
                ],
              ),
            ),
            Divider(
                height: 0.1,
                color: Colors.grey.shade200,
                indent: 8,
                endIndent: 8),
            SizedBox(height: 8),
            Expanded(
              child: CrCalendar(
                controller: controller,
                initialDate: vm.yearMonth,
                forceSixWeek: true,
                firstDayOfWeek: WeekDay.monday,
                weekDaysBuilder: (day) {
                  String dayStr = "";
                  switch (day) {
                    case WeekDay.monday:
                      dayStr = "一";
                      break;
                    case WeekDay.tuesday:
                      dayStr = "二";
                      break;
                    case WeekDay.wednesday:
                      dayStr = "三";
                      break;
                    case WeekDay.thursday:
                      dayStr = "四";
                      break;
                    case WeekDay.friday:
                      dayStr = "五";
                      break;
                    case WeekDay.saturday:
                      dayStr = "六";
                      break;
                    case WeekDay.sunday:
                      dayStr = "日";
                      break;
                    default:
                      break;
                  }
                  return Text(
                    dayStr,
                    style: TextStyle(color: Colors.blue.shade600),
                  );
                },
                onDayClicked: (ets, day) {},
                dayItemBuilder: (p) {
                  if (p.isInMonth) {
                    return _Item(day: p.dayNumber);
                  }
                  return SizedBox();
                },
                maxEventLines: 6,
                backgroundColor: Colors.white,
                eventsTopPadding: 12.0,
                //minDate: DateTime(2024, 9, 1),
                //maxDate: DateTime(2035, 9, 1),
                // 只能查看当月的
                minDate: DateTime(vm.yearMonth.year, vm.yearMonth.month, 1),
                maxDate: DateTime(vm.yearMonth.year, vm.yearMonth.month,
                    vm.daysInMonth(DateTime.now().millisecondsSinceEpoch)),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Item extends StatelessWidget {
  final int day;
  const _Item({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    bool isCheckedin(List<CheckinItem>? list) {
      DateTime now = DateTime.now();
      String de = absoluteTime(
        DateTime(now.year, now.month, day, 0, 0, 0).millisecondsSinceEpoch,
        onlyDate: true,
      );
      if (list == null) {
        return false;
      } else {
        List<String> dates = list.map((i) {
          return i.date;
        }).toList();
        return dates.contains(de);
      }
    }

    // 在明天之前
    bool isBefore() {
      DateTime now = DateTime.now();
      return (DateTime(now.year, now.month, day, 0, 0, 0))
          .isBefore(DateTime(now.year, now.month, now.day + 1, 0, 0, 0));
    }

    return Center(
      child: Consumer<CheckinViewModel>(builder: (context, vm, _) {
        return Stack(
          children: [
            Consumer<CurrentUserViewModel>(builder: (context, cur, _) {
              return GestureDetector(
                onTap: () {
                  if (cur.isLoggedIn == false) {
                    context.showToast("未登录，请登录后操作");
                    return;
                  }
                  if (isCheckedin(vm.items) == false &&
                      DateTime.now().day == day) {
                    vm.checkin().then((success) {
                      if (success == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("签到成功"),
                            duration: Duration(milliseconds: 300)));
                      }
                    });
                  }
                  if (isCheckedin(vm.items) == false &&
                      isBefore() &&
                      DateTime.now().day != day) {
                    // 补签
                    DateTime now = DateTime.now();
                    vm.reCheckin(now.year, now.month, day).then((success) {
                      if (success == true) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("补签成功"),
                            duration: Duration(milliseconds: 200),
                            backgroundColor: Colors.blue));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("补签失败"),
                            backgroundColor: Colors.red));
                      }
                    });
                  }
                },
                child: Container(
                  color: Colors.white,
                  width: 38,
                  height: 38,
                  child: Center(child: Text(day.toString())),
                ),
              );
            }),
            Positioned(
              bottom: 0,
              right: 0,
              child: isBefore()
                  ? CircleAvatar(
                      radius: 7,
                      backgroundColor: isCheckedin(vm.items)
                          ? Colors.blue.shade100
                          : DateTime.now().day != day
                              ? Colors.orangeAccent.shade100
                              : Colors.red.shade100,
                      child: isCheckedin(vm.checkinRecord?.items)
                          ? Icon(Icons.check,
                              color: Colors.blue.shade700, size: 10)
                          : DateTime.now().day != day
                              ? Text("补",
                                  style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.deepOrange.shade800))
                              : Text("签",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.red)),
                    )
                  : SizedBox(),
            ),
          ],
        );
      }),
    );
  }
}
