import 'package:flutter/material.dart';
import 'package:desktop_view/model/modal_data.dart';

class AddStudent extends StatefulWidget {
  @override
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
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
                    'Add Student',
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Fill this Field";
                        }
                        return null;
                      },
                      controller: studentname,
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Enter Student Name',
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
                      maxLength: 10,
                      controller: universityid,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Fill this Field";
                        }

                        if (val.length < 10) {
                          return "University ID Must be At least 10";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Enter University ID',
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
                      controller: birthday,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Fill this Field";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Enter Birthday',
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
                    value: facultydep,
                    alignment: Alignment.topLeft,
                    isExpanded: true,
                    hint: const Text("Please Choose Your Department"),
                    items: [
                    'Computer Science' , 'Information Technology' , 'Information System'
                  ].map((e) => DropdownMenuItem(value: e,child: Text(e) ,)).toList(),
onChanged: (c){
setState(() {
  facultydep = c! ;
});
},
                  ) ,
                  // Container(
                  //   margin: const EdgeInsets.all(12),
                  //   child: TextFormField(
                  //     validator: (val) {
                  //       if (val!.isEmpty) {
                  //         return "Please fill field";
                  //       }
                  //       return null;
                  //     },
                  //     controller: facultydep,
                  //     style: const TextStyle(fontSize: 19),
                  //     decoration: InputDecoration(
                  //       hintText: 'Enter Faculty Department',
                  //       // errorText: 'Error!',
                  //       // errorStyle: TextStyle(fontSize: 21),
                  //       prefixIcon: const Padding(
                  //         padding: EdgeInsets.all(12.0),
                  //         child: Icon(Icons.school, size: 40),
                  //       ),
                  //       contentPadding: const EdgeInsets.all(20),
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.all(12),
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Fill this Field";
                        }
                        return null;
                      },
                      controller: universityYear,
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Enter University Year',
                        // errorText: 'Error!',
                        // errorStyle: TextStyle(fontSize: 21),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.school, size: 40),
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Fill this Field";
                        }
                        return null;
                      },
                      controller: skill,
                      style: const TextStyle(fontSize: 19),
                      decoration: InputDecoration(
                        hintText: 'Enter Skill',
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

                      onPressed: () {
                        AppLogic.addStudent();

                        formstate.currentState!.reset() ;
                        setState(() {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Added Student Successfully"),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ));
                          studentname.text = "" ;
                          universityid.text = "" ;
                          birthday.text = "" ;
                          facultydep = null ;
                        });
                      },
                      color:Colors.purple.shade900 ,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: const Text("Add Student Record"),
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
