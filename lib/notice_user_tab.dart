import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';

class NoticeUserTab extends StatefulWidget {
  const NoticeUserTab({Key? key}) : super(key: key);

  @override
  State<NoticeUserTab> createState() => _NoticeUserTabState();
}

class _NoticeUserTabState extends State<NoticeUserTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       backgroundColor: Colors.white,
      body: Container(
        height: SizeConfig.screenHeight * 0.9,
        child: getAddTermsTextLayout(
            SizeConfig.screenHeight, SizeConfig.screenWidth),
      ),
    );
  }
  Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {
    return Container(



          child: Padding(

            padding:  EdgeInsets.only(top: parentHeight*0.01,left: parentWidth*0.02),

            child: Text(



              "Lorem Ipsum is simply dummy text of printing and typesetting. Lorem Ipsum is simply dummy text  of printing and typesetting.Lorem Ipsum is simply dummy text of printing and typesetting. Lorem Ipsum is simply dummy text of printing and typesetting. Lorem Ipsum is simply dummy text  of printing and typesetting.Lorem Ipsum is simply dummy text of printing and typesetting. " ,

              style:TextStyle(

               // height: parentHeight*0.002,

                fontFamily: "Roboto_Regular",

                fontWeight: FontWeight.w400,



                fontSize: SizeConfig.blockSizeHorizontal * 4.5,

                color: Colors.black,

                // letterSpacing: SizeConfig.screenWidth * 0.001,

              ),

              // textAlign: TextAlign.justify,

            ),

          )

        );


  }

  }

