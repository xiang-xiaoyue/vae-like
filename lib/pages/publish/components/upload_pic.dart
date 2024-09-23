import 'package:flutter/material.dart';
import 'package:trump/util/util.dart';

// 用于上传文件的占位组件(正方形)
// 只用于上传图片、视频
// 展示图片用PublishDisplayPicItem
class ItemForUpload extends StatefulWidget {
  final double size;
  final double iconSize;
  final Color? color;
  final IconData iconData;
  final Color iconColor;
  final Function upload;
  const ItemForUpload({
    super.key,
    required this.upload,
    this.size = 112,
    this.iconData = Icons.camera_alt,
    this.iconSize = 30,
    this.iconColor = Colors.grey,
    this.color,
  });

  @override
  State<ItemForUpload> createState() => _ItemForUploadState();
}

class _ItemForUploadState extends State<ItemForUpload> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        uploadSingleSelectedFile().then((url) {
          widget.upload(url);
        });
      },
      child: Container(
          width: widget.size,
          height: widget.size,
          decoration:
              BoxDecoration(color: widget.color ?? Colors.grey.shade200),
          child: Icon(
            widget.iconData,
            color: widget.iconColor,
            size: widget.iconSize,
          )),
    );
  }
}
