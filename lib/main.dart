import 'package:flutter/material.dart';
import 'package:jobtrackeremployee/providers/change_pass_provider.dart';
import 'package:jobtrackeremployee/providers/job_provider.dart';
import 'package:jobtrackeremployee/providers/login_provider.dart';
import 'package:jobtrackeremployee/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
    ChangeNotifierProvider<JobProvider>(create: (_) => JobProvider()),
    ChangeNotifierProvider<ChangePassProvider>(
        create: (_) => ChangePassProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Poppins"),
      home: SplashScreen(),
    );
  }
}
