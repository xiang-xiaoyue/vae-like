import 'package:flutter/material.dart';

// 弹出提示
class CustomToast extends StatefulWidget {
  final String text;
  final Duration duration;
  final Duration transitionDuration;
  const CustomToast({
    super.key,
    required this.text,
    this.duration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 250),
  });

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController opacity;

  @override
  void initState() {
    super.initState();
    opacity = AnimationController(
      vsync: this,
      duration: widget.transitionDuration,
    )..forward();

    final startFadeOutAt = widget.duration - widget.transitionDuration;
    Future.delayed(startFadeOutAt, opacity.reverse);
  }

  @override
  void dispose() {
    opacity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Align(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.65),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.sizeOf(context).height * 0.375),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension ToastExtension on BuildContext {
  void showToast(
    String text, {
    Duration duration = const Duration(seconds: 3),
    Duration transitionDuration = const Duration(milliseconds: 250),
  }) {
    final overlayState = Overlay.of(this);
    final toast = OverlayEntry(
      builder: (_) => CustomToast(
        text: text,
        duration: duration,
        transitionDuration: transitionDuration,
      ),
    );
    overlayState.insert(toast);
    Future.delayed(duration, toast.remove);
  }
}
