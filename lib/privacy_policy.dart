import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';


import 'common.color.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.12,
                decoration:  BoxDecoration(
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
                child: getAddMainHeadingLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),
              Container(
                height: SizeConfig.screenHeight * 0.88,
                child: ListView(
                  children: [
                    getAddTermsTextLayout(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                   /* RegistartionContant(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    PhoneNumberContant(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    Desgnation(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    SaveButton(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),*/
                  ],
                ),
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
                    color: CommonColor.WHITE_COLOR,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.07),
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                  fontFamily: 'Roboto_Medium',

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
  Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {
    return  Row(
      children: [
        Flexible(
          child: Padding(
            padding:
            EdgeInsets.only(left: parentWidth * .04, right: parentWidth * .04),

            child: Text(

             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              style:TextStyle(
                height: parentHeight*0.003,
              fontFamily: "Roboto_Regular",
             fontWeight: FontWeight.w400,

                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
              color: Colors.black,
                letterSpacing: SizeConfig.screenWidth * 0.001,
            ),textAlign: TextAlign.justify,),
          ),
        ),
      ],
    );
  }

}
