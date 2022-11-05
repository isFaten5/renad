import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:adobe_xd/adobe_xd.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:encryptor/encryptor.dart';

class Admin {
  //get doc id
  String Email = ""; //
  String Password = " "; //
  String SchoolName=""; //
  String Username = " "; //

  

 
 

  
  Future<List<String>> getDocId() async {
    List<String> docIDS = [];
    // print("getDocId");
    await FirebaseFirestore.instance.collection("Parent").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Name"]);
            docIDS.add(document.reference.id);
          }),
        );
    // print("docIDS ${docIDS} ");
    return docIDS;
  }

  Future<List<String>> getAdminID() async {
    List<String> AdminID = [];
    // print("getAdminID");
    await FirebaseFirestore.instance.collection("Admin").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Name"]);
            AdminID.add(document.reference.id);
          }),
        );
    // print("AdminID ${AdminID} ");
    return AdminID;
  }

  Future<List<String>> getDocIdstudent() async {
    List<String> docIDSStudent = [];
    //print("getDocId");
    await FirebaseFirestore.instance.collection("Student").get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document["Name"]);
            docIDSStudent.add(document.reference.id);
          }),
        );
    // print("docIDS ${docIDSStudent} ");
    return docIDSStudent;
  }
}//End of class
