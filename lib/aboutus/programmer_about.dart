import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   String images = 'assets/images';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Row(children: [
       SizedBox(
      width: 200,
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(25),
        ),
        height: double.infinity,
        padding: const EdgeInsets.only(top: 150),
        child: Column(
          children: [
            Image.asset(
              '$images/icons8-male-user-96.png',
              cacheHeight: 85,
              cacheWidth: 85,
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              'Programmer',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ) ,
    Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('$images/OIU.png',
                    cacheHeight: 150, cacheWidth: 150),
                Image.asset('$images/OIU.FCSIT.png',
                    cacheHeight: 150, cacheWidth: 150)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Image.asset(
                '$images/Personal.png',
                cacheHeight: 220,
                cacheWidth: 220,
              ),
              const Text('YAHYA ATTA',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'Omdurman Islamic University',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ]),
      ),
    ) ,
      
      ]),
    );
  }
}

