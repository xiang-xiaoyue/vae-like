import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/search/app_bar.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/pages/publish/sub/post/sub/vm.dart';
import 'package:trump/pages/subjects/components/item.dart';

// 发布帖子时选择话题
class SelectSubjectPage extends StatelessWidget {
  const SelectSubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchSubjectViewModel>(
      create: (context) => SearchSubjectViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child:
              Consumer<SearchSubjectViewModel>(builder: (context, vm, child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
                  child: vm.displayResult == true
                      ? const _ResultPageContent()
                      : const _DefaultPageContent(),
                ),
                Positioned(
                  child: SearchAppBar(
                    text: "搜索话题",
                    onSubmit: (s) => vm.searchSubject(s),
                    onCancel: () => context.pop(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _ResultPageContent extends StatelessWidget {
  const _ResultPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchSubjectViewModel>(builder: (context, vm, child) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, idx) {
          return GestureDetector(
            onTap: () {
              context.pop(vm.subjects[idx]);
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SubjectItem(subject: vm.subjects[idx]),
            ),
          );
        },
        itemCount: vm.subjects.length,
      );
    });
  }
}

class _DefaultPageContent extends StatelessWidget {
  const _DefaultPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchSubjectViewModel>(builder: (context, vm, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Text("最新关注"),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ...vm.latestSubjects.map((i) {
                return GestureDetector(
                  onTap: () {
                    context.pop<Subject>(i);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5, color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "# ${i.name}",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      );
    });
  }
}
