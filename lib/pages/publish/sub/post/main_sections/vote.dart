import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/pages/publish/sub/post/conponents/content_input.dart';
import 'package:trump/pages/publish/sub/post/conponents/title_input.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

// 创建投票
class NewPostVoteMain extends StatelessWidget {
  const NewPostVoteMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreatePostViewModel>(builder: (context, vm, child) {
      return Container(
        color: Color(int.parse(vm.np.color)),
        child: Consumer<CreatePostViewModel>(builder: (context, vm, child) {
          return Column(
            children: [
              PostTitleInput(onChange: (v) => vm.np.title = v.trim(), vm: vm),
              const Divider(thickness: 0.2, color: Colors.grey),
              NewPostTextarea(
                  onChange: (v) => vm.np.content = v.trim(), vm: vm),
              Container(
                padding: const EdgeInsets.all(8),
                //margin: const EdgeInsets.all(8),
                margin: EdgeInsets.fromLTRB(8, 8, 8, 80),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    const Text("添加投票项目(每项18字以内)"),
                    ...vm.np.voteOptionList.map((i) {
                      vm.np.voteOptionList.indexOf(i);
                      return _NewVoteOptionItem(
                          text: i,
                          removeOption: () => vm.removeVoteOption(i),
                          onChange: (s) {
                            vm.updateVoteOption(i, s);
                          });
                    }),
                    _AddVoteOptionItem(addOption: () => vm.addVoteOption()),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}

class _NewVoteOptionItem extends StatefulWidget {
  final String text;
  final Function removeOption;
  final Function onChange;
  const _NewVoteOptionItem({
    super.key,
    required this.text,
    required this.removeOption,
    required this.onChange,
  });

  @override
  State<_NewVoteOptionItem> createState() => _NewVoteOptionItemState();
}

class _NewVoteOptionItemState extends State<_NewVoteOptionItem> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.text = widget.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(color: Colors.blue, fontSize: 14),
        onChanged: (value) {
          widget.onChange(value.trim());
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: GestureDetector(
            onTap: () => widget.removeOption(),
            child: const Icon(Icons.remove_circle, color: Colors.red),
          ),
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(0),
          hintText: "输入选项内容（不超过18字）",
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _AddVoteOptionItem extends StatelessWidget {
  final Function addOption;
  const _AddVoteOptionItem({
    super.key,
    required this.addOption,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => addOption(),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "+ 添加一个选项",
          style: TextStyle(color: Colors.blue, fontSize: 14),
        ),
      ),
    );
  }
}
