import 'package:flutter/material.dart';
import 'package:masjiduserapp/parent_masjit_location_name.dart';
import 'package:masjiduserapp/size_config.dart';


import 'common.color.dart';
class AllMasjitList extends StatefulWidget {
  const AllMasjitList({Key? key}) : super(key: key);

  @override
  State<AllMasjitList> createState() => _AllMasjitListState();
}

class _AllMasjitListState extends State<AllMasjitList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: SizeConfig.screenHeight,
          child: getAddTermsTextLayout(
              SizeConfig.screenHeight, SizeConfig.screenWidth),
        ),
        );
  }

  Widget getAddTermsTextLayout(double parentHeight, double parentWidth) {
    return
      Stack(
        children: [
          Container(
            height: parentHeight,
            child: ListView.builder(
                itemCount: 7,
                padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 5
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: parentHeight*0.03),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
          MaterialPageRoute(builder: (context) => MasjitNameLocation()));
                      },

                      child: Container(
                        height: parentHeight * 0.23,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
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
                        ),
                        child: Column(
                          children: [
                            Row(

                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.02,left: parentHeight*0.004),
                                  child: Row(

                                    children: [
                                      Padding(
                                        padding:EdgeInsets.only(left: parentWidth*0.01),
                                        child: Container(
                                            height: parentHeight*0.08,
                                            width: parentWidth*0.17,

                                            decoration: BoxDecoration(

                                                image: DecorationImage(
                                                  image:  AssetImage("assets/images/logo.png"),
                                                  fit: BoxFit.cover,

                                                ),
                                                borderRadius: BorderRadius.circular(10)
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: parentHeight*0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(right: parentWidth*0.05,top: parentHeight*0.01),
                                            child: Text("Masjit Name",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.MASJIT_NAME,)),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(top: parentHeight*0.01,left: parentWidth*0.13,),
                                            child: Container(
                                                height: parentHeight*0.04,
                                                width: parentHeight*0.12,


                                                decoration:  BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.centerLeft,
                                                      end: Alignment.centerRight,
                                                      colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
                                                  borderRadius: BorderRadius.circular(10),


                                                ),
                                                child:Center(
                                                  child: Text("JOIN",style: TextStyle(
                                                      fontFamily: "Roboto_Regular",
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                      color: CommonColor.WHITE_COLOR
                                                  ),),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(right: parentHeight*0.02,top: parentHeight*0.0),
                                            child: Text("Location :",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w400,
                                              color: CommonColor.BLACK_COLOR,)),

                                          ),

                                        ],
                                      ),
                          // Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                        //     Padding(
                        //         padding:  EdgeInsets.only(right: parentHeight*0.02,top: parentHeight*0.01),
                        //       child: Text("FAZAR",style: TextStyle(
                        //         fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        //         fontFamily: 'Roboto_Bold',
                        //        fontWeight: FontWeight.w500,
                        //         color: CommonColor.BLACK_COLOR,)),

                                      //         ),

                        //           ],
                                      //        ),


                                      /*             Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(right: parentHeight*0.0,top: parentHeight*0.01),
                                            child: Text("AZAN :",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal *4.0,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,)),

                                          ),
                                          Padding(
                                            padding:EdgeInsets.only(right: parentWidth*0.02,top: parentHeight*0.01),
                                            child: Text("05:30",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,)),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(right: parentHeight*0.01,top: parentHeight*0.01),
                                            child: Text("JAMA’AT :",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,)),

                                          ),
                                          Padding(
                                            padding:EdgeInsets.only(right: parentWidth*0.0,top: parentHeight*0.01),
                                            child: Text("05:30",style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,)),
                                          )
                                        ],
                                      )*/
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: parentHeight * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: parentWidth * 0.22),
                                        child: Text("FAJR",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: parentWidth * 0.01),
                                        child: Text("ZUHAR",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: parentWidth * 0.01),
                                        child: Text("ASR",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: parentWidth * 0.01),
                                        child: Text("MAGHRIB",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: parentWidth * 0.01),
                                        child: Text("ISHA",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal *2.8,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: parentWidth * 0.02,),
                                        child: Text("JUMA",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 2.8,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.04, top: parentHeight * 0.02),
                                      child: Text("AZAN",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w500,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.05, top: parentHeight * 0.02),
                                      child: Text("05:00",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.02),
                                      child: Text("01:00",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.02),
                                      child: Text("05:00",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.02),
                                      child: Text("06:30",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.02),
                                      child: Text("08:30",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentWidth * 0.02, top: parentHeight * 0.02),
                                      child: Text("01:30",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: parentHeight*0.01,left: parentWidth*.02,right: parentWidth*0.02),
                                  child: Container(
                                    color:CommonColor.SEARCH_COLOR,
                                    height: parentHeight*0.001,
                                    width: parentWidth,
                                    child:Text("hi",
                                      style: TextStyle(
                                          color: Colors.transparent
                                      ),),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.05, top: parentHeight * 0.01),
                                      child: Text("JAMAA’T",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.01),
                                      child: Text("05:30",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.01),
                                      child: Text("01:30",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.01),
                                      child: Text("05:30",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.01),
                                      child: Text("06:35",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.0, top: parentHeight * 0.01),
                                      child: Text("08:85",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentWidth * 0.02, top: parentHeight * 0.01),
                                      child: Text("01:45",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],

                        ),

                      ),
                    ),
                  );
                }),
          )
        ],

      );
  }
}
