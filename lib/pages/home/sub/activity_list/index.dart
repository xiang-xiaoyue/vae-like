import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/app_bar.dart';
import 'package:trump/pages/home/components/trip_or_activity.dart';
import 'package:trump/pages/home/sub/activity_list/vm.dart';

class ActivityListPage extends StatelessWidget {
  const ActivityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "活动"),
      body: ChangeNotifierProvider<ActivityListViewModel>(
        create: (context) => ActivityListViewModel(),
        child: Consumer<ActivityListViewModel>(builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.activityCount,
            itemBuilder: (context, index) {
              return TripOrActivityItem(post: vm.activities[index]);
            },
          );
        }),
      ),
    );
  }
}
