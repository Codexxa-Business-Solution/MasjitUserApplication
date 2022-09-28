import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/enter_mobile_number.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/userLoginResponseModel.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:masjiduserapp/user_registration.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/constant.dart';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParentTabBarScreen()));
        });

    } else {
      print("not validated");
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          getTitleLayout(),
          getEmailField(),
          //getPasswordField(),
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
            colors: [
              CommonColor.LEFT_COLOR,
              CommonColor.RIGHT_COLOR
            ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 18),
            child: Text("LOGIN",
              style: TextStyle(

                    fontSize: 18,
                    fontFamily: 'Roboto_Medium',
                    //letterSpacing: parentWidth * 0.003,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                  /*letterSpacing: 3*/
              ),),

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
                } /*else if (emailController.text.length < 6) {
                  return 'Password Must Be 6 Character';*/

                return null;
              },
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: CommonColor.REGISTRARTION_COLOR
                    ),
                    contentPadding: const EdgeInsets.all(14),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    hintStyle: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        color: CommonColor.REGISTRARTION_TRUSTEE
                    ))
            ),
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
                    labelStyle: TextStyle(
                        color: CommonColor.REGISTRARTION_COLOR
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10.0)),
                    hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        color: CommonColor.REGISTRARTION_TRUSTEE
                    ))
            ),
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
                    borderSide: BorderSide(
                        width: 1,
                        color: CommonColor.REGISTRARTION_COLOR),
                    borderRadius: BorderRadius.circular(10.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: CommonColor.REGISTRARTION_COLOR),
                    borderRadius: BorderRadius.circular(10.0)),
                hintStyle: TextStyle(
                  fontFamily: "Roboto_Regular",
                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  color: CommonColor.REGISTRARTION_TRUSTEE
                ))
        ),
      ),
    );
  }

  Widget getLoginButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 35),
      child: GestureDetector(
        onTap: () {
          validate();
          },
        onDoubleTap: () {},
        child: /*Container(
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    CommonColor.LEFT_COLOR,
                    CommonColor.RIGHT_COLOR
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),),
            ],
          ),
        ),*/
        Container(
            height: 43,

            decoration: BoxDecoration(
              gradient: LinearGradient(
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
    )
    /*Padding(
      padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom({
          Color primary
        }),
        onPressed: () async {
          // var result = loginMasjid();

        },
        child: const Text(
          'Login',
        ),
      ),
    )*/;
  }

  Widget getBottomText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("New User Register?", style: TextStyle(
            fontSize: 15,
              fontFamily: "Roboto_Regular",
              fontWeight: FontWeight.w400,
             // fontSize: SizeConfig.blockSizeHorizontal * 4.5,
              color: CommonColor.BLACK_COLOR

          ),),

          GestureDetector(
            onDoubleTap: () {},
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const EnterMobileNumber()));
            },
            child: Container(
              color: Colors.transparent,
              child: const Text(" Register", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: CommonColor.RIGHT_COLOR
              ),),
            ),
          ),
        ],
      ),
    );
  }

  Future<UserLoginResponseModel> getLoginUsers() async {
    try {
      final result = await http.post(
          Uri.parse("http://masjid.exportica.in/api/user/verify"),
          body: {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
          });
      print("new user:" + result.body);
      if (result.statusCode == 200) {
       /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParentTabBarScreen()));*/
      }

      return userLoginResponseModelFromJson(result.body);
    } catch (e) {
      throw e;
    }
  }
}