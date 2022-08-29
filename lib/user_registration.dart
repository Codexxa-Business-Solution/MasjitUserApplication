import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';



import 'common.color.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

String dropdownvalue = 'Area';
var items = ['Apple', 'Banana', 'Grapes', 'Orange', 'watermelon', 'Pineapple'];
String dropdownvalueCity = 'City';
var itemsCity = [
  'Apple',
  'Banana',
  'Grapes',
  'Orange',
  'watermelon',
  'Pineapple'
];
String? theArea = null;
String? theCity = null;

class _UserRegistrationState extends State<UserRegistration> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
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
                child: MainHeading(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),
              Container(
                height: SizeConfig.screenHeight * 0.9,
                child: ListView(
                  children: [
                    AreaContant(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    StateContant(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    CityContant(SizeConfig.screenHeight, SizeConfig.screenWidth),
                    CountryContant(SizeConfig.screenHeight, SizeConfig.screenWidth),
                    ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth),

                  ],////////////////////////////////////////////////////////////////////////////
                ),////////////////////////////////
              )
            ],
          ),
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
                  padding: EdgeInsets.only(top: parentHeight * 0.04),
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
            padding: EdgeInsets.only(top: parentHeight * 0.04),
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
    return Padding(
      padding:
          EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02),
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
                  child: Text("Area",style: TextStyle(
                    color: CommonColor.REGISTRARTION_TRUSTEE
                  ),),
                ),
              ],
            ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.009,  left: parentWidth * 0.00,
              right: parentWidth * 0.00,),
          child: Container(
            height: parentHeight * .06,
            width: parentWidth*0.90,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: theArea,
                icon: Icon(Icons.keyboard_arrow_down),
                items: <String>[
                  'pune',
                  'mumbai',
                  'Aurangabad',
                  'Solapur',
                  'Nashik'
                ]
                    .map((String val) => DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                ))
                    .toList(),
                hint: Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.03),
                  child: Text(
                    'Area',
                    style: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    theArea = value!;
                  });
                },
              ),
            ),
          ),),
          ],
        ),
      ),
    );
  }
  Widget StateContant(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02,top: parentHeight*0.02),
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
                  child: Text("State",style: TextStyle(
                    color: CommonColor.REGISTRARTION_TRUSTEE
                  ),),
                ),
              ],
            ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.009,  left: parentWidth * 0.00,
              right: parentWidth * 0.00,),
          child: Container(
            height: parentHeight * .06,
            width: parentWidth*0.90,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: theArea,
                icon: Icon(Icons.keyboard_arrow_down),
                items: <String>[
                  'pune',
                  'mumbai',
                  'Aurangabad',
                  'Solapur',
                  'Nashik'
                ]
                    .map((String val) => DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                ))
                    .toList(),
                hint: Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.03),
                  child: Text(
                    'State',
                    style: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    theArea = value!;
                  });
                },
              ),
            ),
          ),),
          ],
        ),
      ),
    );
  }
  Widget CityContant(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02,top: parentHeight*0.02),
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
                  child: Text("City",style: TextStyle(
                    color: CommonColor.REGISTRARTION_TRUSTEE
                  ),),
                ),
              ],
            ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.009,  left: parentWidth * 0.00,
              right: parentWidth * 0.00,),
          child: Container(
            height: parentHeight * .06,
            width: parentWidth*0.90,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: theArea,
                icon: Icon(Icons.keyboard_arrow_down),
                items: <String>[
                  'pune',
                  'mumbai',
                  'Aurangabad',
                  'Solapur',
                  'Nashik'
                ]
                    .map((String val) => DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                ))
                    .toList(),
                hint: Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.03),
                  child: Text(
                    'City',
                    style: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    theArea = value!;
                  });
                },
              ),
            ),
          ),),
          ],
        ),
      ),
    );
  }
  Widget CountryContant(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(left: parentWidth * 0.02, right: parentWidth * 0.02,top: parentHeight*0.02),
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
                  child: Text("Country",style: TextStyle(
                    color: CommonColor.REGISTRARTION_TRUSTEE
                  ),),
                ),
              ],
            ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.009,  left: parentWidth * 0.00,
              right: parentWidth * 0.00,),
          child: Container(
            height: parentHeight * .06,
            width: parentWidth*0.90,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: theArea,
                icon: Icon(Icons.keyboard_arrow_down),
                items: <String>[
                  'pune',
                  'mumbai',
                  'Aurangabad',
                  'Solapur',
                  'Nashik'
                ]
                    .map((String val) => DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                ))
                    .toList(),
                hint: Padding(
                  padding: EdgeInsets.only(left: parentWidth * 0.03),
                  child: Text(
                    'Country',
                    style: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    theArea = value!;
                  });
                },
              ),
            ),
          ),),
          ],
        ),
      ),
    );
  }

  Widget ContinueButton(double parentHeight,double parentWidth){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParentTabBarScreen()));
      },
      child: Padding(
        padding:  EdgeInsets.only(top: parentHeight*0.25,left: parentWidth*0.1,right: parentWidth*0.1),
        child: Container(
            height: parentHeight*0.06,


            decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
              borderRadius: BorderRadius.circular(30),


            ),
            child:Center(
              child: Text("Continue",style: TextStyle(
                  fontFamily: "Roboto_Regular",
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                  color: CommonColor.WHITE_COLOR
              ),),
            )
        ),
      ),
    );
  }
  }




