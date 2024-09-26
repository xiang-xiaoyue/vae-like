import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/notice/components/go_back_leading.dart';
import 'package:trump/pages/notice/components/item_card.dart';
import 'package:trump/pages/notice/vm.dart';

class AtMeNoticePage extends StatefulWidget {
  const AtMeNoticePage({super.key});

  @override
  State<AtMeNoticePage> createState() => _AtMeNoticePageState();
}

class _AtMeNoticePageState extends State<AtMeNoticePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    setState(() {});
    controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: const [
            Positioned(
              child: _Page(),
            ),
            MsgGoBackLeading(),
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TwoTabAppBar(),
          Expanded(
            child:
                Consumer<NoticeIndexViewModel>(builder: (context, vm, child) {
              return TabBarView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, idx) {
                      return NoticeItem(notice: vm.postAtMeList[idx]);
                    },
                    itemCount: vm.postAtMeList.length,
                  ),
                  ListView.builder(
                    itemBuilder: (ctx, idx) {
                      return NoticeItem(notice: vm.commentAtMeList[idx]);
                    },
                    itemCount: vm.commentAtMeList.length,
                    shrinkWrap: true,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
