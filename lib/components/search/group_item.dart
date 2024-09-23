import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trump/components/avatar.dart';
import 'package:trump/models/resp/models/group_simple.dart';

class SearchGroupItem extends StatelessWidget {
  final GroupSimple gs;
  const SearchGroupItem({required this.gs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("group_detail",
            pathParameters: {"id": gs.id.toString()});
      },
      child: Container(
        height: 64,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserAvatar(url: gs.cover, size: 46, radius: 4),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gs.name,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    gs.brief,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            //Spacer(),
            Text(
              "${gs.memberCount}/${gs.capacity}",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
