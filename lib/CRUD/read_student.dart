import 'package:desktop_view/CRUD/details.dart';
import 'package:desktop_view/animation/animate.dart';
import 'package:desktop_view/main.dart';
import 'package:flutter/material.dart';
import 'package:desktop_view/model/modal_data.dart';

class ReadStudent extends StatefulWidget {
  const ReadStudent({super.key});

  @override
  State<ReadStudent> createState() => _StateReadStudent();
}

class _StateReadStudent extends State<ReadStudent> {
  readData() async {
    studentdb =
        await sqldb.readData("SELECT * FROM `student` Group By `studentname`");
    setState(() {
      studentdb;
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return studentdb.isEmpty
        ? Scaffold(
            appBar: AppBar(),
            body: const Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.data_array_rounded, size: 100),
                SizedBox(
                  height: 10,
                ),
                Text("No Data",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
              ],
            )),
          )
        : Scaffold(
            appBar: AppBar(),
            body: Row(children: [
              SizedBox(
                  width: 200,
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Image.asset('assets/images/icons8-student-642.png'),
                        const Text(
                          'Show Students',
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
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
                  child: ListView.builder(
                    itemCount: studentdb.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        radius: 100,
                        onTap: () {
                          Navigator.of(context).push(ScaleAnimate(
                              page: Details(
                            dataInfo: studentdb[i],
                          )));
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
                                Color.fromARGB(255, 71, 32, 176),
                                Color.fromARGB(255, 16, 11, 9),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 60,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.account_box,
                                  size: 45,
                                ),
                              ),
                              const SizedBox(
                                width: 44,
                              ),
                              Text(
                                '${studentdb[i]['studentname']}',
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          );
  }
}

bool visible = false;
