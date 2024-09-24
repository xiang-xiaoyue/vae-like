import 'package:go_router/go_router.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/configs/routes/home.dart';
import 'package:trump/pages/for_test.dart';
import 'package:trump/pages/index.dart';
import 'package:trump/pages/notice/export.dart';

import 'package:trump/configs/routes/discover.dart';
import 'package:trump/configs/routes/help.dart';
import 'package:trump/configs/routes/mine.dart';
import 'package:trump/configs/routes/notice.dart';
import 'package:trump/pages/discover/index.dart';
import 'package:trump/pages/group/exports.dart';
import 'package:trump/pages/help/index.dart';
import 'package:trump/pages/mine/index.dart';
import 'package:trump/pages/pic_detail/index.dart';
import 'package:trump/pages/post/exports.dart';
import 'package:trump/pages/publish/export.dart';
import 'package:trump/pages/publish/sub/post/sub/select_at_user.dart';
import 'package:trump/pages/publish/sub/post/sub/select_subject.dart';
import 'package:trump/pages/search/index.dart';
import 'package:trump/pages/search/sub/main/sub/results.dart';
import 'package:trump/pages/subjects/export.dart';
import 'package:trump/pages/user/main_page.dart';

List<GoRoute> routes = [
  GoRoute(
      path: "/for_test",
      name: "for_test",
      builder: (context, state) => const ForTestPage()),
  GoRoute(
      path: "/pic_detail",
      name: "pic_detail",
      builder: (context, state) =>
          PicDetailPage(url: state.uri.queryParameters['url'] ?? '')),
  GoRoute(
    path: "/",
    name: "index",
    builder: (context, state) => const IndexPage(),
    routes: [
      ...homeRoutes,
      ...discoverRoutes,
      ...mineRoutes,
      ...noticeRoutes,
    ],
  ),
  GoRoute(
    path: "/help_center",
    name: "help_center",
    builder: (context, state) => const HelpCenterPage(),
    routes: helpRoutes,
  ),
  GoRoute(
    path: "/subject_item_detail",
    name: "subject_item_detail",
    builder: (context, state) =>
        SubjectItemDetailPage(id: state.uri.queryParameters["id"] ?? "0"),
  ),
  GoRoute(
    path: "/following_subject_list",
    name: "following_subject_list",
    builder: (context, state) => const AllFollowingSubjectPage(),
  ),
  GoRoute(
    path: "/subject_detail",
    name: "subject_detail",
    builder: (context, state) => SubjectDetailPage(
      id: state.uri.queryParameters["id"] ?? "0",
    ),
  ),
  GoRoute(
    // 申请话题
    path: "/subject_apply",
    name: "subject_apply",
    builder: (context, state) => const SubjectApplyPage(),
  ),
  GoRoute(
    path: "/posts/:id",
    name: "post_detail",
    builder: (context, state) => PostDetailPage(
      id: state.pathParameters["id"] ?? "0",
    ),
  ),
  GoRoute(
    path: "/create_comment",
    name: "create_comment",
    builder: (context, state) => CreateCommentPage(
      postId: state.uri.queryParameters["post_id"] ?? "0",
      parentId: state.uri.queryParameters["parent_id"] ?? '0',
      parentContent: state.uri.queryParameters["parent_content"] ?? '',
      topId: state.uri.queryParameters['top_id'] ?? '0',
      uname: state.uri.queryParameters['uname'] ?? '',
    ),
  ),
  GoRoute(
    path: "/draft",
    name: "draft",
    builder: (context, state) => const DraftPage(),
  ),
  GoRoute(
    path: "/comments/:id",
    name: "comment_detail",
    builder: (context, state) => CommentDetailPage(
      id: state.pathParameters["id"] ?? "0",
    ),
  ),
  GoRoute(
    path: "/publish",
    name: "publish",
    builder: (context, state) => PublishPage(
      type:
          state.uri.queryParameters["type"] ?? Constants.publishOptionShortText,
      id: state.uri.queryParameters["id"] ?? "0",
    ),
  ),
  GoRoute(
      path: "/select_subject",
      name: "select_subject",
      builder: (context, state) => const SelectSubjectPage()),
  GoRoute(
      path: "/select_at_user",
      name: "select_at_user",
      builder: (context, state) => const SelectAtUserPage()),
  GoRoute(
    path: "/search",
    name: "search",
    // 传入类型user|group|nearby(用户，群组，附近的人),如果不是就弹窗
    builder: (context, state) => SearchPage(
      type: state.uri.queryParameters["type"] ?? "",
    ),
    routes: [
      GoRoute(
        name: "search_results",
        path: "search_results",
        builder: (context, state) => SearchResultListPage(
            type: state.uri.queryParameters['type'] ??
                Constants.postSubTypeShortText),
      ),
    ],
  ),
  GoRoute(
    path: "/users/:id",
    name: "user_detail",
    builder: (context, state) => UserMainPage(
      id: state.pathParameters["id"] ?? "0",
    ),
  ),
  GoRoute(
    path: "/groups/:id",
    name: "group_detail",
    builder: (context, state) => GroupDetailPage(
      id: state.pathParameters["id"] ?? "0",
    ),
    routes: [
      GoRoute(
        path: "admin_list",
        name: "group_admin_list",
        builder: (context, state) => GroupAdminListPage(
          id: state.pathParameters["id"] ?? "0",
        ),
      ),
      GoRoute(
        path: "member_list",
        name: "group_member_list",
        builder: (context, state) => GroupMemberListPage(
          id: state.pathParameters["id"] ?? "0",
        ),
      ),
      GoRoute(
        path: "group_chat",
        name: "group_chat",
        builder: (context, state) => GroupChatPage(
          id: state.pathParameters["id"] ?? "0",
        ),
      ),
    ],
  ),
];
