import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stisla_application_with_flutter/pages/landingPage.dart';
import 'package:stisla_application_with_flutter/pages/loginPage.dart';
import 'package:stisla_application_with_flutter/pages/registerPage.dart';
import 'package:stisla_application_with_flutter/pages/homePage.dart';
import 'package:stisla_application_with_flutter/pages/landingHomePage.dart';
import 'package:stisla_application_with_flutter/pages/profilePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const LandingPage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/main": (context) => const LandingHome(),
        "/mainhome": (context) => const HomePage(),
        "/mainprofil": (context) => const ProfilePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
