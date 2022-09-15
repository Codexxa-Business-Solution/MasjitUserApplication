import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/user_register_response_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_registration.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

import 'common.color.dart';

import 'map_location_register.dart';
import 'parent_masjit_location_name.dart';

const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(
    fontSize: 22,
    color: CommonColor.REGISTRARTION_TRUSTEE /* Color.fromRGBO(30, 60, 87, 1)*/,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE),
  ),
);

class EnterOtpNumber extends StatefulWidget {
  const EnterOtpNumber({
    Key? key,
    required this.mobileNumber,
  }) : super(key: key);
  final String mobileNumber;

  @override
  _EnterOtpNumberState createState() => _EnterOtpNumberState();
}

class _EnterOtpNumberState extends State<EnterOtpNumber> {
  bool _checkbox = false;
  bool _checkboxListTile = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(0.0),
    );
  }

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var getPhoneNumber;
  late Future<UserPhoneNumberRegistrationResponceModel> result;


  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    result = getOtpApi();
    super.initState();
    if (mounted) {
      setState(() {
        print(getPhoneNumber);
        // print("Id ${widget.phoneNumber}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onDoubleTap: () {},
      child: ListView(
        // padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.2),
        shrinkWrap: true,
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.10,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: getAddMainHeadingLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
          Container(
              height: SizeConfig.screenHeight * 0.88,
              child: Column(
                children: [
                  getFirstImageFrame(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ContinueButton(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                ],
              ))
        ],
      ),
    ));
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            onDoubleTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * .04),
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.02),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: parentHeight * .025,
                    color: CommonColor.BLACK,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.07),
            child: Text(
              "SAHR / IFTAR",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.transparent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth * .04),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: parentHeight * .03,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.05),
      child: Center(
        child: Container(
          width: parentWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: parentHeight * .23,
                width: parentWidth * .58,
                decoration: BoxDecoration(
                    color: CommonColor.GRAY_COLOR,
                    borderRadius: BorderRadius.circular(30)),

                /* child: ClipRRect(
                 borderRadius: BorderRadius.all(Radius.circular(20)),

                // borderRadius: BorderRadius.circular(8),
                child: const Image(
                    image: AssetImage("assets/images/frame_one.png"),
                    fit: BoxFit.cover,
                  ),
               ),*/
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.03,
                    left: parentWidth * 0.10,
                    right: parentWidth * 0.1),
                child: Text(
                  "Enter the OTP.",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      color: CommonColor.REGISTRARTION_TRUSTEE,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto_bold'),
                  //textAlign: TextAlign.center,
                ),
              ),
              /* Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.01,
                    left: parentWidth * 0.10,
                    right: parentWidth * 0.1),
                child: Text(
                  "Send to +918397055611",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      color: CommonColor.BLACK,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto_bold'),
                  //textAlign: TextAlign.center,
                ),
              ),*/
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(right: parentWidth * 0.0),
                        child: Text(
                          " Send to ",
                          style: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.BLACK_COLOR),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.0),
                      child: Text(
                        "+91" + widget.mobileNumber,
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.BLACK_COLOR),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Directionality(
                        // Specify direction if desired
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: pinController,
                          focusNode: focusNode,

                          // defaultPinTheme: defaultPinTheme,
                          validator: (value) {
                            return value == '1234' ? null : 'Pin is incorrect';
                          },
                          onClipboardFound: (value) {
                            debugPrint('onClipboardFound: $value');
                            pinController.setText(value);
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 9),
                                width: 20,
                                height: 1,
                                color: CommonColor.REGISTRARTION_TRUSTEE,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              //  borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: CommonColor.REGISTRARTION_TRUSTEE),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              // color: fillColor,
                              //borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: CommonColor.REGISTRARTION_TRUSTEE),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(
                                color: CommonColor.REGISTRARTION_TRUSTEE),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // width: SizeConfig.screenWidth * .09,
                            child: Image.asset(
                              'assets/images/showImage.png',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: parentWidth * 0.0),
                            child: TextButton(
                              child: Text(
                                "Show",
                                style: TextStyle(
                                    fontFamily: "Roboto_Regular",
                                    fontWeight: FontWeight.w400,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.0,
                                    color: CommonColor.SHOW_BUTTON),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
       result.then((value) => setState((){
    value.data?.token;

          var box = Hive.box(kBoxName);

          box.put(kToken,value.data?.token);
         print("token ${box.get("token")}");
         Navigator.push(
             context, MaterialPageRoute(builder: (context) => UserRegistration()));




       }));
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.01,
            left: parentWidth * 0.1,
            right: parentWidth * 0.1),
        child: Column(
          children: [
            Container(
                height: parentHeight * 0.06,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        CommonColor.LEFT_COLOR,
                        CommonColor.RIGHT_COLOR
                      ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                        color: CommonColor.WHITE_COLOR),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.0),
                      child: Text(
                        " Didn’t receive SMS? ",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.BLACK_COLOR),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: parentWidth * 0.0),
                    child: Text(
                      "Resend",
                      style: TextStyle(
                          fontFamily: "Roboto_Regular",
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          color: CommonColor.CANCLE_BUTTON),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

/*  Future<UserPhoneNumberRegistrationResponceModel> getOtpApi() async {


    final msg = jsonEncode({"phone": widget.mobileNumber.toString()});

    var response = await http.post(
      Uri.parse('http://masjid.exportica.in/api/user/verify'),
      body: {msg},
    );

    if (response.statusCode == 200) {
      print("Yess.. ${response.body}");

      print("yyyyyy");

      return userPhoneNumberRegistrationResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }*/


  Future<UserPhoneNumberRegistrationResponceModel> getOtpApi() async {
    try {
      final result = await http.post(
          Uri.parse("http://masjid.exportica.in/api/user/verify"),
          body: {
            "phone": widget.mobileNumber.toString(),
          });
      print("new order:" + result.body);

      return userPhoneNumberRegistrationResponceModelFromJson(result.body);
    } catch (e) {
      throw e;
    }
  }


}
