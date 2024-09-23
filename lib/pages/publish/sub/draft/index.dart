import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/publish/sub/draft/vm.dart';

// 草稿箱，todo: 都是post,但是应该也可以有subject才对
class DraftPage extends StatelessWidget {
  const DraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DraftViewModel>(
      create: (context) => DraftViewModel(),
      child: Consumer<DraftViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: CommonAppBar(
              title: "草稿箱",
              rightPadding: 0,
              actions: [
                if (vm.isEditing == true)
                  TextButton(
                    onPressed: () => vm.toggleEditing(),
                    child: const Text(
                      "完成",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                else
                  TextButton(
                    onPressed: () => vm.toggleEditing(),
                    child: const Text(
                      "编辑",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
            body: Center(
              child: TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    "待完成...",
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          );
        },
      ),
    );
  }
}
