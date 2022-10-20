import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/enter_mobile_number.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/userLoginResponseModel.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/user_registration.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:masjiduserapp/util/get_location.dart';

import 'masjit_user_app_api/place.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<UserLoginResponseModel>? result;
  final _formKey = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  Place? address;
  String _address = '';

  String? validatepass(value) {
    if (value!.isEmpty) {
      return 'Area cannot be empty';
    } else if (value.length < 3) {
      return 'Area must be at least 3 characters long.';
    }
    return null;
  }

  Future<UserLoginResponseModel>? resultt;

  validate() {
    if (_formKey.currentState!.validate()) {
      print("validated");
      resultt = getLoginUsers();
      resultt?.then((value) {
        var box = Hive.box(kBoxName);
        box.put(kToken, value.data?.token);
        print("token ${box.get("token")}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ParentTabBarScreen()));
      });
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          getTitleLayout(),
          getEmailField(),
          getLocationcode(SizeConfig.screenHeight, SizeConfig.screenWidth),
          getLoginButton(),
          getBottomText()
        ],
      ),
    );
  }

  Widget getTitleLayout() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 18),
            child: Text(
              "LOGIN",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto_Medium',
                  //letterSpacing: parentWidth * 0.003,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              /*letterSpacing: 3*/
            ),
          ),
        ],
      ),
    );
  }

  Widget getEmailField() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
            child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'email Field Is Required';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        const TextStyle(color: CommonColor.REGISTRARTION_COLOR),
                    contentPadding: const EdgeInsets.all(14),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        color: CommonColor.REGISTRARTION_TRUSTEE))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Password Field Is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        const TextStyle(color: CommonColor.REGISTRARTION_COLOR),
                    contentPadding: const EdgeInsets.all(15),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        color: CommonColor.REGISTRARTION_TRUSTEE))),
          ),
        ],
      ),
    );
  }

  Widget getPasswordField() {
    return Form(
      key: _formKeyPassword,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Password Field Is Required';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Password',
                contentPadding: const EdgeInsets.all(15),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: CommonColor.REGISTRARTION_COLOR),
                    borderRadius: BorderRadius.circular(10.0)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: CommonColor.REGISTRARTION_COLOR),
                    borderRadius: BorderRadius.circular(10.0)),
                hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    color: CommonColor.REGISTRARTION_TRUSTEE))),
      ),
    );
  }

  Widget getLocationcode(double parentHeight, double parentWidth) {
    return Stack(
      children: [
        Visibility(
          visible: _address.isNotEmpty ? false : true,
          child: Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.03,
                left: parentWidth * 0.3,
                right: parentWidth * 0.3),
            child: GestureDetector(
              onDoubleTap: () {},
              onTap: () {
                Future<Place?> result = Navigator.of(context).push<Place>(
                  MaterialPageRoute(
                    builder: (context) => const GetLocation(),
                  ),
                );

                result.then((value) {
                  if (value == null) return;
                  setState(() {
                    address = value;
                    _address =
                        'Area ${address?.lat},\n City ${address?.long}, \n Postal Code ${address?.postalCode},\n State ${address?.administrativeArea}, \n Country ${address?.country}';
                    setState(() {});
                  });
                });
              },
              child: Container(
                height: parentHeight * 0.06,
                decoration: BoxDecoration(

                    //color: Colors.green,


                      border: Border.all(color: CommonColor.REGISTRARTION_COLOR),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.01, right: parentWidth * 0.01),
                      child: Text(
                        "Select Location",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _address.isNotEmpty ? true : false,
          child: Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.02, left: parentWidth * 0.04,right: parentWidth*0.04),
            child: Container(
              width: parentWidth * 1,
              height: parentHeight * 0.06,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: CommonColor.REGISTRARTION_COLOR),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: parentWidth * 0.02),
                    child: _address.isNotEmpty
                        ? Text(
                            "${address?.subLocality}, ${address?.locality}, ${address?.postalCode}")
                        : Text(""),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget getLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 35),
      child: GestureDetector(
        onTap: () {
          var box = Hive.box(kBoxName);
          box.put(kUserLatitude, address?.lat);
          box.put(kUserLongitude, address?.long);
          box.put(kUserSubLocality, address?.subLocality);
          box.put(kUserLocality, address?.locality);

          print(
              "${box.get("currentLatitude")}  ${box.get("currentLongitude")}");

          _address.isNotEmpty
              ? validate()
              : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Please Select Your Current Location")));
          /* validate();*/
        },
        onDoubleTap: () {},
        child: Container(
            height: 43,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "Login",
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

  Widget getBottomText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "New User Register?",
            style: TextStyle(
                fontSize: 15,
                fontFamily: "Roboto_Regular",
                fontWeight: FontWeight.w400,
                // fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                color: CommonColor.BLACK_COLOR),
          ),
          GestureDetector(
            onDoubleTap: () {},
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserRegistration(
                            phoneNum: '',
                          )));
            },
            child: Container(
              color: Colors.transparent,
              child: const Text(
                " Register",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: CommonColor.RIGHT_COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<UserLoginResponseModel> getLoginUsers() async {
    try {
      final result = await http
          .post(Uri.parse("http://masjid.exportica.in/api/user/verify"), body: {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });
      print("new user:" + result.body);
      print("statusCode:" + result.statusCode.toString());

      if (result.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(result.body);

        if (!body['success']) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${body['message']}")));
        }
      }

      return userLoginResponseModelFromJson(result.body);
    } catch (e) {
      rethrow;
    }
  }
}
