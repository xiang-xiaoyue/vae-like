import 'package:flutter/material.dart';

class PublishDisplayPicItem extends StatelessWidget {
  final String url;
  final Function? remove;
  final bool showClose;
  const PublishDisplayPicItem({
    super.key,
    this.url = '',
    this.remove,
    this.showClose = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: url == ''
              ? const AssetImage("assets/images/1.jpg")
              : NetworkImage(url),
        ),
      ),
      child: showClose == true
          ? GestureDetector(
              onTap: () {
                if (remove != null) {
                  remove!();
                }
              },
              child: Container(
                color: Colors.black54.withOpacity(0.45),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
