import 'package:desktop_view/main.dart';
import 'package:flutter/material.dart';

// List<Map> studentNames = [
//   {
//     'Name': 'Ali Abdallah',
//     'Faculty': 'Computer Science and Information Technology',
//     'Department': 'Computer Science(CS)',
//     'Skill': 'Senior Flutter Developer ',
//   },
//   {
//     'Name': 'AbuQasim Mohammed',
//     'Faculty': 'Computer Science and Information Technology',
//     'Department': 'Computer Science(CS)',
//     'Skill': 'Flutter Developer',
//   },
//   {
//     'Name': 'Sharaf Aldeen ',
//     'Faculty': 'Computer Science and Information Technology',
//     'Department': 'Computer Science(CS)',
//     'Skill': 'Web Developer And Designer',
//   },
//   {
//     'Name': 'Yahya Atta',
//     'Faculty': 'Computer Science and Information Technology',
//     'Department': 'Computer Science(CS)',
//     'Skill': 'Flutter Developer(Still Learning)',
//   },
// ];

List studentdb = [];
List? studentlogindb;

TextEditingController studentname = TextEditingController();
TextEditingController universityid = TextEditingController();
TextEditingController birthday = TextEditingController();
TextEditingController faculty = TextEditingController();
String  ? facultydep ;
TextEditingController universityYear = TextEditingController();
TextEditingController skill = TextEditingController();
GlobalKey<FormState> formstate = GlobalKey<FormState>();

class AppLogic {
  static addStudent() async {
    if (formstate.currentState!.validate()) {
      await sqldb.createData('''
INSERT INTO `student`(`studentname`,`universityid`,`birthday`,`facultydep`,`universityYear`,`skill`)
VALUES("${studentname.text}",${universityid.text},${birthday.text},"$facultydep","${universityYear.text}","${skill.text}")
''');
    } else {}
  }
}
