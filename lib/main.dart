import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/enter_mobile_number.dart';
import 'package:masjiduserapp/masjit_main_new_screen.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_login_screen.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:masjiduserapp/user_registration.dart';
import 'package:masjiduserapp/util/constant.dart';

import 'common.color.dart';

import 'masjit_vendor_frame.dart';

Future<void> main() async {
  print("kkkkkk   ${kBoxName}");
  await Hive.initFlutter();
  Hive.openBox(kBoxName);
  var box = await Hive.openBox(kBoxName);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  void initState() {
    // super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box(kBoxName);
    Widget destination = UserRegistration(phoneNum: "",);

    if (box.get(kToken, defaultValue: null) != null) {
      //   print("registrationToken ${box.get("token")} ${box.get(kMasjid)}");
      destination = MasjitMainScreen(
        tabbr: '',
        masjitIdRemoved: '',
        onNext: () {},
      );
    } else if (!box.get(kOnBorading, defaultValue: false)) {
      //  print("registrationToken ${box.get("token")} ${box.get(kMasjid)}");
      destination = MasjitVendorFrame();
    }
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/frame': (BuildContext context) => MasjitVendorFrame(),
          '/userRegistartionScreen': (BuildContext context) =>
              LoginScreen(),
          '/homeScreen': (BuildContext context) => ParentTabBarScreen(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    startTimer();
    Hive.openBox(kBoxName);
    var box = Hive.openBox(kBoxName);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.screenBottom),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: splash(SizeConfig.screenHeight, SizeConfig.screenWidth),
      ),
    );
  }

  Widget splash(double parentHeight, double parentWidth) {
    return Center(
        child: Image(image: AssetImage("assets/images/masjit_logo.jpeg")));
  }

  void navigateParentPage() {
    Navigator.of(context).pushReplacementNamed('/frame');
  }

  void navigateRegistrationPage() {
    Navigator.of(context).pushReplacementNamed('/userRegistartionScreen');
  }

  void navigateHomePage() {
    Navigator.of(context).pushReplacementNamed('/homeScreen');
  }

  startTimer() async {
    var durtaion = new Duration(seconds: 2);

    try {
      var box = await Hive.openBox(kBoxName);

      var accessToken = await box.get('token');
      print("session token   ${accessToken}");

      if (accessToken == null) {
        return Timer(durtaion, navigateRegistrationPage);
      } else if (accessToken != null) {
        return Timer(durtaion, navigateHomePage);
      }
    } catch (e) {
      print("eeeeeeee  $e");
    }
    return Timer(durtaion, navigateParentPage);
  }
}
