//import 'package:cool_alert/cool_alert.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:adobe_xd/adobe_xd.dart';
//import 'package:flutter/src/widgets/framework.dart';

class Student {
  String Name = " "; //

  String Class = " "; //
  String SNationalID; //

  String SNationality = " "; //
  String SUserName = " "; //
  String SBloodType = ""; //

  Student({
    required this.Name,
    required this.Class,
    required this.SNationalID,
    required this.SNationality,
    required this.SUserName,
    required this.SBloodType,
  });

  UpdateStudent(DocId, Field, Updated) async {
    CollectionReference StudentS =
        FirebaseFirestore.instance.collection("Student");

    switch (Field) {
      case 'Name':
        await StudentS.doc(DocId).update({
          'Name': Updated,
        });

        break;

      case "NationalID":
        await StudentS.doc(DocId).update({
          'NationalID': Updated,
        });
        break;
      case "Nationality":
        await StudentS.doc(DocId).update({
          'Nationality': Updated,
        });
        break;
      case "Class":
        await StudentS.doc(DocId).update({
          'Class': Updated,
        });
        break;
      case "BloodType":
        await StudentS.doc(DocId).update({
          'BloodType': Updated,
        });
        break;
    }
  }

  DeleteStudent(DocId) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Student");
    await Parents.doc(DocId).delete();
  }

  addStudent(DocId, Name, SUserName, SNationalID, SNationality, Class,
      SBloodType, AdminID) async {
    final Student = FirebaseFirestore.instance;
    await Student.collection("Student").add({
      "ParentId": DocId,
      'Name': Name,
      'UserName': SUserName,
      'NationalID': SNationalID,
      'Nationality': SNationality,
      'Class': Class,
      'BloodType': SBloodType,
      'AdminID': AdminID,
    });
  }
}//END OF CLASS
