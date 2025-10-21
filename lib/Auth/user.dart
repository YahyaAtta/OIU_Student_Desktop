// ignore_for_file: use_build_context_synchronously
import 'package:oiu_student_desktop/Auth/login.dart';
import 'package:oiu_student_desktop/animation/animate.dart';
import 'package:oiu_student_desktop/main.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

class UserInfo extends StatefulWidget {
  final String username;
  const UserInfo({required this.username, super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  void deleteAccount() async {
    sharedPreferences!.clear();
    Navigator.of(
      context,
    ).pushAndRemoveUntil(ScaleAnimate(page: const Login()), (route) => false);
    await Future.delayed(Duration(seconds: 2), () async {
      await sqldb.mydeleteDatabase();
      ExitProcess(0);
    });
  }

  void showMessageDialogWindows({
    required String messageTitle,
    required String message,
    int messageType = MB_ICONERROR,
    int actions = MB_OK,
    int secondButton = MB_DEFBUTTON2,
  }) {
    final title = TEXT(messageTitle);
    final msg = TEXT(message);
    final result = MessageBox(
      NULL,
      msg,
      title,
      messageType | actions | secondButton,
    );
    switch (result) {
      case IDYES:
        deleteAccount();
      case IDNO:
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Information")),
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
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Image.asset("assets/images/icons8-male-user-96.png"),
                  const Text(
                    "User Information",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  const CircleAvatar(radius: 70),
                  Text(
                    widget.username,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () async {
                        showMessageDialogWindows(
                          messageTitle: "Message",
                          message: "Are You Sure to Reset App And Exit App?",
                          messageType: MB_ICONWARNING,
                          actions: MB_YESNO,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 35,
                        ),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                      ),
                      child: const Text("Reset App"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
