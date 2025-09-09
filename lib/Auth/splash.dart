import 'package:desktop_view/Auth/login.dart';
import 'package:desktop_view/CRUD/dashboard.dart';
import 'package:desktop_view/animation/animate.dart';
import 'package:desktop_view/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    sqldb.initWinDB();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(ScaleAnimate(page: sharedPreferences!.getString("username") !=null ? Dashboard(userdata: username) :const Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.school_rounded,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
