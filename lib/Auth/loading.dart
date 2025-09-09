import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:desktop_view/animation/animate.dart';
import 'package:desktop_view/CRUD/dashboard.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:win32/win32.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.user});
  final String user;
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double progress = 0.0;
Timer? timer;
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
          });
    } else {
      final pszLogonSound = logonSound.toNativeUtf16();
      final result = PlaySound(pszLogonSound, NULL, SND_FILENAME | SND_ASYNC);

      if (result != TRUE) {
        debugPrint('Sound playback failed.');
      }
      free(pszLogonSound);
    }
  }

   @override
  void initState() {
    super.initState();
    setState(() {
      timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
        if (progress.floorToDouble() == 1.0) {
          timer.cancel();
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacement(ScaleAnimate(
                page: Dashboard(
              userdata: widget.user,
            )));
          });
          progress = 0.0;
        } else {
          if(kDebugMode){
            playSound(context,
                r"assets/audios/database_scan.wav");
          }
          else{
            playSound(context,
                r"data/flutter_assets/assets/audios/database_scan.wav");
          }
          setState(() {
            progress = progress + 0.01;
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        SizedBox(
        width: 200,
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(25),
          ),
        )) ,
      Expanded(
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 160,
              width: 160,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.transparent,
                ]),
              ),
              child: CircularProgressIndicator.adaptive(
                value: progress,
              ),
            ),
            Container(
              height: 160,
              width: 160,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.transparent,
                ]),
              ),
              child: Center(
                  child: Text(
                '${(progress * 100).floor()}%',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              )),
            ),
          ],
        ),
      ),
    ) ,
      ]),
    );
  }
}



