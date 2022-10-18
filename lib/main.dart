import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/masjit_main_new_screen.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/showNotificationApi.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_login_screen.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:masjiduserapp/user_registration.dart';
import 'package:masjiduserapp/util/constant.dart';


import 'masjit_vendor_frame.dart';

Future<void> main() async {
  
  await Hive.initFlutter();
  Hive.openBox(kBoxName);
  var box = await Hive.openBox(kBoxName);
  
  await AndroidAlarmManager.initialize();
  NotificationService().init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

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
    Widget destination = const UserRegistration(phoneNum: "",);

    if (box.get(kToken, defaultValue: null) != null) {
      //   print("registrationToken ${box.get("token")} ${box.get(kMasjid)}");
      destination = MasjitMainScreen(
        tabbr: '',
        masjitIdRemoved: '',
        onNext: () {},
      );
    } else if (!box.get(kOnBorading, defaultValue: false)) {
      //  print("registrationToken ${box.get("token")} ${box.get(kMasjid)}");
      destination = const MasjitVendorFrame();
    }
    return MaterialApp(
        title: 'Azan for Salah User',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: ''),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/frame': (BuildContext context) => const MasjitVendorFrame(),
          '/userRegistartionScreen': (BuildContext context) =>
              const LoginScreen(),
          '/homeScreen': (BuildContext context) => const ParentTabBarScreen(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

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
      child:  Scaffold(
        backgroundColor: Colors.white,
        body: splash(SizeConfig.screenHeight, SizeConfig.screenWidth),
      ),
    );
  }

  Widget splash(double parentHeight, double parentWidth) {
    return const Center(
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
    var durtaion = const Duration(seconds: 2);

    try {
      var box = await Hive.openBox(kBoxName);

      var accessToken = await box.get('token');
      print("session token   $accessToken");

      if (accessToken == null) {
        return Timer(durtaion, navigateParentPage);
      } else if (accessToken != null) {
        return Timer(durtaion, navigateHomePage);
      }
    } catch (e) {
      print("eeeeeeee  $e");
    }
    return Timer(durtaion, navigateParentPage);
  }
}
