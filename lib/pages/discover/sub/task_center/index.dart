import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/task_note.dart';
import 'package:trump/pages/discover/sub/task_center/vm.dart';

// 任务中心
class TaskCenterPage extends StatelessWidget {
  const TaskCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskCenterViewModel>(
      create: (context) => TaskCenterViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        //todo: 下拉刷新
        appBar: CommonAppBar(
          title: "任务中心",
          rightPadding: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.help_outline, color: Colors.blue, size: 28),
            ),
          ],
        ),
        body: Consumer<TaskCenterViewModel>(builder: (context, vm, _) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            children: [
              SizedBox(height: 20),
              _TaskDoneIndicator(),
              ...vm.notes.map((note) {
                return _TaskItem(note: note);
              }),
            ],
          );
        }),
      ),
    );
  }
}

// 顶部两个任务进度指示器
class _TaskDoneIndicator extends StatelessWidget {
  const _TaskDoneIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 200,
      child: const Column(
        children: [
          Text(
            "做日常任务得积分（VIP翻倍）",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TaskIndicatorItem(),
                _TaskIndicatorItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskIndicatorItem extends StatelessWidget {
  const _TaskIndicatorItem();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: CircularProgressIndicator(
              color: Colors.blue.withAlpha(120), //  普通用户完成任务的颜色
              //color: Colors.yellow, // vip 色
              backgroundColor: Colors.grey.withAlpha(40),
              value: 0.25,
              strokeWidth: 24,
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "25.0%",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "+1积分",
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 没完成，显示0/1,
// 显示“领取奖励”
// 完成任务，且拿了奖励,显示“已领”
class _TaskItem extends StatelessWidget {
  final TaskNote note;
  const _TaskItem({
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    String timeFromMinutes(int minutes) {
      int hours = minutes ~/ 60;
      int mins = minutes % 60;
      String hoursStr = "$hours";
      String minsStr = "$mins";
      if (hours < 10) {
        hoursStr = "0$hoursStr";
      }
      if (mins < 10) {
        minsStr = "0$minsStr";
      }
      return "$hoursStr:$minsStr";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Consumer<TaskCenterViewModel>(builder: (context, vm, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.task.displayName,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    text: note.task.currencyType,
                    children: [
                      TextSpan(
                        text: "  +${note.task.currencyCount}",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TrumpButton(
              width: 80,
              height: 35,
              borderStyle: note.doneCount >= note.task.requireCount
                  ? BorderStyle.none
                  : BorderStyle.solid,
              text: note.doneCount < note.task.requireCount
                  ? note.task.name != "online-minutes"
                      ? ("${note.doneCount}/${note.task.requireCount}")
                      : timeFromMinutes(note.doneCount)
                  : (note.gainReward == false)
                      ? "领取奖励"
                      : "已领",
              backgroundColor: note.doneCount < note.task.requireCount
                  ? Colors.white
                  : !note.gainReward
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.6),
              textColor: note.doneCount >= note.task.requireCount
                  ? Colors.white
                  : Colors.grey,
              onTap: () {
                vm.gainTaskReward(note.task.id).then((success) {
                  if (success == true) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("领取成功")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("操作失败"),
                      backgroundColor: Colors.red,
                    ));
                  }
                });
              },
            )
          ],
        );
      }),
    );
  }
}
