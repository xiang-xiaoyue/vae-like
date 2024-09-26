import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trump/configs/const.dart';
import 'package:trump/configs/routes/index.dart';
import 'package:trump/pages/mine/vm.dart';
import 'package:trump/pages/notice/vm.dart';
import 'package:trump/service/dio_instance.dart';
import 'package:trump/vm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioInstance.instance().initDio(baseUrl: TrumpCommon.baseURL);

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrentUserViewModel>(
          lazy: false,
          create: (_) => CurrentUserViewModel.initProfile(),
        ),
        ChangeNotifierProvider(create: (_) => GlobalViewModel()),
        ChangeNotifierProvider(create: (_) => NoticeIndexViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

GoRouter _router = GoRouter(
  routes: routes,
  initialLocation: "/",
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalViewModel>(builder: (context, global, _) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'wk',
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.white,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Constants.backgroundColor,
          cardTheme: const CardTheme(color: Colors.white),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
        ),
        title: "trump chat",
        routerConfig: _router,
      );
    });
  }
}
