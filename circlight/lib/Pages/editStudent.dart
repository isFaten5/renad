import 'package:circlight/Pages/displayStudent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

import 'package:circlight/Pages/Parent.dart';
import 'package:circlight/Pages/AdminHome.dart';
import 'package:circlight/Pages/DashBoard.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlight/Pages/Search.dart';
import 'package:circlight/Pages/Requests.dart';

import 'package:circlight/Pages/announcement.dart';
import 'Nav.dart';
import 'Student.dart';
import 'displayParent.dart';

import 'header_widget.dart';

class EditStudent extends StatefulWidget {
  var isChanged = "";
  var whichpag = 0;
  var Index = 1;
  var isDropDown = false;
  bool DropDown;
  var TheValue = "";
  bool Confirm;
  String documentId;

  EditStudent(
      {Key? key,
      required this.documentId,
      required this.whichpag,
      // ignore: non_constant_identifier_names
      required this.Index,
      required this.TheValue,
      required this.Confirm,
      required this.DropDown})
      : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
  getData(change) {
    isChanged = change;
    print("in getData");
    print(isChanged);
  }
}

class _EditStudentState extends State<EditStudent>
    with TickerProviderStateMixin {
  int t = 0;
  int y = 0;
  late bool isDrop = widget.DropDown;
  bool isDropDown = false;
  int DropIndex = 0;
  var DropValue;
  int DIndex = 1;
  var IsSave;
  double _headerHeight = 250;
  int _changedNumber = 0, _selectedNumber = 1;
  late String Dvalue;
  late int Inx;
  var Oldval;

  int InCount = 0;
  int C = 0;
  late String DBvalue = "";
  late String Numvalue = "1";
  final ClassNum = ["1", "2", "3", "4", "5", "6"];
  final Blood = ["O+", "A+", "B+", "AB+", "O-", "A-", "B-", "AB-"];
  String OldValue = "";

  String isDiscard = "false";
  final formKey = GlobalKey<FormState>();
  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );
  bool RelativeCh = false;

  CollectionReference Students =
      FirebaseFirestore.instance.collection("Student");
  final ParentRef = FirebaseFirestore.instance;
  List<String> docIDs = [];
  TextEditingController StudentName = TextEditingController();
  TextEditingController StudID = TextEditingController();
  TextEditingController SClass = TextEditingController();
  TextEditingController STNationalID = TextEditingController();
  TextEditingController STNationality = TextEditingController();
  TextEditingController STUserName = TextEditingController();
  TextEditingController BloodType = TextEditingController();
  bool isEmailCorrect = false;
  bool isDone = false;

  String Field = "None";
  String UpdatedValue = "";
  int Index = 2;
  late bool save;
  late TextEditingController controller;

  late FixedExtentScrollController scrollController;
  String Title = "";
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.grey)
        .animate(_ColorAnimationController);

    _icon2ColorTween =
        ColorTween(begin: Colors.white, end: const Color(0xff42c98d))
            .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);
    scrollController = FixedExtentScrollController(initialItem: DIndex);
    controller = TextEditingController(text: Blood[DIndex]);
    Dvalue = Studentx.SBloodType;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Oldval = new List.filled(10, null, growable: false);

    // ignore: deprecated_member_use
    IsSave = List<int>.filled(5, 0);
    DropValue = List<String>.generate(10, growable: true, (index) => "null");
    DropValue[DropIndex] = "أم";
    DropIndex += 1;
    print("fffffffffffffffff");

    bool isSaved = widget.Confirm;
    int whichpagee = widget.whichpag;
    String TheValuee = widget.TheValue;
    int WIndex = widget.Index;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    String change = widget.isChanged;
    var size = MediaQuery.of(context).size;

    int Tab = 0;
    final List<Widget> Screens = [
      Search(),
      AdminHome(),
      Requests(),
      DashBoard(),
      Announcement(),
    ];

    Widget currentScreen = Announcement();

    // initState();
    // dispose();
    return FutureBuilder<DocumentSnapshot>(
        future: Students.doc(widget.documentId).get(),
        builder: ((context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              final String jsonString = jsonEncode(data);
              Studentx.Name = data["Name"];

              Studentx.SUserName = data["UserName"];
              Studentx.Class = data["Class"];
              Studentx.SNationalID = data["NationalID"];
              Studentx.SNationality = data["Nationality"];

              // Studentx.SBloodType = data["BloodType"];

              if (t == 0) {
                Dvalue = data["BloodType"];
              }
              t += 1;
              if (y == 0) {
                Numvalue = data["Class"];
              }
              y += 1;
              //  Oldval[InCount] = value;
              // InCount += 1;
            }
          } catch (e) {
            // print("xxxxxxxxxxxxxxxxxxxxxxxx");
          }
          if (whichpagee == 1) {
            return GetEditField(WIndex, TheValuee, height);
          } else {
            return GetMainPage(height, isSaved);
          }
        }
            // return Center(child: CircularProgressIndicator());
            ));
  }

  GetEditField(WIndex, value, height) {
    save = false;
    print("kkkkkkkkkkkkkkkkk");
    print(save);
    switch (WIndex) {
      case 1:
        Title = " أسم الطالب";
        break;
      case 2:
        Title = "اسم المستخدم";
        break;

      case 4:
        Title = "صف الطالب";
        break;
      case 5:
        Title = " رقم الهوية/الإقامة";
        break;
      case 6:
        Title = "الجنسية";
        break;
      case 7:
        Title = " فصيلة دم الطالب";
        break;
    }
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 5),
                  child: CupertinoButton(
                    child: Text(
                      "حفظ",
                      style: TextStyle(color: const Color(0xff42c98d)),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        //t(DocId, Field, Name)
                        if (save == false) {
                          Navigator.pop(context);
                        }

                        switch (Field) {
                          case "Name":
                            UpdatedValue = StudentName.text;
                            break;
                          case "UserName":
                            UpdatedValue = STUserName.text;
                            break;
                          case "Class":
                            UpdatedValue = SClass.text;
                            break;
                          case "BloodType":
                            UpdatedValue = BloodType.text;
                            break;

                          case "NationalID":
                            UpdatedValue = STNationalID.text;
                            break;
                          case "Nationality":
                            UpdatedValue = STNationality.text;
                            break;
                          case "RelativeRelation":
                            UpdatedValue = Dvalue;
                            break;
                        }

                        if (save == true) {
                          /* Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => editparent5(
                                documentId: widget.documentId,
                                Confirm: save,
                                Index: 1,
                                TheValue: "",
                                whichpag: 0,
                              )));*/
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar); // snack
                          Future.delayed(const Duration(milliseconds: 1500))
                              .then((value) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Nav(
                                          TabValue: 9,
                                          documentId: widget.documentId,
                                          Confirm: save,
                                          index: 1,
                                          TheValue: "",
                                          whichpag: 0,
                                          DropDown: isDrop,
                                        )));
                          });
                        }
                        await Studentx.UpdateStudent(
                            widget.documentId, Field, UpdatedValue);

                        /* Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editparent5(
                              documentId: widget.documentId,
                            )));*/

                        // //

                        //
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      Title,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),
              ]),
          actions: [
            IconButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (save == false) {
                    Navigator.pop(context);
                  }
                  if (save == true) {
                    showCupertinoDialog(
                        context: context, builder: CreateDialog3);
                  }
                  print(value);
                  await Studentx.UpdateStudent(
                      widget.documentId, "RelativeRelation", Oldval);
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              color: Colors.grey,
            ),
          ],
          backgroundColor: Color(0xFFffffff),
        ),
        key: _scaffoldKey,
        backgroundColor: Color(0xFFffffff),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(children: [
                FutureBuilder(
                  builder: ((context, snapshot) {
                    return Container(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Form(
                        key: formKey, //key for form
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            GetWidget(WIndex),
                            SizedBox(
                              height: height * 0.05,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ])),
            ],
          ),
        ));
  }

  Widget GetWidget(In) {
    Widget Fields = Text("");

    switch (In) {
      case 1:
        Field = "Name";
        OldValue = Studentx.Name;

        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: StudentName..text = Studentx.Name,
            //to take text from user input
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),
            decoration: InputDecoration(
              hintText: "أدخل أسم الطالب",
              labelText: " أسم الطالب",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 9, left: 9),
                child: Container(
                  //  padding: const EdgeInsets.only(right: 5),

                  child: Column(children: [
                    Image.asset("assets/icons/name.png",
                        width: 20, height: 20, color: Color(0xff42c98d)),
                  ]),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != StudentName.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                return null;
              }
            },
          ),
        );
        break;
      case 2:
        Field = "UserName";
        OldValue = Studentx.SUserName;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: STUserName..text = Studentx.SUserName,
            //to take text from user input
            textAlign: TextAlign.right,

            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),

            decoration: InputDecoration(
              hintText: " أدخل اسم المستخدم",
              labelText: "اسم المستخدم",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.person,
                  size: 22,
                  color: const Color(0xff42c98d),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff42c98d), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != STUserName.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                return null;
              }
            },
          ),
        );
        break;

      case 5:
        Field = "NationalID";
        OldValue = Studentx.SNationalID;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: STNationalID..text = Studentx.SNationalID,
            //to take text from user input
            textAlign: TextAlign.right,

            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff57d77a),

            decoration: InputDecoration(
              hintText: "أدخل رقم الهوية/الإقامة",
              labelText: " رقم الهوية/الإقامة",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 9, left: 9),
                child: Container(
                  //  padding: const EdgeInsets.only(right: 5),

                  child: Column(children: [
                    Image.asset("assets/icons/ID.png",
                        width: 20, height: 20, color: Color(0xff42c98d)),
                  ]),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff0da6c2), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != STNationalID.text) {
                save = true;
              }

              if (value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value!))
                return "أرجو منك تعبئه الحقل بطريقه صحيحه حيث يتكون من 10 ارقام";
              else {
                return null;
              }
            },
          ),
        );
        break;
      case 6:
        Field = "Nationality";
        OldValue = Studentx.SNationality;
        Fields = Directionality(
          textDirection: TextDirection.rtl,
          child: TextFormField(
            controller: STNationality..text = Studentx.SNationality,
            //to take text from user input
            textAlign: TextAlign.right,

            style: GoogleFonts.poppins(
                fontSize: 14,
                //fontWeight: FontWeight.w600,
                color: Colors.grey),
            showCursor: true,
            cursorColor: const Color(0xff0da6c2),

            decoration: InputDecoration(
              hintText: "ماهي جنسيتك؟",
              labelText: "الجنسية",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
              labelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12, top: 9, left: 9),
                child: Container(
                  //  padding: const EdgeInsets.only(right: 5),

                  child: Column(children: [
                    Image.asset("assets/icons/Nationality.png",
                        width: 20, height: 20, color: Color(0xff42c98d)),
                  ]),
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xff57d77a), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              floatingLabelStyle: const TextStyle(
                  color: const Color(0xff57d77a),
                  fontSize: 12,
                  fontWeight: FontWeight.w300),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color(0xff57d77a), width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              if (OldValue != STNationality.text) {
                save = true;
              }

              if (value!.isEmpty)
                return "أرجو منك تعبئه الحقل الفارغ ";
              else {
                return null;
              }
            },
          ),
        );
        break;
    }
    return Fields;
  }

  GetMainPage(height, isSaved) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        // appBar: AppBar(title: Text("Faten")),

        backgroundColor: Color(0xFFffffff),
        body: NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: Container(
                height: double.infinity,
                child: Stack(children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Get.height * 0.4,
                          child: Stack(
                            children: [
                              Container(
                                height: _headerHeight,
                                child: HeaderWidget(
                                    _headerHeight,
                                    false,
                                    Icons
                                        .login_rounded), //let's create a common header widget
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 255, 244, 244),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff57d77a).withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Color(0xff57d77a).withOpacity(0.4),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Form(
                            key: formKey,
                            child: Column(children: [
                              InkWell(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 2, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 188, 187, 187)),
                                            Studentx.Name,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff57d77a)),
                                            " أسم الطالب",
                                            maxLines: 2,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xff57d77a)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 9,
                                      index: 1,
                                      documentId: widget.documentId,
                                      TheValue: StudentName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              InkWell(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 2, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 188, 187, 187)),
                                            Studentx.SUserName,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff57d77a)),
                                            'اسم المستخدم',
                                            maxLines: 2,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xff57d77a)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 9,
                                      index: 2,
                                      documentId: widget.documentId,
                                      TheValue: STUserName.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              InkWell(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 2, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 188, 187, 187)),
                                            Studentx.SNationalID,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff57d77a)),
                                            " رقم الهوية/الإقامة",
                                            maxLines: 2,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xff57d77a)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 9,
                                      index: 5,
                                      documentId: widget.documentId,
                                      TheValue: STNationalID.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              InkWell(
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Positioned(
                                          left: 0.0,
                                          child: Icon(
                                            Icons.arrow_back_ios_outlined,
                                            color: const Color(0xff57d77a),
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 2, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 188, 187, 187)),
                                            Studentx.SNationality,
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10, bottom: 10),
                                          child: Text(
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff57d77a)),
                                            "الجنسية",
                                            maxLines: 2,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1.0,
                                          color: const Color(0xff57d77a)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 9,
                                      index: 6,
                                      documentId: widget.documentId,
                                      TheValue: STNationality.text,
                                      whichpag: 1,
                                      Confirm: false,
                                      DropDown: isDrop,
                                    ),
                                  ));
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                            ]),
                          ),
                        ),
                        Center(
                          child: new Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              direction:
                                  Axis.vertical, // main axis (rows or columns)
                              children: <Widget>[
                                CupertinoButton(
                                  child: Expanded(
                                    child: Container(
                                      // padding:
                                      // padding: EdgeInsets.only(right: 4),
                                      //   EdgeInsets.symmetric(horizontal: 120),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: const Color(0xff57d77a)),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Flexible(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                        right: 4),
                                                    child: Positioned(
                                                      left: 0,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_circle_down_rounded,
                                                        // Icons.arrow_downward_outlined,
                                                        color: const Color(
                                                            0xff57d77a),
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.only(
                                                          right: 120),
                                                      child: Text(
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        188,
                                                                        187,
                                                                        187)),
                                                        Dvalue,
                                                        maxLines: 2,
                                                        // textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0xff57d77a)),
                                                      'فصيلة الدم ',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                        "assets/icons/Blood.png",
                                                        width: 15,
                                                        height: 15,
                                                        color:
                                                            Color(0xff42c98d)),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200.0,
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("إلغاء",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffA7A7A7),
                                                          fontSize: 16)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                    scrollController:
                                                        scrollController,
                                                    looping: false,
                                                    itemExtent: 64,
                                                    backgroundColor:
                                                        Colors.white,
                                                    onSelectedItemChanged:
                                                        (index) {
                                                      print(index);

                                                      DIndex = index;
                                                      print(DIndex);
                                                      final item =
                                                          Blood[DIndex];
                                                      DIndex = index;
                                                      controller.text = item;
                                                      Dvalue = item;
                                                    },
                                                    children: Blood.map(
                                                        (item) => Center(
                                                                child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ))).toList(),
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("موافق",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xff57d77a),
                                                          fontSize: 16)),
                                                  onPressed: () {
                                                    scrollController =
                                                        FixedExtentScrollController(
                                                            initialItem:
                                                                _changedNumber);
                                                    //scrollController.dispose();
                                                    setState(() {
                                                      _selectedNumber =
                                                          _changedNumber;
                                                    });
                                                    isDrop == true;
                                                    widget.isDropDown = true;

                                                    Dvalue = Blood[DIndex];
                                                    Navigator.pop(context);
                                                    /*  parentx.UpdateParent(
                                              widget.documentId,
                                              "RelativeRelation",
                                              value);*/
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 32.0,
                        ),
                        Center(
                          child: new Wrap(
                              spacing: 5.0,
                              runSpacing: 5.0,
                              direction:
                                  Axis.vertical, // main axis (rows or columns)
                              children: <Widget>[
                                CupertinoButton(
                                  child: Expanded(
                                    child: Container(
                                      // padding:
                                      // padding: EdgeInsets.only(right: 4),
                                      //   EdgeInsets.symmetric(horizontal: 120),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: const Color(0xff57d77a)),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Flexible(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                        right: 4),
                                                    child: Positioned(
                                                      left: 0,
                                                      child: Icon(
                                                        Icons
                                                            .arrow_circle_down_rounded,
                                                        // Icons.arrow_downward_outlined,
                                                        color: const Color(
                                                            0xff57d77a),
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.only(
                                                          right: 120),
                                                      child: Text(
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        188,
                                                                        187,
                                                                        187)),
                                                        Numvalue,
                                                        maxLines: 2,
                                                        // textAlign: TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0xff57d77a)),
                                                      'صف الطالب',
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Image.asset(
                                                        "assets/icons/Class.png",
                                                        width: 15,
                                                        height: 15,
                                                        color:
                                                            Color(0xff42c98d)),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200.0,
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                CupertinoButton(
                                                  child: Text("إلغاء",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffA7A7A7),
                                                          fontSize: 16)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                Expanded(
                                                  child: CupertinoPicker(
                                                    scrollController:
                                                        scrollController,
                                                    looping: false,
                                                    itemExtent: 64,
                                                    backgroundColor:
                                                        Colors.white,
                                                    onSelectedItemChanged:
                                                        (index) {
                                                      print(index);

                                                      DIndex = index;
                                                      print(DIndex);
                                                      final item =
                                                          ClassNum[DIndex];
                                                      DIndex = index;
                                                      controller.text = item;
                                                      Numvalue = item;
                                                    },
                                                    children: ClassNum.map(
                                                        (item) => Center(
                                                                child: Text(
                                                              item,
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ))).toList(),
                                                  ),
                                                ),
                                                CupertinoButton(
                                                  child: Text("موافق",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xff57d77a),
                                                          fontSize: 16)),
                                                  onPressed: () {
                                                    scrollController =
                                                        FixedExtentScrollController(
                                                            initialItem:
                                                                _changedNumber);
                                                    //scrollController.dispose();
                                                    setState(() {
                                                      _selectedNumber =
                                                          _changedNumber;
                                                    });
                                                    isDrop == true;
                                                    widget.isDropDown = true;

                                                    Numvalue = ClassNum[DIndex];
                                                    Navigator.pop(context);
                                                    /*  parentx.UpdateParent(
                                              widget.documentId,
                                              "RelativeRelation",
                                              value);*/
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        /* DropdownButtonFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              value: value,
              onChanged: (value) => setState(() => this.value = value),
              items: Relation.map(BuildMenuItem).toList()),*/
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    child: AnimatedBuilder(
                      animation: _ColorAnimationController,
                      builder: (context, child) => AppBar(
                        iconTheme: IconThemeData(
                          color: _iconColorTween.value,
                        ),
                        automaticallyImplyLeading: false,
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: CupertinoButton(
                                  child: Text(
                                    "حفظ",
                                    style: TextStyle(
                                        color: _icon2ColorTween.value,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    if (isSaved != true) {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => Nav(
                                                    TabValue: 11,
                                                    documentId:
                                                        widget.documentId,
                                                  )));
                                    }
                                    print(isSaved);
                                    if (widget.isDropDown == true) {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: CreateDialog2);
                                      await Studentx.UpdateStudent(
                                          widget.documentId,
                                          "BloodType",
                                          Dvalue);
                                      await Studentx.UpdateStudent(
                                          widget.documentId, "Class", Numvalue);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 55,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    "تحديث معلومات الطالب",
                                    textAlign: TextAlign.start,
                                    style:
                                        TextStyle(color: _iconColorTween.value),
                                  ),
                                ),
                              ),
                            ]),
                        actions: [
                          IconButton(
                            onPressed: () async {
                              if (widget.isDropDown != true) {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Nav(
                                              TabValue: 11,
                                              documentId: widget.documentId,
                                            )));
                              }

                              print("hhhhhhhhhhhhhh");
                              if (widget.isDropDown == true) {
                                showCupertinoDialog(
                                    context: context, builder: CreateDialog);
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: _iconColorTween.value,
                            ),
                            color: _iconColorTween.value,
                          ),
                        ],
                        backgroundColor: _colorTween.value,
                        elevation: 0,
                        titleSpacing: 0.0,
                      ),
                    ),
                  ),
                ]))));
  }

  Widget buildPicker() => Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Positioned(
                  left: 0.0,
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Color(0xffA7A7A7),
                    size: 16,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA7A7A7)),
                    'فاتن',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10, bottom: 10),
                  child: Text(
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffA7A7A7)),
                    'اسم ولي الامر',
                    maxLines: 2,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Color(0xffA7A7A7)),
            ),
          ),
        ),

        /* greenButton('حفظ', () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                }),*/
      ]);

  WhichColor() {
    if (isEmailCorrect == false) {
      return Colors.grey.shade200;
    } else {
      return Colors.green;
    }
  }

  Widget IsCorrect() {
    if (isEmailCorrect == false) {
      return Text("");
    } else {
      return const Icon(
        Icons.done,
        color: Colors.green,
      );
    }
  }

  Widget CreateDialog(BuildContext context) {
    String Msg = "تجاهل التغييرات";

    return CupertinoAlertDialog(
      title: Text("تجاهل التغييرات"),
      content: Text("إذا عدت الآن، فستفقد التغييرات"),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Nav(
                            TabValue: 11,
                            documentId: widget.documentId,
                          )));
            },
            child: Text("تجاهل التغييرات")),
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("الاستمرار في التحرير")),
      ],
    );
  }

  Widget CreateDialog3(BuildContext context) {
    String Msg = "تجاهل التغييرات";

    return CupertinoAlertDialog(
      title: Text("تجاهل التغييرات"),
      content: Text("إذا عدت الآن، فستفقد التغييرات"),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Nav(
                            TabValue: 9,
                            documentId: widget.documentId,
                            index: 1,
                            Confirm: false,
                            TheValue: "",
                            whichpag: 0,
                            DropDown: isDrop,
                          )));
            },
            child: Text("تجاهل التغييرات")),
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("الاستمرار في التحرير")),
      ],
    );
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 350) / 50);
      return true;
    }

    return false;
  }

  dynamic snackBar = SnackBar(
    duration: const Duration(milliseconds: 1500),
    content: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
      Text(
        "تم تحديث المعلومات",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Color(0xffA7A7A7),
        ),
      ),
      Icon(
        FontAwesomeIcons.check,
        size: 16,
        color: Color(0xffA7A7A7),
      ),
    ]),
  );
/*
  Widget CreateDialog2(BuildContext context) {
    String Msg = "تحديث معلومات الطالب";

    return CupertinoAlertDialog(
      content: Text("تم تحديث المعلومات بنجاح"),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Future.delayed(const Duration(milliseconds: 1500));
              /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Studentdispaly()));*/
            },
            child: Text("موافق")),
      ],
    );*/

  Widget CreateDialog2(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "تحديث معلومات الطالب",
        ),
        content: Text(
          "تم إضافة المعلومات بنجاح",
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("موافق"),
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => Nav(
                          TabValue: 11,
                          documentId: widget.documentId,
                        ))),
          )
        ],
      );
  /*Widget greenButton(String title, Function onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff348379),
            const Color(0xff305565),
            const Color(0xff2d2e53)
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        minWidth: Get.width,
        height: 50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }*/
/*
  TextFieldWidget(String title, IconData iconData,
      TextEditingController controller, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xffA7A7A7)),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: Get.width,
          // height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            readOnly: readOnly,
            onTap: () => onTap!(),
            validator: (input) => validator(input),
            controller: controller,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xffA7A7A7)),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  iconData,
                  color: const Color(0xff29294d),
                  size: 18,
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }*/

  DropdownMenuItem<String> BuildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
        ),
      );
  /* Widget getWidget() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets\images\mask.png'), fit: BoxFit.fill),
      ),
      height: Get.height * 0.3,
      child: Container(
        height: Get.height * 0.1,
        width: Get.width,
        margin: EdgeInsets.only(bottom: Get.height * 0.05),
        child: Center(child: Text("Edit")),
      ),
    );
  }*/
}

class CheckUpdated {
  isUdated() {}
}
