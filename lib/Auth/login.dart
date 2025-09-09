// ignore_for_file: use_build_context_synchronously

import 'package:desktop_view/Auth/loading.dart';
import 'package:desktop_view/Auth/register.dart';
import 'package:desktop_view/animation/animate.dart';
import 'package:desktop_view/aboutus/programmer_about.dart';
import 'package:desktop_view/main.dart';
import 'package:desktop_view/model/modal_data.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

void showMessageWin({required String msgTitle , required String msg ,int messageType = MB_ICONERROR , int actions =MB_OK , int secondButton = MB_DEFBUTTON2}){
  final title = TEXT(msgTitle);
  final message = TEXT(msg);
  final result = MessageBox(
      NULL,
      message,
      title,
      messageType | // Warning
      actions | // Action button
      secondButton// Second button is the default
  );
  free(message);
  free(title);
}
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
String username = "";
class _LoginState extends State<Login> {
 
  @override
  void initState() {
    super.initState();
  }

  bool isVisible = true;

  String password = "";
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  validData() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      studentlogindb = await sqldb.readData(
          '''SELECT * FROM `users` WHERE `username` ="$username" And `password`="$password"''');

      if (studentlogindb!.isEmpty) {
              showMessageWin(msgTitle: "Error", msg: "Wrong Username Or Password") ;
              setState(() {

              });
        username = "";
        password = "";
      } else {
        sharedPreferences!.setString("username",studentlogindb![0]['username']);
        sharedPreferences!.setInt("userid", studentlogindb![0]['id']);
        Navigator.of(context).pushReplacement(ScaleAnimate(
            page: LoadingPage(
          user: username,
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(ScaleAnimate(page: const MyWidget()));
            },
            icon: const Icon(
              Icons.info_outline_rounded,
              size: 35,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.only(top: 200),
              child: const Column(
                children: [
                  Text(
                    'Username:',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    'Password:',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: formstate,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 60,
                    ),
                    const Text("Login User",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 75,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return 'Cannot be Empty';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          username = val!;
                        },
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: false,
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 43,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return 'Cannot be Empty';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          password = val!;
                        },
                        obscureText: isVisible, // char to **** true
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye_rounded),
                          ),
                          contentPadding: const EdgeInsets.all(15),
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: validData,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18.5),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            ScaleAnimate(page: const Register()));
                      },
                      child: const Text("Don't Have Account ? Register",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
