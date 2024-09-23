// 用于上传文件的占位组件（用futurebuilder/streambuilder实现）
// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:trump/util/util.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// 上传选中的文件(只用来上传选择视频)
class SelectAndUploadBar extends StatefulWidget {
  final double size;
  final Color? backgroundColor;
  final EdgeInsets margin;
  final Function? setFileUrl;
  final Function? setPicUrl;
  SelectAndUploadBar({
    super.key,
    this.size = 112,
    this.margin = EdgeInsets.zero,
    this.setFileUrl,
    this.setPicUrl,
    this.backgroundColor,
  });
  //icon = Icon(Icons.camera_alt, size: 30, color: Colors.grey),

  @override
  State<SelectAndUploadBar> createState() => _SelectAndUploadBarState();
}

class _SelectAndUploadBarState extends State<SelectAndUploadBar> {
  String fileUrl = '';
  String picUrl = '';
  String fileName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: widget.margin,
      width: widget.size,
      height: widget.size,
      decoration:
          BoxDecoration(color: widget.backgroundColor ?? Colors.grey.shade200),
      child: FutureBuilder<String>(
          future: uploadSingleSelectedFile(),
          builder: (context, sh) {
            if (sh.connectionState == ConnectionState.done) {
              if (sh.hasError) {
                return Text("失败");
              } else {
                // 这是返回的视频链接
                fileUrl = sh.data ?? '';
                if (fileUrl != "" && widget.setFileUrl != null) {
                  widget.setFileUrl!(fileUrl);
                }
                getThumbnail(fileUrl).then((res) {
                  fileName = res;
                }).then((_) {
                  if (fileName != '') {
                    getTemporaryDirectory().then((temPath) {
                      //getApplicationDocumentsDirectory().then((temPath) {
                      String filePath = p.join(temPath.path, fileName);
                      uploadSingleFile(filePath).then((str) {
                        picUrl = str;
                        if (picUrl != "" && widget.setPicUrl != null) {
                          widget.setPicUrl!(picUrl);
                        }
                      });
                    });
                  }
                });
              }
            } else {
              //return Text((sh.data?.length).toString());
              return Text("上传中");
            }
            return Image.network(
              fileUrl != "" ? fileUrl : picUrl,
              fit: BoxFit.cover,
            );
          }),
    );
  }
}

Future getThumbnail(String fileUrl) async {
  String fn = await VideoThumbnail.thumbnailFile(
        video: fileUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 1080,
        maxWidth: 1920,
        quality: 100,
      ) ??
      '';
  return fn;
}
