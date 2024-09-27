import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/pages/search/sub/main/vm.dart';

// 主搜索页面顶部搜索部分
class SearchInputSection extends StatefulWidget {
  final String text;
  const SearchInputSection({super.key, this.text = ''});

  @override
  State<SearchInputSection> createState() => _SearchInputSectionState();
}

class _SearchInputSectionState extends State<SearchInputSection> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Consumer<MainSearchViewModel>(builder: (context, vm, child) {
              return TextField(
                controller: controller,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty == true) {
                    vm.curKeyword = value.trim();
                    controller.text = vm.curKeyword;
                    vm.showResult();
                  } else {
                    // todo：弹窗，表示必须输入内容
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 100,
                            color: Colors.red,
                          ),
                        );
                      },
                    );
                  }
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      vm.curKeyword = "";
                      context.pop();
                    },
                    child: Icon(Icons.close),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withAlpha(100),
                ),
              );
            }),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => context.pop(),
            child: const Text("取消"),
          ),
        ],
      ),
    );
  }
}
