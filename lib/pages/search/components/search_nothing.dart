import 'package:flutter/material.dart';

class SearchNothing extends StatelessWidget {
  final String text;
  const SearchNothing({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_outlined,
              size: 140,
              color: Colors.grey,
            ),
            Text(
              text,
              softWrap: true,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
