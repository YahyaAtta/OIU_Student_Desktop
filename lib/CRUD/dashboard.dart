// import 'package:audioplayers/audioplayers.dart';
import 'package:oiu_student_desktop/Auth/login.dart';
import 'package:oiu_student_desktop/Auth/user.dart';
import 'package:oiu_student_desktop/CRUD/add_student.dart';
import 'package:oiu_student_desktop/CRUD/delete_student.dart';
import 'package:oiu_student_desktop/CRUD/update_students.dart';
import 'package:oiu_student_desktop/animation/animate.dart';
import 'package:oiu_student_desktop/CRUD/read_student.dart';
import 'package:oiu_student_desktop/filter/search_student.dart';
import 'package:oiu_student_desktop/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

void signOut(BuildContext context) {
  sharedPreferences!.clear();
  Navigator.of(
    context,
  ).pushAndRemoveUntil(ScaleAnimate(page: const Login()), (route) => false);
  if (kDebugMode) {
    playSound(context, r"assets/audios/logoff.wav");
  } else {
    playSound(context, r"data/flutter_assets/assets/audios/logoff.wav");
  }
}

void showMessageLogout({
  required String msgTitle,
  required String msg,
  int messageType = MB_ICONINFORMATION,
  int actions = MB_YESNO,
  int secondButton = MB_DEFBUTTON2,
  required BuildContext context,
}) {
  final title = TEXT(msgTitle);
  final message = TEXT(msg);
  final result = MessageBox(
    NULL,
    message,
    title,
    messageType | // Warning
        actions | // Action button
        secondButton, // Second button is the default
  );
  switch (result) {
    case IDYES:
      signOut(context);
    case IDNO:
      debugPrint("Button Pressed");
  }
  free(message);
  free(title);
}

playSound(BuildContext context, String path) async {
  var logonSound = path;
  final file = File(logonSound).existsSync();

  if (!file) {
    File f = File(logonSound);
    debugPrint('WAV file missing.');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Message"),
          content: Text("WAV File Missing\nFile Path:${f.path}"),
        );
      },
    );
  } else {
    final pszLogonSound = logonSound.toNativeUtf16();
    final result = PlaySound(pszLogonSound, NULL, SND_FILENAME | SND_ASYNC);

    if (result != TRUE) {
      debugPrint('Sound playback failed.');
    }
    free(pszLogonSound);
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.userdata});
  final String userdata;
  @override
  State<Dashboard> createState() => _DashboardState();
}

bool visible = false;

class _DashboardState extends State<Dashboard> {
  String images = 'assets/images';
  bool onLoading = true;
  elementVisible() async {
    setState(() {
      onLoading = true;
    });
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        onLoading = false;
      });
    });
  }

  String username = '';
  getUser() async {
    setState(() {
      visible = true;
      username = widget.userdata;
    });
    if (kDebugMode) {
      playSound(context, r"assets/audios/startup.wav");
    } else {
      playSound(context, r"data/flutter_assets/assets/audios/startup.wav");
    }
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        visible = false;
      });
    });
  }

  @override
  void initState() {
    getUser();
    elementVisible();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Image.asset('assets/images/icons8-student-64.png'),
                  const Text(
                    'OIU Student',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Visibility(
                    visible: visible,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: const Text(
                      'Loading......',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  visible == true
                      ? const Center(
                          child: InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.black38,
                              radius: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  ScaleAnimate(
                                    page: UserInfo(
                                      username: sharedPreferences!.getString(
                                        "username",
                                      )!,
                                    ),
                                  ),
                                );
                              },
                              child: const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black38,
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  size: 70,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Welcome ${sharedPreferences!.getString("username")}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                  Container(
                    padding: const EdgeInsets.only(top: 230),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        onPressed: onLoading == true
                            ? null
                            : () {
                                showMessageLogout(
                                  context: context,
                                  msgTitle: "Message",
                                  msg: "Are you sure to sign out? ",
                                );
                              },
                        child: Image.asset(
                          'assets/images/icons8-logout-rounded-left-64.png',
                        ),
                      ),
                    ),
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
                children: [
                  InkWell(
                    onTap: onLoading == true
                        ? null
                        : () {
                            Navigator.of(
                              context,
                            ).push(ScaleAnimate(page: const ReadStudent()));
                          },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: 110,
                      width: 450,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        gradient: const LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Color.fromARGB(255, 16, 11, 9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 60),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              '$images/icons8-student-642.png',
                            ),
                          ),
                          const SizedBox(width: 44),
                          const Text(
                            'Show Students',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onLoading == true
                        ? null
                        : () {
                            Navigator.of(
                              context,
                            ).push(ScaleAnimate(page: const AddStudent()));
                          },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 110,
                      width: 450,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        gradient: const LinearGradient(
                          colors: [
                            Colors.deepOrangeAccent,
                            Color.fromARGB(255, 16, 11, 9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 60),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset('$images/icons8-add-64.png'),
                          ),
                          const SizedBox(width: 40),
                          const Text(
                            'Add Student Record',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onLoading == true
                        ? null
                        : () {
                            Navigator.of(
                              context,
                            ).push(ScaleAnimate(page: const UpdateStudents()));
                          },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 110,
                      width: 450,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        gradient: const LinearGradient(
                          colors: [
                            Colors.greenAccent,
                            Color.fromARGB(255, 16, 11, 9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 60),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset('$images/icons8-update-64.png'),
                          ),
                          const SizedBox(width: 30),
                          const Text(
                            'Update Student Record',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onLoading == true
                        ? null
                        : () {
                            Navigator.of(
                              context,
                            ).push(ScaleAnimate(page: const DeleteStudent()));
                          },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 110,
                      width: 450,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        gradient: const LinearGradient(
                          colors: [Colors.red, Color.fromARGB(255, 16, 11, 9)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 60),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset('$images/icons8-remove-641.png'),
                          ),
                          const SizedBox(width: 44),
                          const Text(
                            'Delete Student Record',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onLoading == true
                        ? null
                        : () {
                            Navigator.of(
                              context,
                            ).push(ScaleAnimate(page: const SearchStudent()));
                          },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 110,
                      width: 450,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        gradient: const LinearGradient(
                          colors: [
                            Colors.blueGrey,
                            Color.fromARGB(255, 16, 11, 9),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 60),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset('$images/icons8-search-64.png'),
                          ),
                          const SizedBox(width: 44),
                          const Text(
                            'Search Students',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
