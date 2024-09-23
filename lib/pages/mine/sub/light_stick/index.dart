import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:trump/components/index.dart';

// 进入此页面，把手机当荧光棒用
class MineLightStickPage extends StatelessWidget {
  const MineLightStickPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentBrightness = 0;
    ScreenBrightness().current.then((r) {
      currentBrightness = r;
    });
    Future<void> setBrightness(double brightness) async {
      try {
        await ScreenBrightness().setScreenBrightness(brightness);
      } catch (e) {}
    }

    return Scaffold(
      backgroundColor: Color(0xffea5503), //#6ca5ff
      body: PopScope(
        onPopInvoked: (v) {
          setBrightness(currentBrightness);
        },
        child: FutureBuilder(
            future: setBrightness(1),
            builder: (context, sh) {
              return SafeArea(
                child: Center(
                  child: KeepAliveWrapper(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "荧光棒",
                          style: TextStyle(
                            fontSize: 52,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        TrumpButton(
                          text: "返回",
                          width: 80,
                          height: 40,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          borderStyle: BorderStyle.none,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
