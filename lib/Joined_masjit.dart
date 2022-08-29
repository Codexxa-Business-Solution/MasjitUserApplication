import 'package:flutter/material.dart';
import 'package:masjiduserapp/size_config.dart';


import 'all_masjit_list.dart';
import 'common.color.dart';
class JoinedMasjit extends StatefulWidget {
  const JoinedMasjit({Key? key}) : super(key: key);

  @override
  State<JoinedMasjit> createState() => _JoinedMasjitState();
}

class _JoinedMasjitState extends State<JoinedMasjit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
             /* Container(
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
              ),*/
              Container(
                height: SizeConfig.screenHeight * 088,
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

  Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {
return Center(
  child:   GestureDetector(

          onTap: (){



         /* Navigator.push(context,

              MaterialPageRoute(builder: (context) => AllMasjitList()));*/

          },

          child: Center(

            child: Padding(

              padding:  EdgeInsets.only(top: parentHeight*0.3,left: parentWidth*0.25,right: parentWidth*0.25),

              child: Container(

                  height: parentHeight*0.07,





                  decoration:  BoxDecoration(

                    gradient: LinearGradient(

                        begin: Alignment.centerLeft,

                        end: Alignment.centerRight,

                        colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),

                    borderRadius: BorderRadius.circular(10),





                  ),

                  child:Center(

                    child: Text(" Join Masjid",style: TextStyle(

                        fontFamily: "Roboto_Regular",

                        fontWeight: FontWeight.w700,

                        fontSize: SizeConfig.blockSizeHorizontal * 4.5,

                        color: CommonColor.WHITE_COLOR

                    ),),

                  )

              ),

            ),

          )

      ),
);
  }
}
