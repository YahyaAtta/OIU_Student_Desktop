// ignore_for_file: use_build_context_synchronously

import 'package:desktop_view/Auth/login.dart';
import 'package:desktop_view/animation/animate.dart';
import 'package:desktop_view/main.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisible2 = true;

  @override
  void initState() {
    sqldb.initWinDB();
    super.initState();
  }

  bool isVisible = true;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController retypepassword = TextEditingController();

  List? studentlogindb;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  validData() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      int response = await sqldb.createData('''
INSERT INTO `users`(`email`,`username`,`password`,`retypepassword`) VALUES
("${email.text}","${username.text}","${password.text}","${retypepassword.text}")
''');
      if (response >= 1) {
        var snackBar = const SnackBar(
          content: Text("Register Successfully"),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context)
            .pushReplacement(ScaleAnimate(page: const Login()));
      }
    }
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    retypepassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                children: [],
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: formstate,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 2,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 60,
                    ),
                    const Text("Register User",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: username,
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return 'Cannot be Empty';
                          }

                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Enter Username',
                          filled: false,
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: email,
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return 'Cannot be Empty';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: 'Enter Email',
                          filled: false,
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: password,
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return 'Cannot be Empty';
                          }
                          if (retypepassword.text != valid) {
                            return "Password not match";
                          }
                          return null;
                        },

                        obscureText: isVisible, // char to **** true
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_rounded),
                          hintText: "Enter Password",
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
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        controller: retypepassword,
                        style: const TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                        validator: (valid) {
                          if (valid!.isEmpty) {
                            return 'Cannot be Empty';
                          }
                          if (password.text != valid) {
                            return "Password not match";
                          }
                          return null;
                        },

                        obscureText: isVisible2, // char to **** true
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_rounded),
                          hintText: "Enter RetypePassword",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible2 = !isVisible2;
                              });
                            },
                            icon: Icon(isVisible2
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
                      height: 10,
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
                        'Register',
                        style: TextStyle(fontSize: 18.5),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacement(ScaleAnimate(page: const Login()));
                      },
                      child: const Text("Don't Have Account ? Login",
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
