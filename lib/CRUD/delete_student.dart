// ignore_for_file: use_build_context_synchronously

import 'package:oiu_student_desktop/main.dart';
import 'package:flutter/material.dart';
import 'package:oiu_student_desktop/model/modal_data.dart';

class DeleteStudent extends StatefulWidget {
  const DeleteStudent({super.key});

  @override
  State<DeleteStudent> createState() => _StateDeleteStudent();
}

class _StateDeleteStudent extends State<DeleteStudent> {
  Set<int> selectedIndex = {};
  bool isMultiSelectionMode = false;
  void changeSelectionMode() {
    setState(() {
      isMultiSelectionMode = !isMultiSelectionMode;
      if (!isMultiSelectionMode) {
        selectedIndex.clear();
      }
    });
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndex.contains(index)) {
        selectedIndex.remove(index);
      } else {
        selectedIndex.add(index);
      }
    });
  }

  Future deleteMultiple(List<int> ids) async {
    if (ids.isEmpty) {
      return;
    }
    final List<int> sortedList = selectedIndex.toList()..sort();
    for (int i = sortedList.length - 1; i >= 0; i--) {
      final multidelete = List.filled(ids.length, "?").join(",");
      await sqldb.multipleDeleteData("student", "studentid", multidelete, ids);
    }
    selectedIndex.clear();
    isMultiSelectionMode = false;
    setState(() {});
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
                  SizedBox(height: 10),
                  Text(
                    "No Data",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                if (isMultiSelectionMode)
                  IconButton(
                    onPressed: () async {
                      List<int> ids = selectedIndex.toList();
                      await deleteMultiple(selectedIndex.toList());
                      studentdb = await sqldb.readData(
                        "SELECT * FROM `student` Group By `studentname`",
                      );
                      setState(() {});
                      SnackBar snackBar = SnackBar(
                        content: Text("Deleted ${ids.length} Successfully "),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                IconButton(
                  onPressed: changeSelectionMode,
                  icon: Icon(
                    isMultiSelectionMode
                        ? Icons.close
                        : Icons.select_all_rounded,
                  ),
                ),
              ],
            ),
            body: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Image.asset('assets/images/icons8-remove-641.png'),
                        const Text(
                          'Delete Students',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: studentdb.length,
                      itemBuilder: (context, i) {
                        bool isSelected = selectedIndex.contains(
                          studentdb[i]['studentid'],
                        );
                        return ListTile(
                          onLongPress: () {
                            changeSelectionMode();
                            toggleSelection(studentdb[i]['studentid']);
                          },
                          onTap: () {
                            if (isMultiSelectionMode) {
                              toggleSelection(studentdb[i]['studentid']);
                            } else {}
                          },
                          tileColor: isSelected ? Colors.blue : null,
                          leading: isMultiSelectionMode
                              ? Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? v) {
                                    setState(() {
                                      toggleSelection(
                                        studentdb[i]['studentid'],
                                      );
                                    });
                                  },
                                )
                              : null,
                          title: Container(
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
                                const SizedBox(width: 60),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.account_box, size: 45),
                                ),
                                const SizedBox(width: 44),
                                Text(
                                  '${studentdb[i]['studentname']}',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
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
              ],
            ),
          );
  }
}

bool visible = false;
