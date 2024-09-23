import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/models/resp/models/subject.dart';
import 'package:trump/models/resp/models/user.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

// 定位、选择话题、@某人
class NewPostFooter extends StatelessWidget {
  const NewPostFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(8),
        ),
      ),
      child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
        return Row(
          children: [
            IconAndText(
              icon: Icons.my_location,
              text: "所在位置",
              isMarginLeft: false,
            ),
            vm.selectedSubjectName == ""
                ? IconAndText(
                    icon: Icons.numbers_sharp,
                    text: "话题",
                    isMarginLeft: false,
                    onTap: () {
                      context
                          .pushNamed<Subject>("select_subject")
                          .then((selectedSubject) {
                        vm.selectSubject(selectedSubject!);
                      });
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      context
                          .pushNamed<Subject>("select_subject")
                          .then((selectedSubject) {
                        vm.selectSubject(selectedSubject!);
                      });
                    },
                    child: Container(
                      child: Text(
                        "# ${vm.selectedSubjectName}",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
            //todo:@某人，需要把用户名放 在文本内容当中展示。
            // 在收藏夹中csdn里有教学
            IconAndText(
              icon: Icons.alternate_email,
              text: "",
              isMarginLeft: false,
              onTap: () {
                context.pushNamed<User>("select_at_user").then((user) {
                  vm.atUser(user!);
                });
              },
            )
          ],
        );
      }),
    );
  }
}
