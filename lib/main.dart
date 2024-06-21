import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socio_sphere/responsive/mobile_screen_layout.dart';
import 'package:socio_sphere/responsive/responsive_layout_screen.dart';
import 'package:socio_sphere/responsive/web_Screen_layout.dart';
import 'package:socio_sphere/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDYiW5ewySrgjZwwvWgf7Jgb1lzoK877_w",
            appId: "1:841268398240:web:244874999c11f271dfa1c5",
            messagingSenderId: "841268398240",
            projectId: "socio-sphere-97215",
            storageBucket: "socio-sphere-97215.appspot.com",));
  } 
  else {
    await Firebase.initializeApp();
  }
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
