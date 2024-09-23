import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/components/buttons/button.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/pages/publish/components/pic_item.dart';
import 'package:trump/pages/publish/components/upload_pic.dart';
import 'package:trump/pages/publish/sub/subject/vm.dart';
import 'package:trump/util/util.dart';

// 申请话题
class SubjectApplyPage extends StatelessWidget {
  const SubjectApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateSubjectViewMode>(
      create: (context) => CreateSubjectViewMode(),
      child: Consumer<CreateSubjectViewMode>(builder: (context, vm, child) {
        return Scaffold(
          appBar: CommonAppBar(
            title: "申请话题",
            actions: [
              TrumpButton(
                width: 60,
                height: 35,
                backgroundColor: Colors.blue.shade800,
                borderRadius: 2,
                textColor: Colors.white,
                text: "申请",
                onTap: () {
                  vm.createSubject().then((_) {
                    if (vm.subject!.id > 0) {
                      context.pushReplacementNamed("subject_detail",
                          queryParameters: {"id": vm.subject!.id.toString()});
                    }
                  });
                },
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Consumer<CreateSubjectViewMode>(builder: (context, vm, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  _SubjectApplyItem(
                    labelTex: "话题名称",
                    hintText: "给话题起个好名字",
                    onChange: (name) {
                      vm.ns.name = name.trim();
                    },
                  ),
                  _SubjectApplyItem(
                    labelTex: "关键词",
                    hintText: "最多输入三个，用','隔开",
                    onChange: (kw) {
                      vm.ns.keywords = kw;
                    },
                  ),
                  _SubjectApplyItem(
                    labelTex: "话题简介",
                    hintText: "简单介绍一下，200字以内",
                    onChange: (summary) {
                      vm.ns.summary = summary.trim();
                    },
                  ),
                  _SubjectApplyItem(
                    labelTex: "申请理由",
                    hintText: "我们会以此考核你是否有能力主持这个话题",
                    onChange: (reason) {
                      vm.ns.reason = reason.trim();
                    },
                  ),
                  // todo: 上传图片
                  const Text("上传图片更好地介绍话题(选填)"),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 16,
                    children: [
                      ...vm.coverList.map((item) {
                        return PublishDisplayPicItem(
                          url: item,
                          remove: () => vm.removeCover(item),
                        );
                      }),
                      ItemForUpload(upload: (url) {
                        if (url.contains("http")) {
                          return vm.addCover(url);
                        } else {
                          context.showToast("上传失败");
                        }
                      }),
                    ],
                  ),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}

class _SubjectApplyItem extends StatelessWidget {
  final String labelTex;
  final String hintText;
  final Function(String) onChange;
  const _SubjectApplyItem({
    required this.labelTex,
    required this.hintText,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  labelTex,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: onChange,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
