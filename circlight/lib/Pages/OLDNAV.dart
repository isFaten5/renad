import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circlight/Pages/Search.dart';
import 'package:circlight/Pages/Requests.dart';

import 'package:circlight/Pages/announcement.dart';
import 'package:circlight/Pages/AdminHome.dart';
import 'package:circlight/Pages/DashBoard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CreateParent.dart';

import 'CreateStudent.dart';

import 'base_screen.dart';
import 'displayParent.dart';
import 'displayStudent.dart';

import 'edit5.dart';
import 'editStudent.dart';

class Nav2 extends StatefulWidget {
  final int TabValue;
  final documentId;
  final index;
  final Realtion;
  final Name;
  final username;
  final email;
  final ID;
  final Confirm;
  final nationality;
  final phone1;
  final phone2;
  final job;
  final SID;
  final Blood;
  final Class;
  final TheValue;
  final whichpag;
  final DropDown;
  final header;
  const Nav2(
      {super.key,
      this.DropDown,
      required this.TabValue,
      this.documentId,
      this.Blood,
      this.index,
      this.whichpag,
      this.TheValue,
      this.SID,
      this.Class,
      this.Realtion,
      this.Confirm,
      this.ID,
      this.Name,
      this.username,
      this.email,
      this.nationality,
      this.job,
      this.phone1,
      this.phone2,
      this.header});

  @override
  State<Nav2> createState() => _Nav2();
}

class _Nav2 extends State<Nav2> {
  SetTab() {
    setState(() {
      switch (widget.TabValue) {
        case 0:
          currentScreen = BaseScreen();
          Tab = 0;
          break;
        case 5:
          currentScreen = editparent5(
            documentId: widget.documentId,
            Confirm: false,
            Index: widget.index,
            TheValue: widget.TheValue,
            whichpag: widget.whichpag,
            DropDown: false,
          );
          Tab = 5;
          break;
        case 6:
          //  currentScreen = UpdateStudent(documentId: widget.documentId);
          Tab = 6;
          break;
        case 7:
          currentScreen = Createparent5(
            index: widget.index,
            Name: widget.Name,
            username: widget.username,
            email: widget.email,
            phone1: widget.phone1,
            phone2: widget.phone2,
            Realtion: widget.Realtion,
            header: widget.header,
          );
          Tab = 7;
          break;
        case 8:
          currentScreen = CreateStudent(
            documentId: widget.documentId,
            index: widget.index,
            Name: widget.Name,
            username: widget.username,
            SID: widget.SID,
            header: widget.header,
          );
          Tab = 8;
          break;
        case 9:
          currentScreen = EditStudent(
            documentId: widget.documentId,
            DropDown: false,
            Confirm: false,
            Index: widget.index,
            TheValue: widget.TheValue,
            whichpag: widget.whichpag,
          );
          Tab = 9;
          break;
        case 10:
          currentScreen = Paretdisplay();
          Tab = 10;
          break;
        case 11:
          currentScreen = Studentdispaly();
          Tab = 11;
          break;
      }
    });
  }

  int _count = 0;
  int Tab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = BaseScreen();

  @override
  Widget build(BuildContext context) {
    final List<Widget> Screens = [
      BaseScreen(),
      Paretdisplay(),
      Requests(),
      Studentdispaly(),
      Announcement(),
    ];
    SetTab();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomAppBar(
              child: Container(
                  height: 50.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => Nav2(
                                                TabValue: 0,
                                                documentId: widget.documentId,
                                              )));
                                  currentScreen = BaseScreen();
                                  Tab = 0;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      //     padding: const EdgeInsets.only(right: 50),
                                      child: Align(
                                    child: Column(children: [
                                      SizedBox(
                                        height: 11,
                                      ),
                                      Image.asset("assets/images/homepage.png",
                                          width: 25,
                                          height: 25,
                                          color: Tab == 0
                                              ? Color(0xff42c98d)
                                              : Color.fromARGB(
                                                  255, 167, 166, 166)),
                                    ]),
                                  )),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    //  padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      'الرئيسية',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Tab == 0
                                              ? Color(0xff42c98d)
                                              : Colors.grey),
                                    ),
                                  )
                                  // Text
                                  // Column
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                                minWidth: 40,
                                onPressed: () {
                                  setState(() {
                                    currentScreen = Studentdispaly();
                                    Tab = 1;
                                  });
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          //    padding:
                                          //        const EdgeInsets.only(right: 50),
                                          child: Align(
                                        child: Column(children: [
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Image.asset(
                                              "assets/images/dashboard.png",
                                              width: 25,
                                              height: 25,
                                              color: Tab == 1
                                                  ? Color(0xff42c98d)
                                                  : Color.fromARGB(
                                                      255, 167, 166, 166)),
                                        ]),
                                      )),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        //   padding:
                                        //      const EdgeInsets.only(right: 50),
                                        child: Text(
                                          'لوحة المتابعة',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Tab == 1
                                                  ? Color(0xff42c98d)
                                                  : Colors.grey),
                                        ),
                                      )
                                    ]))
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                setState(() {
                                  currentScreen = Paretdisplay();
                                  Tab = 2;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      //     padding: const EdgeInsets.only(right: 50),
                                      child: Align(
                                    child: Column(children: [
                                      SizedBox(
                                        height: 11,
                                      ),
                                      Image.asset("assets/images/search.png",
                                          width: 25,
                                          height: 25,
                                          color: Tab == 2
                                              ? Color(0xff42c98d)
                                              : Color.fromARGB(
                                                  255, 167, 166, 166)),
                                    ]),
                                  )),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    //  padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      'البحث',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Tab == 2
                                              ? Color(0xff42c98d)
                                              : Colors.grey),
                                    ),
                                  ),
                                  // Text
                                  // Column
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                                minWidth: 40,
                                onPressed: () {
                                  setState(() {
                                    currentScreen = Requests();
                                    Tab = 3;
                                  });
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          //     padding: const EdgeInsets.only(right: 50),
                                          child: Align(
                                        child: Column(children: [
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Image.asset(
                                              "assets/images/request.png",
                                              width: 25,
                                              height: 25,
                                              color: Tab == 3
                                                  ? Color(0xff42c98d)
                                                  : Color.fromARGB(
                                                      255, 167, 166, 166)),
                                        ]),
                                      )),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        //  padding: const EdgeInsets.only(right: 50),
                                        child: Text(
                                          'الطلبات',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Tab == 3
                                                  ? Color(0xff42c98d)
                                                  : Colors.grey),
                                        ),
                                      )

                                      // Text
                                      // Column
                                    ]))
                          ],
                        )
                      ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentScreen = Announcement();
            Tab = 4;
          });
        },
        elevation: 0,
        child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                ),
              ],
              borderRadius: BorderRadius.circular(90),
              gradient: LinearGradient(
                colors: [
                  const Color(0xff0da6c2),
                  const Color(0xff42c98d),
                  const Color(0xff57d77a)
                ],
              ),
            ),
            child: Align(
              alignment: Alignment(0.30, -0.10),
              child: Column(children: [
                SizedBox(
                  height: 11,
                ),
                Image.asset(
                  "assets/images/announ.png",
                  width: 35,
                  height: 35,
                  color: Tab == 3
                      ? Color(0xff42c98d)
                      : Color.fromARGB(255, 255, 254, 254),
                ),
              ]),
            )),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
