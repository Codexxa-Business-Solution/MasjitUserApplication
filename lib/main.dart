import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masjiduserapp/size_config.dart';


import 'common.color.dart';

import 'masjit_vendor_frame.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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