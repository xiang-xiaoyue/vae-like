// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trump/components/index.dart';
import 'package:trump/pages/home/components/trip_or_activity.dart';
import 'package:trump/pages/home/sub/trip_list/vm.dart';

// 行程列表页面
// todo：只展示今年的
// 按月分分割展示
class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "行程"),
      body: ChangeNotifierProvider<TripListViewModel>(
        create: (context) => TripListViewModel(),
        child: Consumer<TripListViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.tripCount,
                    itemBuilder: (context, index) {
                      return TripOrActivityItem(
                        post: vm.trips[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
