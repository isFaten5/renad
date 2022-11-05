import 'package:circlight/Pages/Admin.dart';

import 'package:circlight/Pages/Admin.dart';
import 'package:circlight/Pages/theme_helper.dart';
import 'package:circlight/Pages/theme_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:circlight/Pages/Parent.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'CreateParent.dart';
import 'base_screen.dart';
import 'header_widget.dart';
import 'package:get/get.dart';

class Paretdisplay extends StatefulWidget {
  const Paretdisplay({Key? key}) : super(key: key);

  @override
  State<Paretdisplay> createState() => _Paretdisplay();
}

class _Paretdisplay extends State<Paretdisplay> with TickerProviderStateMixin {
  late AnimationController _ColorAnimationController;
  late AnimationController _TextAnimationController;
  late Animation _colorTween, _iconColorTween, _icon2ColorTween;
  late Animation<Offset> _transTween;
  var CurrentID;
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

  Parent parentx = new Parent(
      Name: "",
      Email: "",
      PUserName: "",
      PNationalID: "",
      PJobTitle: "",
      PPhoneNumber: "",
      PAltPhoneNumber: "",
      PNationality: "",
      PRelativeRelation: "");

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 150;
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

                          //for the button
                          Container(
                            padding: EdgeInsets.only(right: 20, top: 110),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                child: Container(
                                  width: 50,
                                  height: 50,
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
                                    Icons.add,
                                    size: 20,
                                    color: Color(0xff57d77a).withOpacity(0.4),
                                  )),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => Nav(
                                      TabValue: 7,
                                      documentId: "",
                                      Name: "",
                                      username: "",
                                      Realtion: "",
                                      email: "",
                                      index: 1,
                                      phone1: "",
                                      phone2: "",
                                      job: "",
                                      ID: "",
                                      header: false,
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
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
                          .collection("Parent")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return FutureBuilder(
                              future: Future.wait(
                                  [Admin().getAdminID(), Admin().getDocId()]),
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

                                                        ),
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Container(
                                                        width: 90,
                                                        height: 100,
                                                        margin: EdgeInsets.only(
                                                            bottom: 10,
                                                            top: 10),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.white60
                                                            //color:
                                                            // Color(0xffD6D6D6),
                                                            ),
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.person,
                                                                size: 40,
                                                                color: Color(
                                                                        0xff57d77a)
                                                                    .withOpacity(
                                                                        0.4)
                                                                // color: Color.fromARGB(
                                                                //  95, 60, 58, 58),
                                                                )),
                                                      ),
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
                                                              int Tab = 5;
                                                              Navigator.of(
                                                                      context)
                                                                  .push(
                                                                      CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Nav(
                                                                  TheValue: "",
                                                                  index: 1,
                                                                  whichpag: 0,
                                                                  DropDown:
                                                                      false,
                                                                  Confirm:
                                                                      false,
                                                                  documentId:
                                                                      snapshot.data![
                                                                              1]
                                                                          [
                                                                          index],
                                                                  TabValue: 5,
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
                                                        InkWell(
                                                          //height: 80,
                                                          onTap: () {
                                                            int Tab = 7;
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
                                                                        [index],
                                                                index: 1,
                                                                Name: "",
                                                                username: "",
                                                                SID: "",
                                                                TabValue: 8,
                                                                header: false,
                                                              ),
                                                            ));
                                                          },
                                                          child: Image.asset(
                                                            'assets/images/addStudent.jpeg',
                                                            height: 23,
                                                            width: 30,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    //this is the same as up but with text
                                                    /* Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/addStudent.png',
                                                // height: 60,
                                                // width: 40,
                                                // fit: BoxFit.contain,
                                              ),
                                              Text('cat')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/edit.png',
                                                height: 40,
                                                // width: 40,
                                                // fit: BoxFit.contain,
                                              ),
                                              Text('cat')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/delete.png',
                                                // height: 60,
                                                // width: 40,
                                                // fit: BoxFit.contain,
                                              ),
                                              Text('cat')
                                            ],
                                          ),
                                        ),
                                    
                                        //here end
                                    
                                        Container(
                                            margin: const EdgeInsets.only(right: 20),
                                            alignment: Alignment.centerRight,
                                            child: Row(children: [
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                      textStyle:
                                                          TextStyle(fontSize: 10)),
                                                  child: Text("Update Parent"),
                                                  onPressed: () {
                                                    // print(docIDS[index]);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StudentAddform(
                                                        documentId: docIDS[index],
                                                      ),
                                                    ));
                                                  }),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                      textStyle:
                                                          TextStyle(fontSize: 10)),
                                                  child: Text("Update Parent"),
                                                  onPressed: () {
                                                    // print(docIDS[index]);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StudentAddform(
                                                        documentId: docIDS[index],
                                                      ),
                                                    ));
                                                  }),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                      textStyle:
                                                          TextStyle(fontSize: 10)),
                                                  child: Text("Update Parent"),
                                                  onPressed: () {
                                                    // print(docIDS[index]);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StudentAddform(
                                                        documentId: docIDS[index],
                                                      ),
                                                    ));
                                                  })
                                            ])),
                                        //],
                                      ]),*/
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
                    elevation: 0,
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
                    titleSpacing: 0.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*Scaffold(
      extendBodyBehindAppBar: true,
      //floatingActionButton:*/
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        //for back

        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ParentAddform()));
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.grey,
        ),
       /* centerTitle: false,
        title: new Padding(
            padding: const EdgeInsets.only(left: 200),
            child: const Text("مرحبا",
                style: TextStyle(
                  color: Color(0xff0da6c2),
                ))),

        actions: [
          Container(
            //for profile image
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,

            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(30),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/Profile.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          /*
          Center(
            child: IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search),
            ),
          )*/
        //],*/
      ), ///////////////end of app bar*/

      /* body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ParentAddform()));
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: const Color(0xff0da6c2),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),*/
      /*
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(width: 0.8)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              width: 0.8,
                              color: Theme.of(context).primaryColor)),
                      hintText: "Search Flutter Hope",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.clear), onPressed: () {})),
                ),
              ),*/
      /* StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Parent").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return FutureBuilder(
                        future: Future.wait(
                            [Admin().getAdminID(), Admin().getDocId()]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: snap.length,
                              itemBuilder: (context, index) {
                                //dynamic v = docIDS[index];
                                Map<String, dynamic>? mapid =
                                    snap[index].data() as Map<String, dynamic>;
                                print("mapcheck ${mapid}");
                                String? adminId = mapid['AdminID'];

                                String? adminIdnew = snapshot.data![0][0];
                                bool isAdmin = adminIdnew == adminId;
                                //(snap[index]['AdminID'] == AdminID[0])
                                return isAdmin
                                    ? Container(
                                        height: 70,
                                        width: double.infinity,
                                        margin:
                                            const EdgeInsets.only(bottom: 12),
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
                                                //for profile image
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Material(
                                                  elevation: 8,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  child: InkWell(
                                                      //splashColor: Colors.black26,
                                                      onTap: () {},
                                                      child: Image.asset(
                                                        'assets/images/Profile.png',
                                                        height: 50,
                                                        width: 50,
                                                        fit: BoxFit.contain,
                                                      )),
                                                ),
                                              ),
                                              //to only show the allowed people to admin

                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 90),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  snap[index]['Name'],
                                                  style: const TextStyle(
                                                    color: Color(0xff0da6c2),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              //container for button

                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  InkWell(
                                                      // height: 80,
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              StudentAddform(
                                                            documentId: snapshot
                                                                    .data![1]
                                                                [index],
                                                          ),
                                                        ));
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/addStudent.png',
                                                        height: 30,
                                                        width: 40,
                                                        fit: BoxFit.contain,
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        // print(docIDS[index]);
                                                        print(
                                                            "mmmmmmmmmmmmmmmmmm");
                                                        int Tab = 5;
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              Nav(
                                                            documentId: snapshot
                                                                    .data![1]
                                                                [index],
                                                            TabValue: 5,
                                                          ),
                                                        ));
                                                      },
                                                      //height: 80,
                                                      child: Image.asset(
                                                        'assets/images/edit.png',
                                                        height: 30,
                                                        width: 40,
                                                        fit: BoxFit.contain,
                                                      )),
                                                  InkWell(
                                                      //height: 80,
                                                      onTap: () {
                                                        //////askkkk
                                                        /* Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        //askkkkk faten where should it go ??;
                                    // */
                                                        //                                             parentx.DeleteParent(
                                                        //                                                 Admin()
                                                        //                                                     .docIDS[index]);
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/delete.png',
                                                        height: 30,
                                                        width: 40,
                                                        fit: BoxFit.contain,
                                                      )),
                                                ],
                                              ),

                                              //this is the same as up but with text
                                              /* Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/addStudent.png',
                                                // height: 60,
                                                // width: 40,
                                                // fit: BoxFit.contain,
                                              ),
                                              Text('cat')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/edit.png',
                                                height: 40,
                                                // width: 40,
                                                // fit: BoxFit.contain,
                                              ),
                                              Text('cat')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/delete.png',
                                                // height: 60,
                                                // width: 40,
                                                // fit: BoxFit.contain,
                                              ),
                                              Text('cat')
                                            ],
                                          ),
                                        ),
                                    
                                        //here end
                                    
                                        Container(
                                            margin: const EdgeInsets.only(right: 20),
                                            alignment: Alignment.centerRight,
                                            child: Row(children: [
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                      textStyle:
                                                          TextStyle(fontSize: 10)),
                                                  child: Text("Update Parent"),
                                                  onPressed: () {
                                                    // print(docIDS[index]);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StudentAddform(
                                                        documentId: docIDS[index],
                                                      ),
                                                    ));
                                                  }),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                      textStyle:
                                                          TextStyle(fontSize: 10)),
                                                  child: Text("Update Parent"),
                                                  onPressed: () {
                                                    // print(docIDS[index]);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StudentAddform(
                                                        documentId: docIDS[index],
                                                      ),
                                                    ));
                                                  }),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 14,
                                                          vertical: 8),
                                                      textStyle:
                                                          TextStyle(fontSize: 10)),
                                                  child: Text("Update Parent"),
                                                  onPressed: () {
                                                    // print(docIDS[index]);
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StudentAddform(
                                                        documentId: docIDS[index],
                                                      ),
                                                    ));
                                                  })
                                            ])),
                                        //],
                                      ]),*/
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
              )*/
      // ],
      // ),
      // ),
      //),
    );
  }

  Widget CreateDialog3(BuildContext context) {
    String Msg = "تجاهل التغييرات";

    return CupertinoAlertDialog(
      title: Text("حذف ولي أمر"),
      content: Text("هل انت متأكد انك تريد حذف ولي الأمر؟"),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => Paretdisplay()));
            },
            child: Text("الغاء")),
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              parentx.DeleteParent(CurrentID);
            },
            child: Text("موافق")),
      ],
    );
  }
}



/*
//this class is for search for now it is not liked to parent and studetn
class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Parent",
    "student",
    "school",
    "teacher",
    "delegator",
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}*/
