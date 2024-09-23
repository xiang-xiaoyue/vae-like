// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final double size;
  final double radius;
  const CustomAvatar({super.key, this.size = 40, this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        "assets/images/1.jpg",
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class UserAvatar extends StatefulWidget {
  final String url;
  final Function? onTap;
  String? hintText;
  double size;
  double radius;
  UserAvatar({
    super.key,
    required this.url,
    this.hintText,
    this.size = 40,
    this.radius = 8,
    this.onTap,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    var placeholderText = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade300,
        border: Border.all(width: 1, color: Colors.red),
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      width: 20,
      height: 4,
      child: Text(
        widget.hintText ?? "无",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(widget.radius)),
          child: widget.url != ""
              ? Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, err, st) => placeholderText,
                )
              : placeholderText,
        ),
      ),
    );
  }
}
