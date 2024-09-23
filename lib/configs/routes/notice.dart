import 'package:go_router/go_router.dart';
import 'package:trump/pages/notice/export.dart';

List<GoRoute> noticeRoutes = [
  GoRoute(
    path: "contacts",
    name: "contacts",
    builder: (context, state) => const ContactsPage(),
  ),
  GoRoute(
    path: "official_notice",
    name: "official_notice",
    builder: (context, state) => const OfficialNoticePage(),
  ),
  GoRoute(
    path: "at_me_notice",
    name: "at_me_notice",
    builder: (context, state) => const AtMeNoticePage(),
  ),
  GoRoute(
    path: "comment_notice",
    name: "comment_notice",
    builder: (context, state) => const CommentNoticePage(),
  ),
  GoRoute(
    path: "like_notice",
    name: "like_notice",
    builder: (context, state) => const LikeNoticePage(),
  ),
];
