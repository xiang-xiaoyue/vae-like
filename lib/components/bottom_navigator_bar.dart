import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/vm.dart';

class TrumpBottomNavigatorBar extends StatefulWidget {
  const TrumpBottomNavigatorBar({super.key});

  @override
  State<TrumpBottomNavigatorBar> createState() =>
      _TrumpBottomNavigatorBarState();
}

class _TrumpBottomNavigatorBarState extends State<TrumpBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalViewModel>(builder: (context, vm, _) {
      return PopScope(
        onPopInvoked: (d) {
          vm.popIdx();
        },
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: vm.curIdx,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Colors.blueAccent,
          onTap: (v) {
            setState(() {
              switch (v) {
                case 0:
                  context.pushNamed("home");
                  break;
                case 1:
                  context.pushNamed("subject");
                  break;
                case 2:
                  context.pushNamed("discover");
                  break;
                case 3:
                  context.pushNamed("notice");
                  break;
                case 4:
                  context.pushNamed("mine");
                  break;
                default:
                  break;
              }
              vm.setCurIdx(v);
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "trump"),
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: "圈子"),
            BottomNavigationBarItem(icon: Icon(Icons.discord), label: "发现"),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
          ],
        ),
      );
    });
  }
}
