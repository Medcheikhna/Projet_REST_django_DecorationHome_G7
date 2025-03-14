import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants.dart';
import '/screens/onboarding/onboarding_screen.dart';
import '/screens/splashWindow/splash_window.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) {
    //     return Cart();
    //   },
    return
        // child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furniture App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme:
            GoogleFonts.dmSansTextTheme().apply(displayColor: kTextColor),
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
    // );
  }
}
