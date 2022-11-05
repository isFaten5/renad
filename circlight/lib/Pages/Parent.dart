//import 'package:cool_alert/cool_alert.dart';

//import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:encryptor/encryptor.dart';
//import 'package:adobe_xd/adobe_xd.dart';
//import 'package:flutter/src/widgets/framework.dart';

class Parent {
  String Name = " "; //

  String Email = ""; //

  String PUserName = " "; //
  String PNationalID; //

  String PNationality = " "; //
  String PJobTitle = " "; //
  String PPhoneNumber = ""; //
  String PAltPhoneNumber = ""; //
  String PRelativeRelation = "";

  Parent(
      {required this.Name,
      required this.Email,
      required this.PUserName,
      required this.PNationalID,
      required this.PJobTitle,
      required this.PPhoneNumber,
      required this.PAltPhoneNumber,
      required this.PNationality,
      required this.PRelativeRelation});

  /* UpdateParent(DocId, Name, UserName, Email, NationalID, Nationality, JobTitle,
      Phone, AltPhone, PRelativeRelation) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Parent");
    await Parents.doc(DocId).set({
      'Name': Name,
      'UserName': UserName,
      'Email': Email,
      'NationalID': NationalID,
      'Password': NationalID,
      'PhoneNumber': Phone,
      'AltPhoneNumber': AltPhone,
      'Nationality': Nationality,
      'JobTitle': JobTitle,
      'LateStatus': false,
      "RelativeRelation": PRelativeRelation
    });
  }*/

// UserName, Email, NationalID, Nationality, JobTitle,
  //  Phone, AltPhone, PRelativeRelation
//
  UpdateParent(DocId, Field, Updated) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Parent");
    bool IsUpdated = false;

    switch (Field) {
      case 'Name':
        await Parents.doc(DocId).update({
          'Name': Updated,
        });
        IsUpdated = true;
        break;
      case "UserName":
        await Parents.doc(DocId).update({
          'UserName': Updated,
        });
        break;
      case "Email":
        await Parents.doc(DocId).update({
          'Email': Updated,
        });
        break;
      case "JobTitle":
        await Parents.doc(DocId).update({
          'JobTitle': Updated,
        });
        break;
      case "PhoneNumber":
        await Parents.doc(DocId).update({
          'PhoneNumber': Updated,
        });
        break;
      case "AltPhoneNumber":
        await Parents.doc(DocId).update({
          'AltPhoneNumber': Updated,
        });
        break;
      case "NationalID":
        await Parents.doc(DocId).update({
          'NationalID': Updated,
        });
        break;
      case "Nationality":
        await Parents.doc(DocId).update({
          'NationalID': Updated,
        });
        break;
      case "RelativeRelation":
        await Parents.doc(DocId).update({
          'RelativeRelation': Updated,
        });
        break;
    }
    return IsUpdated;
  }
/*
    await Parents.doc(DocId).set({
     'Name' : Name,
      'UserName': UserName,
      'Email': Email,
      'NationalID': NationalID,
      'Password': NationalID,
      'PhoneNumber': Phone,
      'AltPhoneNumber': AltPhone,
      'Nationality': Nationality,
      'JobTitle': JobTitle,
      'LateStatus': false,
      "RelativeRelation": PRelativeRelation
    });
  }*/

  addParent(PN, PUserName, Email, PID, ParenPhoneNo, AltPhoneNum, Nationality,
      randompass, JobT, PRelativeRelation, AdminID) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Parent");
    //for hashing
    String stringValue = randompass.toString();
    var digest = sha1.convert(utf8.encode(stringValue)).toString();
    //end of hashing
    Parents.add({
      'Name': PN,
      'UserName': PUserName,
      'Email': Email,
      'NationalID': PID,
      'Password': digest,
      'PhoneNumber': ParenPhoneNo,
      'AltPhoneNumber': AltPhoneNum,
      'Nationality': Nationality,
      'JobTitle': JobT,
      'LateStatus': false,
      "RelativeRelation": PRelativeRelation,
      "AdminID": AdminID,
    });
  }

  DeleteParent(String DocId) async {
    CollectionReference Parents =
        FirebaseFirestore.instance.collection("Parent");
    await Parents.doc(DocId).delete();
  }

/*
  addStudent() {
    final userRef = FirebaseFirestore.instance.collection("Parent");
    userRef.doc().collection("Studet").add({
      "BloodType": "lamaalmajhad",
      "Class": "lamaalmajhad@outlook.com",
      "Name": "lama school",
      "Nationality": "False",
      "StudentID": "first student",
      "UserName": "سعودي",
    });
  }

*/
}//END OF CLASS
