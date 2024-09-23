import 'package:go_router/go_router.dart';
import 'package:trump/pages/discover/live.dart';
import 'package:trump/pages/discover/export.dart';

List<GoRoute> discoverRoutes = [
  GoRoute(
      name: "live",
      path: "live",
      builder: (context, state) => const LivePage()),
  GoRoute(
      name: "sign",
      path: "sign",
      builder: (context, state) => const CheckinPage()),
  GoRoute(
      name: "shop",
      path: "shop",
      builder: (context, state) => const ShopPage()),
  GoRoute(
      name: "carts", path: "carts", builder: (context, state) => CartsPage()),
  GoRoute(
      name: "goods_detail",
      path: "goods_detail",
      builder: (context, state) =>
          GoodsDetailPage(id: state.uri.queryParameters["id"] ?? '0')),
  GoRoute(
      name: "task_center",
      path: "task_center",
      builder: (context, state) => const TaskCenterPage()),
  GoRoute(
      name: "user_rank",
      path: "user_rank",
      builder: (context, state) => const UserRankPage()),
  GoRoute(
      name: "user_rank_detail",
      path: "user_rank_detail",
      // type: hot(人气榜), checkin(签到榜), level(等级榜), coin(金币/松子榜)
      builder: (context, state) => UserRankDetailPage(
          type: state.uri.queryParameters['sort_type'] ?? 'hot')),
  GoRoute(
      name: "post_rank_list",
      path: "post_rank_list",
      builder: (context, state) => const PostRankPage()),
];
