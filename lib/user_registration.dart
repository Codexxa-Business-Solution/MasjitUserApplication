import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/getEmailPasswordREsponseModel.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_login_screen.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/constant.dart';

import 'common.color.dart';

class UserRegistration extends StatefulWidget {
  final String phoneNum;
  const UserRegistration({Key? key,required this.phoneNum}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

bool searchBar = false;
late Box box;
final fields = <String, dynamic>{};
final _emailFocus = FocusNode();
final _passwordFocus = FocusNode();
final _conPasswordFocus = FocusNode();
final _areaFocus = FocusNode();
final _cityFocus = FocusNode();
final _numberFocus = FocusNode();
final _stateFocus = FocusNode();
final _countryFocus = FocusNode();
bool _validate = false;
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController numberController = TextEditingController();
TextEditingController conPassController = TextEditingController();
TextEditingController areaController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController countryController = TextEditingController();
final _formKey = GlobalKey<FormState>();

String? validatepass(value) {
  if (value!.isEmpty) {
    return 'Area cannot be empty';
  } else if (value.length < 3) {
    return 'Area must be at least 3 characters long.';
  }
  return null;
}

@override
void dispose() {
  areaController.dispose();
//  _confirmPasswordController.dispose();
  // super.dispose();
}

class _UserRegistrationState extends State<UserRegistration> {
  @override
  void initState() {
    box = Hive.box(kBoxName);
  }

  Future<UserRegisterRespnseModel>? result;

  validate() {
    if (_formKey.currentState!.validate()) {
      print("validated");
      result = getRegisterUsers();
      result?.then((value) {
        var box = Hive.box(kBoxName);
        box.put(kToken, value.data?.token);
        print("token ${box.get("token")}");

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ParentTabBarScreen()));

      });
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,

        body: Column(
          // shrinkWrap: true,
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.1,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        CommonColor.LEFT_COLOR,
                        CommonColor.RIGHT_COLOR
                      ]),
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: CommonColor.RIGHT_COLOR))),
              child:
              MainHeading(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
            SizedBox(
              height: SizeConfig.screenHeight*0.9,

              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onDoubleTap: () {},
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 30),
                  shrinkWrap: true,

                  children: [
                    AreaContant(SizeConfig.screenHeight, SizeConfig.screenWidth),
                    ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget MainHeading(double parentHeight, double parentWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => const LoginScreen()));
          },
          onDoubleTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: parentWidth * .04),
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.02),
              child: Icon(
                Icons.arrow_back_ios,
                size: parentHeight * .03,
                color: CommonColor.WHITE_COLOR,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.02),
          child: Text(
            "Registration",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                fontFamily: 'Roboto_Medium',
                letterSpacing: parentWidth * 0.003,
                fontWeight: FontWeight.w400,
                color: CommonColor.WHITE_COLOR),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: parentWidth * .04),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: parentHeight * .03,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget AreaContant(double parentHeight, double parentWidth) {
    return Form(
      key: _formKey,
      child:

      ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child:
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.009),
                      child: const Text(
                        "Email",
                        style:
                        TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        left: parentWidth * 0.03,
                        right: parentWidth * 0.03),
                    child: TextFormField(
                        focusNode: _emailFocus,
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Field Is Required';
                          }  else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                color:  CommonColor.REGISTRARTION_COLOR
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            //borderRadius: BorderRadius.circular(10)
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                color: CommonColor.SEARCH_TEXT_COLOR
                            ))))
              ])),
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child:
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.009),
                      child: const Text(
                        "Password",
                        style:
                        TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        left: parentWidth * 0.03,
                        right: parentWidth * 0.03),
                    child: TextFormField(
                        focusNode: _passwordFocus,
                        controller: passwordController,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password Field Is Required';
                          } else if (passwordController.text.length < 6) {
                            return 'Password Must Be 6 Character';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color:  CommonColor.REGISTRARTION_COLOR
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                color: CommonColor.SEARCH_TEXT_COLOR
                            ))))
              ])),
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child:
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.009),
                      child: const Text(
                        "Area",
                        style:
                        TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        left: parentWidth * 0.03,
                        right: parentWidth * 0.03),
                    child: TextFormField(
                        focusNode: _areaFocus,
                        controller: areaController,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Area cannot be empty';
                          } else if (value.length < 3) {
                            return 'Area must be at least 3 characters long.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Area',
                            labelStyle: const TextStyle(
                                color:  CommonColor.REGISTRARTION_COLOR
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            //borderRadius: BorderRadius.circular(10)
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                color: CommonColor.SEARCH_TEXT_COLOR
                            ))))
              ])),
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child:
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.009),
                      child: const Text(
                        "Mobile Number",
                        style:
                        TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        left: parentWidth * 0.03,
                        right: parentWidth * 0.03),
                    child: TextFormField(
                        focusNode: _numberFocus,
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 10 || value.trim().length > 10) {
                            return 'Please Enter Valid Number';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: const TextStyle(
                                color:  CommonColor.REGISTRARTION_COLOR
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            //borderRadius: BorderRadius.circular(10)
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                color: CommonColor.SEARCH_TEXT_COLOR
                            ))))
              ])),
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.02, right: parentWidth * 0.02),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: parentWidth * 0.03, top: parentHeight * 0.009),
                    child: const Text(
                      "City",
                      style:
                      TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.01,
                      left: parentWidth * 0.03,
                      right: parentWidth * 0.03),
                  child: TextFormField(
                      controller: cityController,
                      keyboardType: TextInputType.text,
                      focusNode: _cityFocus,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'City cannot be empty';
                        } else if (value.length < 3) {
                          return 'City must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: const TextStyle(
                              color:  CommonColor.REGISTRARTION_COLOR
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          //borderRadius: BorderRadius.circular(10)
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.SEARCH_TEXT_COLOR
                          ))))
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.02, right: parentWidth * 0.02),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: parentWidth * 0.03, top: parentHeight * 0.009),
                    child: const Text(
                      "State",
                      style:
                      TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.01,
                      left: parentWidth * 0.03,
                      right: parentWidth * 0.03),
                  child: TextFormField(
                      controller: stateController,
                      keyboardType: TextInputType.text,
                      focusNode: _stateFocus,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'State cannot be empty';
                        } else if (value.length < 3) {
                          return 'State must be at least 3 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'State',
                          labelStyle: const TextStyle(
                              color:  CommonColor.REGISTRARTION_COLOR
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          //borderRadius: BorderRadius.circular(10)
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.SEARCH_TEXT_COLOR
                          ))))
            ]),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.009),
                      child: const Text(
                        "Country",
                        style:
                        TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.01,
                        left: parentWidth * 0.03,
                        right: parentWidth * 0.03),
                    child: TextFormField(
                        controller: countryController,
                        focusNode: _countryFocus,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Country cannot be empty';
                          } else if (value.length < 3) {
                            return 'City must be at least 3 characters long.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Country',
                            labelStyle: const TextStyle(
                                color:  CommonColor.REGISTRARTION_COLOR
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            //borderRadius: BorderRadius.circular(10)
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                color: CommonColor.SEARCH_TEXT_COLOR
                            ))))
              ])),
        ],
      ),

    );
  }


  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        validate();

      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.1,
            left: parentWidth * 0.1,
            right: parentWidth * 0.1),
        child: Container(
            height: parentHeight * 0.06,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
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


  Future<UserRegisterRespnseModel> getRegisterUsers() async {

    print("HIIIIIIII ${areaController.text.trim()}"
        " ${cityController.text.trim()} "
        "${stateController.text.trim()}"
        " ${countryController.text.trim()}" " ${emailController.text.trim()}"
        " ${passwordController.text.trim()}"" ${widget.phoneNum}");
    try {
      final result = await http.post(
          Uri.parse("http://masjid.exportica.in/api/user/register"),
          body: {
            "phone": numberController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
            "area": areaController.text.trim(),
            "city": cityController.text.trim(),
            "state": stateController.text.trim(),
            "country": countryController.text.trim()
          });
      print("new user:" + result.body);
      if (result.statusCode == 200) {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ParentTabBarScreen()));
      }

      return userRegisterRespnseModelFromJson(result.body);
    } catch (e) {
      rethrow;
    }
  }


/* Future<UserUpdateRegistrationResponceModel> getRegisterVendors() async {
    print("HIIIIIIII ${areaController.text.trim()}"
        " ${cityController.text.trim()} "
        "${stateController.text.trim()}"
        " ${countryController.text.trim()}");

    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};
    try {
      final result = await http.post(
          Uri.parse("http://masjid.exportica.in/api/user/update"),
          headers: headersList,
          body: {
            "area": areaController.text.trim(),
            "city": cityController.text.trim(),
            "state": stateController.text.trim(),
            "country": countryController.text.trim()
          });
      print("new user:" + result.body);
      if (result.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParentTabBarScreen()));
      }

      return userUpdateRegistrationResponceModelFromJson(result.body);
    } catch (e) {
      throw e;
    }
  }*/
}
