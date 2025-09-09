import 'package:desktop_view/CRUD/details.dart';
import 'package:desktop_view/animation/animate.dart';
import 'package:flutter/material.dart';
import 'package:desktop_view/model/modal_data.dart';
int selectedItem = 0;
String text = "Student name";
class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 30),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filter = [];
    if (selectedItem == 0) {
      filter = studentdb
          .where((element) => element['studentname'].startsWith(query))
          .toList();
    } else if (selectedItem == 1) {
      filter = studentdb
          .where(
              (element) => element['universityid'].toString().startsWith(query))
          .toList();
    } else if (selectedItem == 2) {
      filter = studentdb
          .where((element) => element['facultydep'].startsWith(query))
          .toList();
    } else {
      filter = studentdb
          .where((element) => element['universityYear'].startsWith(query))
          .toList();
    }

    if (query == "") {
      return Container(
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
                      Colors.deepPurple,
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
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: filter.length,
          itemBuilder: (context, i) {
            return InkWell(
              radius: 100,
              onTap: () {
                Navigator.of(context).push(ScaleAnimate(
                    page: Details(
                  dataInfo: filter[i],
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
                      Colors.deepPurple,
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
                      '${filter[i]['studentname']}',
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

class SearchStudent extends StatefulWidget {
  const SearchStudent({super.key});

  @override
  State<SearchStudent> createState() => _StateSearchStudent();
}

class _StateSearchStudent extends State<SearchStudent> {
  @override
  void initState() {
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
            appBar: AppBar(
              actions: [
                Text("Search By $text"),
                PopupMenuButton(
                    onSelected: (val) {},
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: const Text("Student name"),
                          onTap: () {
                            selectedItem = 0;
                            setState(() {
                              text = "Student name";
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("University ID"),
                          onTap: () {
                            selectedItem = 1;
                            setState(() {
                              text = "University ID";
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("Department"),
                          onTap: () {
                            selectedItem = 2;
                            setState(() {
                              text = "Department";
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: const Text("University Year"),
                          onTap: () {
                            selectedItem = 3;
                            setState(() {
                              text = "University Year";
                            });
                          },
                        ),
                      ];
                    }),
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: Search());
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 30,
                    ))
              ],
            ),
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
                        Image.asset('assets/images/icons8-search-64.png'),
                        const Text(
                          'Search Students',
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
                  padding: const EdgeInsets.all(20),
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
                          padding: const EdgeInsets.only(top: 14, left: 12),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.account_box,
                                      size: 45,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  Text(
                                    '${studentdb[i]['studentname']}',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: selectedItem == 0
                                      ? const Text(
                                          '...........',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : selectedItem == 1
                                          ? Text(
                                              studentdb[i]['universityid']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : selectedItem == 2
                                              ? Text(
                                                  studentdb[i]['facultydep'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              : Text(
                                                  studentdb[i]
                                                      ['universityYear'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                ),
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
