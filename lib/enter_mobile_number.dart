import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masjiduserapp/enter_otp_number.dart';
import 'package:masjiduserapp/size_config.dart';

import 'package:http/http.dart' as http;

import 'common.color.dart';

class EnterMobileNumber extends StatefulWidget {
  const EnterMobileNumber({Key? key}) : super(key: key);

  @override
  _EnterMobileNumberState createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {
  bool _checkbox = false;
  bool _checkboxListTile = false;
  final _phoneFocus = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onDoubleTap: () {},
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.2),
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
                  //height: SizeConfig.screenHeight,
                  child: Column(
                    children: [
                      getFirstImageFrame(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                      ContinueButton(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),

                    ],
                  )


              )
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
                  padding: EdgeInsets.only(top: parentHeight * 0.07),
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
      padding: EdgeInsets.only(top: parentHeight * 0.04),
      child: Center(
        child: Container(
          width: parentWidth,
          height: parentHeight*.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: parentHeight * .23,
                width: parentWidth * .58,
                decoration: BoxDecoration(
                    color: CommonColor.GRAY_COLOR,
                    borderRadius: BorderRadius.circular(30)),

              ),
              Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.06,
                    left: parentWidth * 0.13,
                    right: parentWidth * 0.1),
                child: Text(
                  "Enter the Mobile No.  we will send you one time verification code to start.  ",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      color: CommonColor.BLACK,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto_bold'),
                  //textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.02,
                    left: parentWidth * 0.05,
                    right: parentWidth * 0.02),
                child: Container(
                  height: parentHeight * 0.08,
                  width: parentHeight * 0.9,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: parentWidth * 0.07,
                            right: parentWidth * 0.08,
                            top: parentHeight * 0.009),
                        child: Container(
                          height: parentHeight * .06,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: CommonColor.REGISTRARTION_COLOR,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.red,
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: SizeConfig.screenWidth * 0.01,
                                        top: SizeConfig.screenHeight * 0.0),
                                    child: Container(
                                      width: SizeConfig.screenWidth * .08,
                                      child: Image.asset(
                                        'assets/images/flag.png',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentWidth * 0.0),
                                    child: Text(
                                      "+91",
                                      style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: parentWidth * 0.01,
                                      right: parentWidth * 0.01),
                                  child: TextFormField(
                                    focusNode: _phoneFocus,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    autocorrect: true,
                                    textInputAction: TextInputAction.next,

                                    decoration: InputDecoration(
                                      hintText: "Enter your Mobile No.",
                                      contentPadding: EdgeInsets.only(
                                          left: parentWidth * 0.03,
                                          bottom: parentHeight * 0.009),
                                      hintStyle: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        // color: CommonColor.DIVIDER_COLOR,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    // controller: emailController,
                                    style: TextStyle(
                                      fontFamily: "Roboto_Regular",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
                                      // color: CommonColor.WHITE_COLOR,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.08),
                        child: Checkbox(
                          side: const BorderSide(
                            // set border color here
                            color: CommonColor.REGISTRARTION_TRUSTEE,
                          ),
                          value: _checkbox,
                          checkColor: Colors.white,
                          activeColor: CommonColor.REGISTRARTION_TRUSTEE,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.006,
                            left: parentWidth * 0.0,
                            right: parentWidth * 0.06),
                        child: Text(
                          "By clicking Sign up, you agree to our \nTerms & Conditions and Privacy Policy. ",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              color: CommonColor.BLACK,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto_bold'),
                          //textAlign: TextAlign.center,
                        ),
                      ), //textAlign: TextAlign.center,
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
        onTap: () async {
          showDialog(context: context, builder: (context){
            return Center(child: CircularProgressIndicator());

          }

          );
          //await Future<int>.delayed(Duration(seconds: 5));

         // Navigator.of(context, rootNavigator: true).pop();
          await auth.verifyPhoneNumber(
              phoneNumber: "+91${phoneController.text}",
              verificationCompleted: (phoneAuthCredential) async {},
              verificationFailed: (verificationFailed) {
                print(verificationFailed);

              },
              codeSent: (String verificationId, int? resendToken) async {
                setState(() {
                  verificationID = verificationId;
                  print('verid $verificationID');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnterOtpNumber(
                                mobileNumber: phoneController.text,
                                auth: '',
                                verificationId: verificationID,
                              )));

                });
                //Navigator.of(context).pop();
              },
              codeAutoRetrievalTimeout: (verificationID) async {});

        },

        child: Padding(
          padding: EdgeInsets.only(
              top: parentHeight * 0.07,
              left: parentWidth * 0.1,
              right: parentWidth * 0.1),
          child: Container(
              height: parentHeight * 0.06,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                      color: CommonColor.WHITE_COLOR),
                ),
              )),
        ),


    );

  }
}
