import 'package:flutter/material.dart';
import 'package:trump/components/index.dart';

//图集页面
class AtlasPage extends StatelessWidget {
  const AtlasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "图集"),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: EdgeInsets.all(16),
        primary: false,
        shrinkWrap: true,
        children: const [
          _AtlasItem(),
          _AtlasItem(),
          _AtlasItem(),
          _AtlasItem(),
          _AtlasItem(),
          _AtlasItem(),
          _AtlasItem(),
          _AtlasItem(),
        ],
      ),
    );
  }
}

class _AtlasItem extends StatelessWidget {
  const _AtlasItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //Image.asset(, fit: BoxFit.cover),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/2.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "呼吸之野，太原站高清图集",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                "13",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
