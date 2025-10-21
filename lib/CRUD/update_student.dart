// ignore_for_file: use_build_context_synchronously

import 'package:oiu_student_desktop/main.dart';
import 'package:flutter/material.dart';

import '../model/modal_data.dart';

class UpdateStudent extends StatefulWidget {
  final Map data;
  const UpdateStudent({required this.data, super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String? edituniversityid;

  String? editbirthday;

  String? editfaculty;

  String? editfacultydep;

  String? edituniversityYear;

  String? editskill;
  updateStudent() async {
    if (formstate.currentState!.validate()) {
      formstate.currentState!.save();
      int response = await sqldb.updateData('''
UPDATE `student` SET `studentname` ="$editstudentname" ,`universityid`=$edituniversityid,
`birthday` =$editbirthday ,`facultydep` ="$editfacultydep" ,
`universityYear` = "$edituniversityYear" ,`skill`="$editskill" WHERE studentid = ${widget.data['studentid']}
''');

      if (response > 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Update Student Successfully"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  void initState() {
    editfacultydep = widget.data['facultydep'];
    edituniversityYear = widget.data['universityYear'];
    super.initState();
  }

  String? editstudentname;

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
                  Image.asset('assets/images/icons8-add-64.png'),
                  const Text(
                    'Update Student',
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
            child: Form(
              key: formstate,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: TextFormField(
                      initialValue: widget.data['studentname'],
                      onSaved: (val) {
                        editstudentname = val;
                      },
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Update student Name',

                        // errorText: 'Error!',
                        // errorStyle: TextStyle(fontSize: 21),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.account_box_rounded, size: 40),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: widget.data['universityid'].toString(),
                      onSaved: (val) {
                        edituniversityid = val;
                      },
                      style: const TextStyle(fontSize: 19),
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Update University ID',
                        // errorText: 'Error!',
                        // errorStyle: TextStyle(fontSize: 21),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.numbers_rounded, size: 40),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: TextFormField(
                      onSaved: (val) {
                        editbirthday = val;
                      },
                      initialValue: widget.data['birthday'].toString(),
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Update Birthday',

                        // errorText: 'Error!',
                        // errorStyle: TextStyle(fontSize: 21),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.numbers_rounded, size: 40),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  DropdownButton(
                    value: editfacultydep,
                    alignment: Alignment.topLeft,
                    isExpanded: true,
                    hint: const Text("Please Choose Your Department"),
                    items: [
                      'Computer Science',
                      'Information Technology',
                      'Information System'
                    ]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (c) {
                      setState(() {
                        editfacultydep = c!;
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: DropdownButton(
                      value: edituniversityYear,
                      alignment: Alignment.topLeft,
                      isExpanded: true,
                      hint: const Text("Please Choose University Year"),
                      items: [
                        'First Year',
                        'Secondary Year',
                        'Third Year',
                        'Fourth Year',
                        'Fifth Year'
                      ]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (c) {
                        setState(() {
                          edituniversityYear = c!;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: TextFormField(
                      initialValue: widget.data['skill'],
                      onSaved: (val) {
                        editskill = val;
                      },
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Update Skill',
                        // errorText: 'Error!',
                        // errorStyle: TextStyle(fontSize: 21),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.computer_rounded, size: 40),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: MaterialButton(
                      onPressed: () async {
                        updateStudent();
                        studentdb = await sqldb.readData(
                            "SELECT * FROM `student` Group By `studentname`");
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      color: Colors.purple.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: const Text("Update Student Record"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
