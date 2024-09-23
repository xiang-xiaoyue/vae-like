import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/notice.dart';
import 'package:trump/pages/notice/sub/official/vm.dart';
import 'package:trump/util/util.dart';

class OfficialNoticePage extends StatelessWidget {
  const OfficialNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OfficialViewModel>(
      create: (context) => OfficialViewModel(),
      child: Scaffold(
        appBar: const CommonAppBar(title: "官方消息"),
        body: Consumer<OfficialViewModel>(builder: (context, vm, child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: vm.ns.length,
                    itemBuilder: (context, index) {
                      return _Item(
                        notice: vm.ns[index],
                      );
                    },
                  ),
                ),
                const NoMore(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NoMore extends StatelessWidget {
  const NoMore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 10),
      child: const Text(
        "没有更多内容了",
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final Notice notice;
  const _Item({
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            absoluteTime(notice.createTime),
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "系统消息",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                notice.content,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed("help_center");
                    },
                    child: const Text(
                      "查看说明",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                    size: 28,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
