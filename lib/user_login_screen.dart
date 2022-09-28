import 'package:flutter/material.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/enter_mobile_number.dart';
import 'package:masjiduserapp/user_registration.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          getTitleLayout(),
          getEmailField(),
          getPasswordField(),
          getLoginButton(),
          getBottomText()
        ],
      ),
    );
  }

  Widget getTitleLayout(){
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
            padding:  EdgeInsets.only(top: 18),
            child: Text("LOGIN",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 3
            ),),
          ),
        ],
      ),
    );
  }

  Widget getEmailField() {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          label: Text('Email Id'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget getPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          label: Text('Password'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget getLoginButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 35),
      child: Container(
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
      ),
    )/*Padding(
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
                  color: Colors.green
              ),),
            ),
          ),
        ],
      ),
    );
  }
}