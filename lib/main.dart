import 'package:flutter/material.dart';
import 'package:socio_sphere/responsive/mobile_screen_layout.dart';
import 'package:socio_sphere/responsive/responsive_layout_screen.dart';
import 'package:socio_sphere/responsive/web_Screen_layout.dart';
import 'package:socio_sphere/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socio Sphere',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const ResponsiveLayout(
        webScreenLayout: WebScreenLayout(),
        mobileScreenLayout: MobileScreenLayout(),
      ),
    );
  }
}
