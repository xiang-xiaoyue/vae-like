import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/pages/mine/sub/feedback/vm.dart';

// 在此页面提交建议
class MineFeedbackPage extends StatefulWidget {
  const MineFeedbackPage({super.key});

  @override
  State<MineFeedbackPage> createState() => _MineFeedbackPageState();
}

class _MineFeedbackPageState extends State<MineFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedbackViewModel>(
      create: (context) => FeedbackViewModel(),
      child: Consumer<FeedbackViewModel>(builder: (context, vm, child) {
        return Scaffold(
          appBar: CommonAppBar(
            title: "建议反馈",
            actions: [
              TextButton(
                  onPressed: () {
                    vm.createAdvice().then((success) {
                      if (success == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("提交成功")));
                        context.pop();
                      }
                    });
                  },
                  child: const Text("提交")),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 4),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      "问题类型",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _showOptions(context).then(
                          (res) {
                            if (res != '' && res != null) {
                              vm.setType(res);
                            }
                          },
                        );
                      },
                      child: Text(
                        getFeedbackOption(vm.adviceType),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  maxLines: 8,
                  minLines: 8,
                  onChanged: (v) {
                    vm.adviceContent = v;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

Future<String?> _showOptions(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      Map<String, String> feedbacks = {
        FeedbackViewModel.adviceTypeBug:
            getFeedbackOption(FeedbackViewModel.adviceTypeBug),
        FeedbackViewModel.adviceTypeBetter:
            getFeedbackOption(FeedbackViewModel.adviceTypeBetter),
        FeedbackViewModel.adviceTypeElse:
            getFeedbackOption(FeedbackViewModel.adviceTypeElse),
      };
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        children: feedbacks.keys
            .map(
              (v) => _FeedbackItem(text: feedbacks[v]!, value: v),
            )
            .toList(),
      );
    },
  );
}

String getFeedbackOption(String adviceType) {
  switch (adviceType) {
    case FeedbackViewModel.adviceTypeBug:
      return "提BUG";
    case FeedbackViewModel.adviceTypeBetter:
      return "优化";
    case FeedbackViewModel.adviceTypeElse:
      return "其他";
    default:
      return "未知选项";
  }
}

class _FeedbackItem extends StatelessWidget {
  final String value;
  final String text;
  const _FeedbackItem({
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () => Navigator.pop(context, value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(text),
      ),
    );
  }
}
