import 'package:trump/pages/home/export.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> homeRoutes = [
  GoRoute(
    name: "hot_user_content_list",
    path: "hot_user_content_list",
    builder: (context, state) => const HotUserContentPage(),
  ),
  GoRoute(
    name: "work_list",
    path: "work_list",
    builder: (context, state) => const WorkListPage(),
  ),
  GoRoute(
    name: "trip_list",
    path: "trip_list",
    builder: (context, state) => const TripListPage(),
  ),
  GoRoute(
    name: "activity_list",
    path: "activity_list",
    builder: (context, state) => const ActivityListPage(),
  ),
  GoRoute(
    name: "video_list",
    path: "video_list",
    builder: (context, state) => const VideoListPage(),
  ),
  GoRoute(
    name: "atlas",
    path: "atlas",
    builder: (context, state) => const AtlasPage(),
  ),
];
