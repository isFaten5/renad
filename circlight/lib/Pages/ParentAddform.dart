import 'package:circlight/Pages/displayParent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

import 'package:circlight/Pages/Parent.dart'; //import for parent class
import 'package:flutter/cupertino.dart';

class ParentAddform extends StatefulWidget {
  @override
  _ParentAddFormState createState() => _ParentAddFormState();
}

class _ParentAddFormState extends State<ParentAddform> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";
  Parent parenty = new Parent(
      Name: "",
      Email: "",
      PUserName: "",
      PNationalID: "",
      PJobTitle: "",
      PPhoneNumber: "",
      PAltPhoneNumber: "",
      PNationality: "",
      PRelativeRelation: "");

  TextEditingController parentName = TextEditingController();
  TextEditingController Parentusername = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ParentIDNo = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController altphoneNumber = TextEditingController();
  TextEditingController RelativeRelation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    CollectionReference Parent =
        FirebaseFirestore.instance.collection("Parent");
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, //key for form
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.04),
                  Text(
                    "                           إنشاء حساب ولي الامر ",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20, color: Color(0xFF363F93)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: parentName,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "اسم ولي الامر",
                          hintText: "اسم ولي الامر"),

                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: Parentusername,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "اسم المستخدم", hintText: "اسم المستخدم"),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: email,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "البريد الالكتروني",
                          hintText: "البريد الالكتروني"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!))
                          return "أرجو منك تعبئه الحقل بطريقه صحيحه ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: ParentIDNo,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "رقم الهوية /الإقامة",
                          hintText: "رقم الهوية /الإقامة"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[0-9]{10}$').hasMatch(value!))
                          return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: nationality,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "الجنسية", hintText: "الجنسية"),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: jobTitle,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "الوظيفة ", hintText: "الوظيفة "),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: phoneNumber,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          labelText: "رقم الجوال", hintText: "رقم الجوال"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                                .hasMatch(value!))
                          return "أرجو منك تعبئه الحقل بطريقه صحيحه";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      //to take text from user input
                      controller: altphoneNumber,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                          labelText: "رقم جوال قريب ",
                          hintText: "رقم جوال قريب "),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                                .hasMatch(value!))
                          return "أرجو منك تعبئه الحقل بطريقه صحيحه";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: RelativeRelation,

                      //to take text from user input
                      textAlign: TextAlign.right,

                      decoration: InputDecoration(
                          hintText: "أدخل صلة القرابه",
                          labelText: "صلة القرابه"),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          child: Text("          إضافه        "),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              /* await parenty.addParent(
                                  parentName.text,
                                      Parentusername.text,
                                      email.text,
                                      ParentIDNo.text,
                                      phoneNumber.text,
                                      altphoneNumber.text,
                                      nationality.text,
                                      k,
                                      jobTitle.text,
                                      RelativeRelation.text,
                                      docAdmin[0]);*/

                              await showCupertinoDialog(
                                  context: context, builder: CreateDialog);

                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => Paretdisplay()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 54, 165, 244),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget CreateDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text("إضافة ولي الأمر", style: TextStyle(fontSize: 18)),
        content: Text(
          "تم إضافة المعلومات بنجاح",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("OK",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
}
