import 'package:flutter/material.dart';

class RefreshAndLoadMore extends StatelessWidget {
  final Widget child;
  final Function? onRefresh;
  final Function? onLoadMore;
  const RefreshAndLoadMore({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) {
          onRefresh!();
        }
      },
      displacement: 20,
      color: Colors.red,
      backgroundColor: Colors.orange,
      child: NotificationListener<ScrollNotification>(
        onNotification: (nf) {
          if (nf.metrics.pixels + 30 >= nf.metrics.maxScrollExtent) {
            if (onLoadMore != null) {
              onLoadMore!();
            }
          }
          return false;
        },
        child: child,
      ),
    );
  }
}
