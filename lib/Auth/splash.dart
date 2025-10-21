// ignore_for_file: use_build_context_synchronously

import 'package:oiu_student_desktop/Auth/login.dart';
import 'package:oiu_student_desktop/CRUD/dashboard.dart';
import 'package:oiu_student_desktop/animation/animate.dart';
import 'package:oiu_student_desktop/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    sqldb.initWinDB();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        ScaleAnimate(
          page: sharedPreferences!.getString("username") != null
              ? Dashboard(userdata: username)
              : const Login(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: Icon(Icons.school_rounded, size: 100))],
      ),
    );
  }
}
