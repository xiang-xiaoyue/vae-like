import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trump/components/toast.dart';
import 'package:trump/pages/publish/components/pic_item.dart';
import 'package:trump/pages/publish/components/upload_pic.dart';
import 'package:trump/pages/publish/sub/post/conponents/content_input.dart';
import 'package:trump/pages/publish/sub/post/vm.dart';

//  图文
class NewPostPicAndTextMain extends StatelessWidget {
  const NewPostPicAndTextMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<CreatePostViewModel>(builder: (context, vm, _) {
        return Column(
          children: [
            //输入框
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: NewPostTextarea(
                  onChange: (v) => vm.np.content = v.trim(), vm: vm),
            ),
            // 图片展示部分
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 4,
                    runSpacing: 12,
                    children: [
                      if (vm.np.imageList != null)
                        ...vm.np.imageList!.map((i) {
                          return PublishDisplayPicItem(
                            url: i,
                            remove: () => vm.removeImage(i),
                          );
                        }),
                      if ((vm.np.imageList?.length ?? 0) < 9)
                        ItemForUpload(upload: (url) {
                          print("url:$url");
                          if (url.contains("http")) {
                            vm.addImage(url);
                          } else {
                            context.showToast("上传失败");
                          }
                        }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
