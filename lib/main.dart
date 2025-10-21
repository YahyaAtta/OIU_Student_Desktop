import 'package:oiu_student_desktop/model/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:oiu_student_desktop/Auth/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Sqldb sqldb = Sqldb();
SharedPreferences? sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
    );
  }
}
