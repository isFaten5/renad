import 'package:circlight/Pages/CreateParent.dart';
import 'package:circlight/Pages/constants.dart';

import 'package:circlight/Pages/displayParent.dart';
import 'package:circlight/Pages/displayStudent.dart';
import 'package:circlight/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlight/Pages/firebase_options.dart';
import 'package:circlight/Pages/Nav.dart';
import 'Pages/CreateStudent.dart';

import 'Pages/appbar.dart';

import 'Pages/base_screen.dart';
import 'Pages/edit5.dart';
import 'Pages/editStudent.dart';
import 'Pages/hommme.dart';

Future main() async {
//start of firebase connection
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(LoginUiApp());
  //end firebase connection
}

class LoginUiApp extends StatelessWidget {
  Color _primaryColor = const Color(0xff0da6c2);
  Color _accentColor = const Color(0xff57d77a);

  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Login UI',
      title: 'Flutter Auth',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        primarySwatch: Colors.grey,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        /*  inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),*/
      ),
      /* home: editparent6(
            Confirm: false,
            Index: 1,
            documentId: "21AqxvymlaHWM4DfLFtS",
            whichpag: 0,
            TheValue: "")*/
      //  home: StudentAddform(
      //    documentId: "GpRfqodKgYCqobAL2r6w",
      //   ),

      /*home: editparent5(
          Confirm: false,
          Index: 1,
          TheValue: "",
          documentId: "Cu5WEwZNoe5eqIl0NOJp",
          whichpag: 0,
      //    DropDown: false),*/
      // home: Nav(
      //   documentId: "Cu5WEwZNoe5eqIl0NOJp",
      //   TabValue: 0,
      // ),
      //   home: MyHomePage(),

      home: const WelcomeScreen(),
    );
  }
}
