import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/masjit_main_new_screen.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_registration.dart';
import 'package:masjiduserapp/util/constant.dart';


import 'common.color.dart';

import 'masjit_vendor_frame.dart';

Future<void> main() async{

  await Hive.initFlutter();
  var box = await Hive.openBox(kBoxName);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver{
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
    var  box = Hive.box(kBoxName);
    Widget destination = UserRegistration();

    if(box.get(kToken, defaultValue: null) != null){
   //   print("registrationToken ${box.get("token")} ${box.get(kMasjid)}");
      destination = MasjitMainScreen(tabbr: '', masjitIdRemoved: '',);
    } else if(!box.get(kOnBorading, defaultValue: false)){
    //  print("registrationToken ${box.get("token")} ${box.get(kMasjid)}");
      destination =MasjitVendorFrame();
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.screenBottom),
      child: Scaffold(
//backgroundColor: Colors.white,

        body: Center(
          child: Column(
            children: [
              splash(SizeConfig.screenHeight, SizeConfig.screenWidth),
              text(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget splash(double parentHeight, double parentWidth) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.3,
            left: parentWidth * 0.3,
            right: parentWidth * 0.3),
        child: Center(
            child:
            Image(image: AssetImage("assets/images/splash.png"))),
      ),
    );
  }

  Widget text(double parentHeight, double parentWidth) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.045),
              child: Text(
                "Logo",
                style: TextStyle(
                    fontSize: parentHeight * 0.06,
                    color: CommonColor.LOGO_COLOR,
                    fontFamily: "Regular",
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
       //   Padding(
         //   padding: EdgeInsets.only(top: p////////////////////////////////////////////////////////////////////////////////arentHeight * 0.025),
           // child: Text(
             // "Connect with Alumni. Expand your network.",
              //style: TextStyle(fontFamily: "Regular",
                //fontWeight: FontWeight.w300,
                //color: CommonColor.TEXT_COLOR,
                //fontSize///////: SizeConfig.safeBlockHorizontal * 3.5,),
              //textScaleFactor: 1.0,
            //),
          //),
        ],
      ),
    );
  }

  void navigateParentPage() {
    Navigator.of(context).pushReplacementNamed('/frame');
  }

  startTimer() {
    var durtaion = new Duration(seconds: 2);
    return Timer(durtaion, navigateParentPage);
  }
}