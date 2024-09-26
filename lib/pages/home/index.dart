import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/models/resp/index.dart';
import 'package:trump/pages/home/components/hot_user_content_item.dart';
import 'package:trump/pages/home/vm.dart';

//首页
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(builder: (context, vm, _) {
        return RefreshAndLoadMore(
          onRefresh: () async {
            vm.initConfig(vm.subType);
            await vm.getTrendList(requireNewest: true);
            await vm.getLatestContent();
          },
          onLoadMore: () async => await vm.getTrendList(),
          child: SafeArea(
            child: NotificationListener<ScrollNotification>(
              onNotification: (nf) {
                if (nf.metrics.pixels + 30 >= nf.metrics.maxScrollExtent) {
                  vm.getTrendList();
                }
                return false;
              },
              child: const CustomScrollView(
                slivers: [
                  _HomePageAppBar(),
                  _HomePic(),
                  _MenuTab(), // 行程、图集、作品、视频、活动
                  _LatestTrend(), //hot-user发表的最新post/comment,点击查看详情
                  _TrendListHeader(), // 官方动态头部
                  _TrendList(), // 官方动态列表
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _TrendListHeader extends StatelessWidget {
  const _TrendListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderDelegate(
        maxHeight: 48,
        minHeight: 48,
        child: Consumer<HomeViewModel>(builder: (context, vm, _) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ChangeNotifierProvider.value(
              value: vm,
              child: AppTextAndIcon(
                left: "官方动态",
                right: Icons.menu,
                onTap: () {
                  showModalBottomSheet<String?>(
                    elevation: 10,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Column(
                          children: [
                            SheetActionItem(
                              text: "全部",
                              onTap: () {
                                context.pop("");
                              },
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(4)),
                            ),
                            SheetActionItem(
                                text: "新闻",
                                onTap: () {
                                  context.pop(Constants.postSubTypeNews);
                                }),
                            SheetActionItem(
                                text: "专访",
                                onTap: () {
                                  context.pop(Constants.postSubTypeInterview);
                                }),
                            SheetActionItem(
                                text: "图集",
                                onTap: () {
                                  context.pop(Constants.postSubTypeAtlas);
                                }),
                            SheetActionItem(
                                text: "视频",
                                onTap: () {
                                  context.pop(Constants.postSubTypeVideo);
                                }),
                            SheetActionItem(
                              text: "MV",
                              onTap: () {
                                context.pop(Constants.postSubTypeMV);
                              },
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(4)),
                            ),
                            SizedBox(height: 4),
                            SheetActionItem(
                              text: "取消",
                              onTap: () {
                                context.pop(null);
                              },
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      );
                    },
                  ).then((subType) {
                    if (subType != null) {
                      vm.initConfig(subType);
                      vm.getTrendList();
                    }
                  });
                }, //todo:按分类查询“官方动态”
              ),
            ),
          );
        }),
      ),
    );
  }
}

//顶部tabbar栏
class _HomePageAppBar extends StatelessWidget {
  const _HomePageAppBar();

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      pinned: true,
      toolbarHeight: 42,
      title: Text(
        "TrumpChat  怪力乱神，子所不语；六合之外，存而不论！",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

// 顶部大图片
class _HomePic extends StatelessWidget {
  const _HomePic();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedOverflowBox(
        size: const Size(double.infinity, 200),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.asset("assets/images/1.jpg"),
        ),
      ),
    );
  }
}

// 首页的菜单选项,是Trump的行程、图集、作品（声音信息）、视频、活动 相关信息。
class _MenuTab extends StatelessWidget {
  const _MenuTab();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.only(bottom: 8),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _MenuTabItem(
              name: "行程",
              pathName: "trip_list",
              iconData: Icons.trip_origin,
            ),
            _MenuTabItem(
              name: "图集",
              pathName: "atlas",
              iconData: Icons.image,
            ),
            _MenuTabItem(
              name: "作品",
              pathName: "work_list",
              iconData: Icons.book,
            ),
            _MenuTabItem(
              name: "视频",
              pathName: "video_list",
              iconData: Icons.video_file,
            ),
            _MenuTabItem(
              name: "活动",
              pathName: "activity_list",
              iconData: Icons.local_activity,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTabItem extends StatelessWidget {
  //todo: 寻找素材，替换icon
  final String pathName;
  final String name;
  final IconData iconData;
  const _MenuTabItem({
    required this.name,
    this.pathName = "",
    this.iconData = Icons.home,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pathName != "") {
          context.pushNamed(pathName);
        }
      },
      child: Column(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.blueAccent,
          ),
          const SizedBox(height: 5),
          Text(name),
        ],
      ),
    );
  }
}

// hot-role发布的最新内容（post或comment)
class _LatestTrend extends StatefulWidget {
  const _LatestTrend();

  @override
  State<_LatestTrend> createState() => _LatestTrendState();
}

class _LatestTrendState extends State<_LatestTrend> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<HomeViewModel>(builder: (context, vm, child) {
          return Column(
            children: [
              const AppDoubleText(left: "嘉宾来了", right: "更多"),
              const SizedBox(height: 15),
              vm.latestContent == null
                  ? const SizedBox()
                  : HotUserContentItem(
                      content: vm.latestContent!), //todo: 右上角需要盖章
              const SizedBox(height: 10),
            ],
          );
        }),
      ),
    );
  }
}

// “官方动态”列表
class _TrendList extends StatelessWidget {
  const _TrendList();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeViewModel>(builder: (context, vm, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.trends.length,
          itemBuilder: (context, index) {
            return _TrendItem(
              post: vm.trends[index],
              toggleLike: () {
                if (vm.isLiking == false) {
                  vm.isLiking = true;
                  vm
                      .toggleLikeTrend(vm.trends[index].id)
                      .then((_) => vm.isLiking = false);
                }
              },
            );
          },
        );
      }),
    );
  }
}

//官方动态下面,(视频和新闻)
class _TrendItem extends StatelessWidget {
  final Function toggleLike;
  final Post post;
  const _TrendItem({required this.post, required this.toggleLike});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("post_detail",
            pathParameters: {"id": post.id.toString()});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            UserAvatar(url: post.posterUrl, hintText: post.title[0], size: 100),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 96,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      post.content,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(postTypeConvert(post.subType)),
                        const Spacer(),
                        IconAndText(
                          icon: Icons.comment,
                          text: post.commentCount.toString(),
                          // onTap: () => context.pushNamed("post_detail",
                          //     pathParameters: {"id": post.id.toString()}),
                        ),
                        IconAndText(
                          icon: Icons.thumb_up,
                          iconColor: post.isLiking ? Colors.red : null,
                          text: post.likeCount.toString(),
                          onTap: toggleLike,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 把video转成“视频”
String postTypeConvert(String subType) {
  switch (subType) {
    case Constants.postTypeActivity:
      return "活动";
    case Constants.postTypeTrip:
      return "行程";
    case Constants.postTypeThread:
      return "帖子";
    case Constants.postTypeTrends:
      return "官方动态";
    case Constants.postSubTypeVote:
      return "投票";
    case Constants.postTypeGoods:
      return "商品";
    case Constants.postSubTypeTextWithImages:
      return "图文";
    case Constants.postSubTypeShortText:
      return "短文字";
    case Constants.postSubTypeLongText:
      return "长文";
    case Constants.postSubTypeVoice:
      return "语音";
    case Constants.postSubTypeNews:
      return "新闻";
    case Constants.postSubTypeInterview:
      return "专访";
    case Constants.postSubTypeAtlas:
      return "图集"; // 官方图集（长文的一种）
    case Constants.postSubTypeVideo:
      return "视频";
    case Constants.postSubTypeMV:
      return "MV";
    default:
      return "未知类型";
  }
}
