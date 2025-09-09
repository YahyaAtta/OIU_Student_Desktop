import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Map dataInfo;
  const Details({super.key, required this.dataInfo});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(children: [
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
                  Image.asset('assets/images/icons8-student-642.png'),
                  const Text(
                    'Student Details',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: double.infinity,
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/OIU.png",
                        height: 150,
                        width: 150,
                      ),
                      Column(
                        children: [
                          const Text("Omdurman Islamic University",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                          Text("Faculty Of ${widget.dataInfo['faculty']}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text("Department ${widget.dataInfo['facultydep']}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Image.asset(
                        "assets/images/OIU.FCSIT.png",
                        height: 150,
                        width: 150,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(
                          Icons.account_box_rounded,
                          size: 100,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Student Name: ${widget.dataInfo['studentname']}",
                              style: const TextStyle(
                                fontSize: 22,
                              )),
                          Text("Student ID: ${widget.dataInfo['universityid']}",
                              style: const TextStyle(fontSize: 22)),
                          Text(
                              "Student Year: ${widget.dataInfo['universityYear']}",
                              style: const TextStyle(fontSize: 22)),
                          Text(
                              "Student Birthday: ${widget.dataInfo['birthday']}",
                              style: const TextStyle(fontSize: 22)),
                          Text("Student Skill: ${widget.dataInfo['skill']}",
                              style: const TextStyle(fontSize: 22)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

bool visible = false;
