import 'package:circlight/Pages/Admin.dart';

import 'package:circlight/Pages/Student.dart';

import 'package:circlight/Pages/base_screen.dart';

import 'package:circlight/Pages/theme_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:circlight/Pages/Parent.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'header_widget.dart';
import 'package:get/get.dart';

class Studentdispaly extends StatefulWidget {
  const Studentdispaly({Key? key}) : super(key: key);

  @override
  State<Studentdispaly> createState() => _Studentdispaly();
}

class _Studentdispaly extends State<Studentdispaly>
    with TickerProviderStateMixin {
  var CurrentID;
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;

  @override
  void initState() {
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

    super.initState();
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

  Student Studentx = new Student(
    Name: "",
    Class: "",
    SNationalID: "",
    SNationality: "",
    SUserName: "",
    SBloodType: "",
  );

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //for the button
                    /* Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: ElevatedButton(
                          style: ThemeHelper().buttonStyle(),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ParentAddform()));
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            child: Text(
                              ' اضافه ولي امر + ',
                              style: TextStyle(
                                  fontSize: 15,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),*/
                    /* this was the float button Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ParentAddform()));
                          },
                          child: const Icon(Icons.add),
                          backgroundColor: const Color(0xff57d77a),
                        ),
                      ),
                    ),*/

                    // width: Get.width,

                    //let's create a common header widget

                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Student")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return FutureBuilder(
                              future: Future.wait([
                                Admin().getAdminID(),
                                Admin().getDocIdstudent()
                              ]),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: snap.length,
                                    itemBuilder: (context, index) {
                                      //dynamic v = docIDS[index];
                                      Map<String, dynamic>? mapid = snap[index]
                                          .data() as Map<String, dynamic>;
                                      // print("mapcheck ${mapid}");
                                      String? adminId = mapid['AdminID'];

                                      String? adminIdnew = snapshot.data![0][0];
                                      bool isAdmin = adminIdnew == adminId;
                                      //(snap[index]['AdminID'] == AdminID[0])
                                      return isAdmin
                                          ? Container(
                                              height: 70,
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(
                                                  bottom: 12),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black12),
                                                ),
                                              ),
                                              child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      /*
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('../assets/images/mask.jpeg'),
                              fit: BoxFit.fill)),

                      //height: Get.height * 0.3,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffD6D6D6),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color.fromARGB(95, 60, 58, 58),
                        )),
                      ),
                    )*/
                                                      //for profile image

                                                      decoration:
                                                          BoxDecoration(),
                                                    ),

                                                    //to only show the allowed people to admin

                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 90),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        snap[index]['Name'],
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xff0da6c2),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    //container for button

                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        InkWell(
                                                            // height: 80,
                                                            onTap: () {
                                                              //////askkkk
                                                              /* Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  //askkkkk faten where should it go ??;
*/
                                                              CurrentID =
                                                                  snapshot.data![
                                                                      1][index];
                                                              showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      CreateDialog3);
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/delete.png',
                                                              height: 30,
                                                              width: 45,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                        InkWell(
                                                            onTap: () {
                                                              // print(docIDS[index]);

                                                              int Tab = 8;
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                      CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Nav(
                                                                  documentId:
                                                                      snapshot.data![
                                                                              1]
                                                                          [
                                                                          index],
                                                                  TabValue: 9,
                                                                  TheValue: "",
                                                                  whichpag: 0,
                                                                  DropDown:
                                                                      false,
                                                                  Confirm:
                                                                      false,
                                                                  index: 1,
                                                                ),
                                                              ));
                                                            },
                                                            child: Image.asset(
                                                              'assets/images/edit.png',
                                                              height: 30,
                                                              width: 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )),
                                                      ],
                                                    ),
                                                  ]))
                                          : const SizedBox();
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
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
                          SizedBox(
                            width: 195,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "مرحبا ",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: _iconColorTween.value),
                              ),
                            ),
                          ),
                        ]),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Nav(
                                        TabValue: 0,
                                        documentId: "",
                                      )));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: _iconColorTween.value,
                        ),
                        color: Colors.white,
                      ),
                    ],
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateDialog3(BuildContext context) {
    String Msg = "تجاهل التغييرات";
    return CupertinoAlertDialog(
      title: Text("حذف الطالب"),
      content: Text("هل انت متأكد انك تريد حذف الطالب؟"),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Nav(
                            TabValue: 11,
                          )));
            },
            child: Text("الغاء")),
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              Studentx.DeleteStudent(CurrentID);
            },
            child: Text("موافق")),
      ],
    );
  }
}
