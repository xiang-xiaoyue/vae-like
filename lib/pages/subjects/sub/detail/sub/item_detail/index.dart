import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/subjects/sub/detail/vm.dart';

// 只查看单个subject详情
class SubjectItemDetailPage extends StatelessWidget {
  final String id;
  const SubjectItemDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubjectDetailViewModel>(
      create: (context) => SubjectDetailViewModel.init(id),
      child: Consumer<SubjectDetailViewModel>(builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: CommonAppBar(title: vm.subject?.name ?? ''),
          body: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                          text: "# ",
                          style: const TextStyle(color: Colors.blue),
                          children: [
                            TextSpan(
                                text: vm.subject?.name ?? '',
                                style: const TextStyle(color: Colors.black)),
                          ]),
                    ),
                    Text(
                      "    0点热度 - ${vm.subject?.followingUserCount ?? 0}人关注",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                color: Colors.white,
                child: Row(
                  children: [
                    const Text("话题主持人"),
                    const Spacer(),
                    UserAvatar(
                      url: vm.subject?.user.avatarUrl ?? '',
                      radius: 4,
                      onTap: () {
                        context.pushNamed("user_detail", pathParameters: {
                          "id": (vm.subject?.userId).toString()
                        });
                      },
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed("user_detail", pathParameters: {
                          "id": (vm.subject?.userId).toString()
                        });
                      },
                      child: const Icon(
                        Icons.chevron_right,
                        size: 28,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("话题简介"),
                    const SizedBox(height: 16),
                    Text(
                      vm.subject?.summary ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
