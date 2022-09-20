import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/user_register_response_model.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/user_update_response_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/constant.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'common.color.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

bool searchBar = false;
late Box box;
final fields = <String, dynamic>{};
final _areaFocus = FocusNode();
final _cityFocus = FocusNode();
final _stateFocus = FocusNode();
final _countryFocus = FocusNode();
bool _validate = false;
TextEditingController phoneController = TextEditingController();
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

  validate() {
    if (_formKey.currentState!.validate()) {
      print("validated");
      getRegisterVendors();
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
            Container(
              height: SizeConfig.screenHeight*0.9,

              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onDoubleTap: () {},
                child: Column(

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
    return Container(
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
                    size: parentHeight * .03,
                    color: CommonColor.WHITE_COLOR,
                  ),
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

  Widget AreaContant(double parentHeight, double parentWidth) {
    return Form(
      key: _formKey,
      child:

        Column(

          children: <Widget>[
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
                        child: Text(
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
                              contentPadding: const EdgeInsets.all(12),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: CommonColor.REGISTRARTION_COLOR),
                                  borderRadius: BorderRadius.circular(10.0)),
                              //borderRadius: BorderRadius.circular(10)
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: CommonColor.REGISTRARTION_COLOR),
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
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
                      child: Text(
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
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            //borderRadius: BorderRadius.circular(10)
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
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
                      child: Text(
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
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            //borderRadius: BorderRadius.circular(10)
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: CommonColor.REGISTRARTION_COLOR),
                                borderRadius: BorderRadius.circular(10.0)),
                            hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
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
                        child: Text(
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
                              contentPadding: const EdgeInsets.all(12),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: CommonColor.REGISTRARTION_COLOR),
                                  borderRadius: BorderRadius.circular(10.0)),
                              //borderRadius: BorderRadius.circular(10)
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: CommonColor.REGISTRARTION_COLOR),
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              ))))
                ])),
          ],
        ),

    );
  }

/*  Widget CityContant(double parentHeight, double parentWidth) {
    return Form(
      key: _formKeytwo,
      child: Padding(
        padding:
        EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02),
        child: Container(
            height: parentHeight * 0.14,
            width: parentHeight * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: Colors.grey.shade50,
                  offset: const Offset(-1, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade50,
                  offset: const Offset(1, 0),
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: parentWidth * 0.03, top: parentHeight * 0.009),
                        child: Text(
                          "City",
                          style: TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                        ),
                      ),
                    ],
                  ),
                  Padding(

                      padding: const EdgeInsets.all(3.0),
                      child: TextFormField(
                          obscureText: true,
                          controller: cityController,
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
                              contentPadding: const EdgeInsets.all(12), isDense: true,

                              //borderRadius: BorderRadius.circular(10)
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10.0)),
                              hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              ))))


                ])
        ),



      ),
    );
  }

  Widget StateContant(double parentHeight, double parentWidth) {
    return*/
  /* Padding(
      padding: EdgeInsets.only(
          left: parentWidth * 0.02,
          right: parentWidth * 0.02,
          top: parentHeight * 0.02),
      child: Container(
        height: parentHeight * 0.11,
        width: parentHeight * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.grey.shade50,
              offset: const Offset(-5, 0),
            ),
            BoxShadow(
              color: Colors.grey.shade50,
              offset: const Offset(5, 0),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.03, top: parentHeight * 0.009),
                  child: Text(
                    "State",
                    style: TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: parentHeight * 0.009,
                left: parentWidth * 0.00,
                right: parentWidth * 0.00,
              ),
              child: Container(
                //key:_formKey,
                height: parentHeight * .06,
                width: parentWidth * 0.96,
                */
  /*
      */
  /*    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(10)),*/
  /*
      */
  /*
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.04,
                      right: SizeConfig.screenWidth * .01),
                  child: TextFormField(
                    scrollPadding:
                    EdgeInsets.only(bottom: SizeConfig.screenHeight * .005),
                    controller: stateController,
                    focusNode: _stateFocus,
                    keyboardType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'State cannot be empty';
                      } else if (value.length < 3) {
                        return 'Username must be at least 3 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'State',


                      //borderRadius: BorderRadius.circular(10)
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      ),
                    ),
                  ),
                ),
                */
  /**/
  /*     decoration: InputDecoration(
                        isDense: true,
                        counterText: "",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Area",


                        hintStyle: TextStyle(
                          fontFamily: "Roboto_Regular",
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        ),

                      ),*/ /**/ /*
              ),
            ),
          ],
        ),
      ),
    );*/ /*
      Form(
        key: _formKeythree,
        child: Padding(
          padding:
          EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02),
          child: Container(
              height: parentHeight * 0.14,
              width: parentHeight * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade50,
                    offset: const Offset(-1, 0),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade50,
                    offset: const Offset(1, 0),
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: parentWidth * 0.03, top: parentHeight * 0.009),
                          child: Text(
                            "State",
                            style: TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                          ),
                        ),
                      ],
                    ),
                    Padding(

                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                            obscureText: true,
                            controller: stateController,
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
                                contentPadding: const EdgeInsets.all(12), isDense: true,

                                //borderRadius: BorderRadius.circular(10)
                                border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10.0)),
                                hintStyle: TextStyle(
                                  fontFamily: "Roboto_Regular",
                                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                ))))


                  ])
          ),



        ),
      );
  }

  Widget CountryContant(double parentHeight, double parentWidth) {
    return Form(
      key: _formKeyfour,
      child: Padding(
        padding:
        EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02),
        child: Container(
            height: parentHeight * 0.14,
            width: parentHeight * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
                BoxShadow(
                  color: Colors.grey.shade50,
                  offset: const Offset(-1, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade50,
                  offset: const Offset(1, 0),
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: parentWidth * 0.03, top: parentHeight * 0.009),
                        child: Text(
                          "Country",
                          style: TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                        ),
                      ),
                    ],
                  ),
                  Padding(

                      padding: const EdgeInsets.all(3.0),
                      child: TextFormField(
                          obscureText: true,
                          controller: countryController,
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
                              contentPadding: const EdgeInsets.all(12), isDense: true,

                              //borderRadius: BorderRadius.circular(10)
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10.0)),
                              hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              ))))


                ])
        ),



      ),
    );
  }*/

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        validate();

        setState(() {
          //cityController.text.isEmpty ? _validate = true : _validate = false;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.25,
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

  Future<UserUpdateRegistrationResponceModel> getRegisterVendors() async {
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
  }
}
