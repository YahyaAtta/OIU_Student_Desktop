import 'package:oiu_student_desktop/main.dart';
import 'package:flutter/material.dart';

List studentdb = [];
List? studentlogindb;

TextEditingController studentname = TextEditingController();
TextEditingController universityid = TextEditingController();
TextEditingController birthday = TextEditingController();
TextEditingController faculty = TextEditingController();
String? facultydep;
String? universityYear;
TextEditingController skill = TextEditingController();
GlobalKey<FormState> formstate = GlobalKey<FormState>();

class AppLogic {
  static addStudent() async {
    if (formstate.currentState!.validate()) {
      await sqldb.createData('''
INSERT INTO `student`(`studentname`,`universityid`,`birthday`,`facultydep`,`universityYear`,`skill`)
VALUES("${studentname.text}",${universityid.text},${birthday.text},"$facultydep","$universityYear","${skill.text}")
''');
    } else {}
  }
}
