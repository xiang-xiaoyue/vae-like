// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/request/like.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/pages/home/sub/video_list/vm.dart';
import 'package:trump/service/api.dart';

// 用户发布的视频列表页面
class VideoListPage extends StatelessWidget {
  const VideoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "视频"),
      body: ChangeNotifierProvider<VideoListViewModel>(
        create: (context) => VideoListViewModel(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Consumer<VideoListViewModel>(builder: (context, vm, child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 16,
                childAspectRatio: 16 / 12,
              ),
              itemCount: vm.trendVideoCount,
              itemBuilder: (context, index) {
                return _Item(post: vm.trendVideos[index]);
              },
            );
          }),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final Post post;
  const _Item({required this.post});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  // todo:点赞
  @override
  void initState() {
    super.initState();
  }

  void likeVideo() async {
    Resp resp;
    bool isSuccess;
    if (widget.post.isLiking == true) {
      isSuccess = await Api.instance.deleteLike(
        DeleteLike(
          likedId: widget.post.id,
          likedType: Constants.likedTypePost,
        ),
      );
    } else {
      isSuccess = await Api.instance.createLike(
        CreateLike(
          likedId: widget.post.id,
          likedType: Constants.likedTypePost,
        ),
      );
    }
    if (isSuccess) {
      widget.post.isLiking = !widget.post.isLiking;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: GestureDetector(
            onTap: () {
              context.pushNamed("post_detail",
                  pathParameters: {"id": widget.post.id.toString()});
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/1.jpg"),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  child: Row(
                    children: [
                      const Text("视频"),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          likeVideo();
                          setState(() {});
                        },
                        child: Icon(
                          widget.post.isLiking
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined,
                          color: widget.post.isLiking == true
                              ? Colors.red.withAlpha(200)
                              : Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                          likeVideo();
                        },
                        child: const Text("3000"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.post.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
