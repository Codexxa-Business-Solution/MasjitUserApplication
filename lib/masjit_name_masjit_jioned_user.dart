/*
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masjiduserapp/all_masjit_list.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_list_responce_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/trustee_user_tab.dart';
import 'package:masjiduserapp/user_map_tab.dart';

import 'common.color.dart';

import 'package:http/http.dart' as http;
import 'masjit_user_app_api/JoinedMsjitAllApi.dart';
import 'masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
import 'notice_user_tab.dart';

class MasjitNameLocationJoined extends StatefulWidget {
  const MasjitNameLocationJoined({Key? key}) : super(key: key);

  @override
  _MasjitNameLocationJoinedState createState() =>
      _MasjitNameLocationJoinedState();
}

class _MasjitNameLocationJoinedState extends State<MasjitNameLocationJoined>
    with SingleTickerProviderStateMixin {
  bool showDetails = true;
  bool ViewImage = false;
  bool JammatTime = false;
  bool FridayTime = false;
  bool shariIftar = false;
  bool eid = false;

  bool mapScreen = false;
  bool trusteeScreen = false;
  bool noticeScreen = false;
  int currentIndex = 0;
  int currentPos = 0;
  List<String> listPaths = [
    "images/nature1.jpg",
    "images/nature2.jpg",
    "images/nature3.jpg",
    "images/nature4.jpg",
    "images/nature5.jpg",
    "images/nature6.jpg",
  ];
  var getNotice;



  @override
  void initState() {
    super.initState();
    getNotice = getNoticeSection();
    print(getNotice);
    if (mounted)
      setState(() {
        showDetails = true;
        //   ViewImage = false;
      });
    //  _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    //  _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.white,
        body:
        Container(

          //color: Colors.red,
          child: FutureBuilder<NoticeResponceModel>(
              future:getNotice ,
              builder: (context, snapshot){
                return
                  // snapshot.data?.length != null?
                  ListView.builder(

                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: SizeConfig.screenHeight*0.015),
                          child: Container(
                            // color: Colors.blue,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade50,
                                  offset: Offset(-5, 0),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade50,
                                  offset: Offset(5, 0),
                                )
                              ],
                            ),
                            child: Column(

                              //shrinkWrap: true,
                              children: [

                                Container(
                                  height: SizeConfig.screenHeight * 0.09,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.only( topRight: Radius.circular(30),topLeft: Radius.circular(30),),

                                    // color: Colors.red,
                                  ),
                                  child: CityContant(SizeConfig.screenHeight, SizeConfig.screenWidth),
                                ),
                                Container(
                                  height: SizeConfig.screenHeight*0.99,

                                  child: Container(
                                    padding: EdgeInsets.only(top: SizeConfig.screenHeight * .02),
                                    height: SizeConfig.screenHeight,
                                    child: showScreenLayout(
                                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });


              }),
        )
    );
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
                  color: Colors.transparent),
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

  Widget CityContant(double parentHeight, double parentWidth) {
    return Container(

      child: FutureBuilder<NoticeResponceModel>(
          future:getNotice ,
          builder: (context, snapshot){
            return

              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: parentHeight * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onDoubleTap: () {},
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  mapScreen = true;
                                  trusteeScreen = false;
                                  showDetails = false;
                                  noticeScreen = false;
                                });
                              }
                            },
                            child: Container(
                              width: parentWidth * 0.28,
                              height: parentHeight * 0.05,
                              decoration: BoxDecoration(
                                  color: mapScreen == true
                                      ? CommonColor.REGISTRARTION_TRUSTEE.withOpacity(0.9)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: CommonColor.RIGHT_COLOR, width: 1)),
                              child: Center(
                                child: Text(
                                  "Map",
                                  style: TextStyle(
                                    color: mapScreen == true ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                    fontFamily: 'Roboto_Medium',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onDoubleTap: () {},
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  mapScreen = false;
                                  trusteeScreen = true;
                                  showDetails = false;
                                  noticeScreen = false;
                                });
                            },
                            child: Container(
                              width: parentWidth * 0.28,
                              height: parentHeight * 0.05,
                              decoration: BoxDecoration(
                                  color: trusteeScreen
                                      ? CommonColor.REGISTRARTION_TRUSTEE.withOpacity(0.9)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: CommonColor.RIGHT_COLOR, width: 1)),
                              child: Center(
                                child: Text(
                                  "Trustee",
                                  style: TextStyle(
                                    color: trusteeScreen ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                    fontFamily: 'Roboto_Medium',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onDoubleTap: () {},
                            onTap: () {
                              if (mounted)
                                setState(() {
                                  mapScreen = false;
                                  showDetails = false;
                                  trusteeScreen = false;
                                  noticeScreen = true;
                                });
                            },
                            child: Container(
                              width: parentWidth * 0.28,
                              height: parentHeight * 0.05,
                              decoration: BoxDecoration(
                                  color: noticeScreen
                                      ? CommonColor.REGISTRARTION_TRUSTEE.withOpacity(0.9)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: CommonColor.RIGHT_COLOR, width: 1)),
                              child: Center(
                                child: Text(
                                  "Notice",
                                  style: TextStyle(
                                    color: noticeScreen == true ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                    fontFamily: 'Roboto_Medium',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });

          }),
    );

  }

  Widget showScreenLayout(double parentHeight, double parentWidth) {
    return Stack(
      children: [
        Visibility(
            visible: mapScreen,
            child: UserMapLocation(
              latitude: '20.42796133580664',
              longitude: '75.885749655962',
            )),
        Visibility(visible: trusteeScreen, child: TrusteeUserTab()),
        Visibility(visible: noticeScreen, child: NoticeUserTab()),
        Visibility(
            visible: showDetails,
            child:
            FutureBuilder<NoticeResponceModel>(
                future:getNotice ,
                builder: (context, snapshot) {
                  return
                    //snapshot.data?.trustee?.length != null ?
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // final data = snapshot.data!.notices?[index];


                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: parentHeight * 0.02),
                                child: Text(
                                  "${snapshot.data?.location!.place}",
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                      color: CommonColor.BLACK_COLOR,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto_Bold'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: parentHeight * 0.003, left: parentHeight * 0.02),
                                child: Text(
                                  "Location :",
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                      color: CommonColor.BLACK_COLOR,
                                      fontWeight: FontWeight.w400,
                                      height: 1.6,
                                      fontFamily: 'Roboto_Bold'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: parentHeight * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Masjid Image",
                                      style: TextStyle(
                                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                          color: CommonColor.BLACK_COLOR,
                                          fontWeight: FontWeight.w400,
                                          height: 1.6,
                                          fontFamily: 'Roboto_Bold'),
                                    ),
                                    GestureDetector(
                                      onTapDown: (tab) {
                                        setState(() {
                                          ViewImage = !ViewImage;
                                        });
                                      },
                                      child: Container(
                                        height: parentHeight * 0.02,
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: parentWidth * 0.05),
                                          child: Text(
                                            "View",
                                            style: TextStyle(
                                                fontSize:
                                                SizeConfig.blockSizeHorizontal * 4.0,
                                                color: CommonColor.BLACK_COLOR,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Roboto_Regular'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: ViewImage,
                                child: Container(
                                  //height: SizeConfig.screenHeight*.74,
                                    width: SizeConfig.screenWidth,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: SizeConfig.screenHeight * .0,
                                          top: SizeConfig.screenHeight * .0),
                                      child: CarouselSlider.builder(
                                        // carouselController: _controller,
                                          itemCount: snapshot.data?.images?.length,
                                          //widget.getChatGroupInfoData.length,
                                          options: CarouselOptions(
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            initialPage: 1,
                                            height: SizeConfig.screenHeight * .27,
                                            // aspectRatio: 1.1,
                                            viewportFraction: 1.0,
                                            enableInfiniteScroll: false,
                                            autoPlay: false,
                                            enlargeStrategy: CenterPageEnlargeStrategy
                                                .height,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int index) {
                                            return getFirstImageFrame(
                                                SizeConfig.screenHeight,
                                                SizeConfig.screenWidth,
                                                snapshot.data?.images?[index],
                                                snapshot.data?.images?.length);
                                          }),
                                    )),
                              ),
                              Visibility(
                                visible: ViewImage,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 2; i++)
                                      Container(
                                        width: 7,
                                        height: 7,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: currentIndex == i
                                              ? Colors.green
                                              : Colors.grey.shade400,
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  getAddJammatTimeLayout(
                                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                                  getAddFridayTimeLayout(
                                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                                  getAddshariIftarLayout(
                                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                                  getAddEidLayout(
                                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                                  SlideBanner(
                                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                                  */
/* MasjitNameLocation(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),*//*

                                ],
                              )

                              */
/* Text("Masjid Name"),
                Text ("Location :")*//*

                            ],
                          );
                        });
                  // : Center(child: CircularProgressIndicator());
                })
        ),
      ],
    );
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth,images, imageLen) {
    return Padding(
      padding:
      EdgeInsets.only(left: parentWidth * 0.03, right: parentWidth * 0.03),
      child: Container(
        width: parentWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.02),
              child: Container(
                height: parentHeight * .23,
                width: parentWidth * .94,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:images != null ?
                        NetworkImage(
                          images.toString(),
                        ) : NetworkImage(""),
                        fit: BoxFit.cover
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddJammatTimeLayout(double parentHeight, double parentWidth) {
    // print("data null  ${}")
    return

      Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.03),
        child: Container(
          height: parentHeight * 0.18,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(-5, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(5, 0),
              )
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                child: Container(
                  height: parentHeight * 0.04,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            CommonColor.LEFT_COLOR,
                            CommonColor.RIGHT_COLOR
                          ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "JAMMAT TIME",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                          fontFamily: 'Roboto_Bold',
                          fontWeight: FontWeight.w600,
                          color: CommonColor.WHITE_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              */
/*FutureBuilder<NoticeResponceModel>(

                future: getNotice,

                builder: (context, snapshot) {

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      padding: const EdgeInsets.only(bottom: 0, top: 5),
                      itemBuilder: (context, int index) {
                        return Container(
                          height: parentHeight * 0.12,

                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentWidth * 0.04,
                                        top: parentHeight * 0.025),
                                    child: Text(
                                        "Hi",
                                        style: TextStyle(
                                          fontSize:
                                          SizeConfig.blockSizeHorizontal *
                                              3.5,
                                          fontFamily: 'Roboto_Bold',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.transparent,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentWidth * 0.0,
                                        top: parentHeight * 0.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: parentHeight * 0.028,
                                          decoration: BoxDecoration(
                                            // color: Colors.red,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey,
                                                      width: parentHeight *
                                                          0.001))),
                                          width: parentWidth * 0.185,
                                          child: Text("Azan",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                    .blockSizeHorizontal *
                                                    3.5,
                                                fontFamily: 'Roboto_Bold',
                                                fontWeight: FontWeight.w500,
                                                color:
                                                CommonColor.BLACK_COLOR,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentWidth * 0.0,
                                        top: parentHeight * 0.0),
                                    child: Text("JAMMA'T",
                                        style: TextStyle(
                                          fontSize:
                                          SizeConfig.blockSizeHorizontal *
                                              3.5,
                                          fontFamily: 'Roboto_Bold',
                                          fontWeight: FontWeight.w500,
                                          color: CommonColor.BLACK_COLOR,
                                        )),
                                  ),
                                ],
                              ),
                              Container(

                                height: parentHeight * 0.5,
                                width: parentWidth * 0.73,
                                child: ListView.builder(
                                  itemCount: 6,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.019),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: parentWidth * 0.0,
                                                top: parentHeight * 0.02),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    right: parentWidth * 0.02,
                                                  ),
                                                  child: Text(

                                                     " ",
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            2.8,
                                                        fontFamily:
                                                        'Roboto_Bold',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: CommonColor
                                                            .BLACK_COLOR,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: parentHeight * 0.01),
                                            child: Container(
                                              child: Text(
                                                  "5.00",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.3,
                                                    fontFamily:
                                                    'Roboto_Regular',
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    color: CommonColor
                                                        .BLACK_COLOR,
                                                  )),
                                            ),
                                          ),
                                          Divider(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: parentWidth * 0.0,
                                                top: parentHeight * 0.0),
                                            child: Text(
                                                "5.30",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3.3,
                                                  fontFamily:
                                                  'Roboto_Regular',
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                  CommonColor.BLACK_COLOR,
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),*//*

              Container(
                height: parentHeight*0.13,

                //  color: Colors.red,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Column(

                      children: [


                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.027,right: parentHeight*0.0),
                          child: const Text("AZAN",
                            style: TextStyle(
                                color: Colors.transparent, fontFamily:
                            'Roboto_Bold',
                                fontWeight:
                                FontWeight.w500,
                                fontSize: 10
                            ),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.0),
                          child: Container(
                              width: parentWidth*0.14,
                              height: parentHeight*0.024,
                              decoration: const BoxDecoration(
                                // color: Colors.blue,
                                  border: Border(bottom: BorderSide(width: 1, color: CommonColor.SEARCH_COLOR))
                              ),
                              child: Padding(
                                padding:  EdgeInsets.only(left: parentWidth*0.02),
                                child: const Text("AZAN",style: TextStyle(
                                    fontFamily:
                                    'Roboto_Bold',
                                    fontWeight:
                                    FontWeight.w500,
                                    color: CommonColor
                                        .BLACK_COLOR,
                                    fontSize: 10
                                ),),
                              )
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.only(top: parentHeight*0.01, left: parentWidth*0.0),
                          child: Row(
                            children: const [
                              Text("JAMAA'T",style: TextStyle(
                                  fontFamily:
                                  'Roboto_Bold',
                                  fontWeight:
                                  FontWeight.w500,
                                  color: CommonColor
                                      .BLACK_COLOR,
                                  fontSize: 10
                              ),),
                            ],
                          ),
                        ),

                      ],
                    ),

                    FutureBuilder<NoticeResponceModel>(
                        future: getNotice,
                        builder: (context, snapshot) {
                          return
                            snapshot.data?.weeklyNamaz?.length != null ?
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.weeklyNamaz?.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (context, index) {
                                    return  Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [


                                        Padding(
                                          padding: EdgeInsets.only(top: parentHeight*0.01,right: parentHeight*0.006),
                                          child: Text("${snapshot.data?.weeklyNamaz?[index].day}",
                                            style: TextStyle(
                                                fontSize: SizeConfig.blockSizeHorizontal*2.8
                                            ),),
                                        ),


                                        Padding(
                                          padding: EdgeInsets.only(top: parentHeight*0.01),
                                          child: Container(
                                              width: parentWidth*0.135,
                                              height: parentHeight*0.031,
                                              decoration: const BoxDecoration(
                                                // color: Colors.blue,
                                                  border: Border(bottom: BorderSide(width: 1,  color: CommonColor.SEARCH_COLOR))
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: parentWidth*0.025),
                                                child: Text("${snapshot.data?.weeklyNamaz?[index].azan}",
                                                  style: TextStyle(
                                                      fontSize: SizeConfig.blockSizeHorizontal*3.0
                                                  ),),
                                              )
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: parentHeight*0.01,right: parentHeight*0.005),
                                          child: Row(
                                            children: [
                                              Text("${snapshot.data?.weeklyNamaz?[index].jammat}",
                                                style: TextStyle(
                                                    fontSize: SizeConfig.blockSizeHorizontal*3.0
                                                ),),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ) ;
                                  }),
                            )
                                : Container();
                        })




                  ],
                ),
              )
            ],
          ),
        ),
      );


  }

  Widget getAddFridayTimeLayout(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTapDown: (tab) {
        setState(() {
          FridayTime = !FridayTime;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.01,
            left: parentWidth * 0.0,
            right: parentWidth * 0.0),
        child: Column(
          children: [
            Container(
                height: parentHeight * 0.05,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        CommonColor.LEFT_COLOR,
                        CommonColor.RIGHT_COLOR
                      ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.33),
                      child: Text(
                        "JUMMA TIME",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            color: CommonColor.WHITE_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Container(
                        // width: SizeConfig.screenWidth * .09,
                        child: Image.asset(
                          'assets/images/up_arrow.png',
                        ),
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: FridayTime,
                child: Container(
                    height: parentHeight * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade50,
                          offset: Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade50,
                          offset: Offset(5, 0),
                        )
                      ],
                    ),
                    child: FutureBuilder<NoticeResponceModel>(
                        future: getNotice,
                        builder: (context, snapshot) {
                          return
                            Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: parentWidth * 0.1, top: parentHeight * 0.0),
                                        child: Text("SAHR",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: parentWidth * 0.1, top: parentHeight * 0.0),
                                        child: snapshot.data?.sahr != null ?
                                        Text("${snapshot.data?.sahr}",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )) : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentHeight * 0.05, top: parentHeight * 0.03),
                                      child: Text("IFTAR",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentWidth * 0.1, top: parentHeight * 0.03),
                                      child:snapshot.data?.iftar != null ?
                                      Text("${snapshot.data?.iftar}",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          ))
                                          : Text(""),
                                    )
                                  ],
                                )
                              ],
                            );
                        })


                ))

          ],
        ),
      ),
    );

  }

  Widget getAddshariIftarLayout(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTapDown: (tab) {
        setState(() {
          shariIftar = !shariIftar;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.01,
            left: parentWidth * 0.0,
            right: parentWidth * 0.0),
        child: Column(
          children: [
            Container(
                height: parentHeight * 0.05,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        CommonColor.LEFT_COLOR,
                        CommonColor.RIGHT_COLOR
                      ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.33),
                      child: Text(
                        "SAHR / IFTAR",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            color: CommonColor.WHITE_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Container(
                        // width: SizeConfig.screenWidth * .09,
                        child: Image.asset(
                          'assets/images/up_arrow.png',
                        ),
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: shariIftar,
                child: Container(
                    height: parentHeight * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade50,
                          offset: Offset(-5, 0),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade50,
                          offset: Offset(5, 0),
                        )
                      ],
                    ),
                    child: FutureBuilder<NoticeResponceModel>(
                        future: getNotice,
                        builder: (context, snapshot) {
                          return
                            Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: parentWidth * 0.1, top: parentHeight * 0.0),
                                        child: Text("SAHR",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: parentWidth * 0.1, top: parentHeight * 0.0),
                                        child: snapshot.data?.sahr != null ?
                                        Text("${snapshot.data?.sahr}",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )) : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentHeight * 0.05, top: parentHeight * 0.03),
                                      child: Text("IFTAR",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentWidth * 0.1, top: parentHeight * 0.03),
                                      child:snapshot.data?.iftar != null ?
                                      Text("${snapshot.data?.iftar}",
                                          style: TextStyle(
                                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          ))
                                          : Text(""),
                                    )
                                  ],
                                )
                              ],
                            );
                        })


                ))

          ],
        ),
      ),
    );

  }

  Widget getAddEidLayout(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTapDown: (tab) {
        setState(() {
          eid = !eid;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.01,
            left: parentWidth * 0.0,
            right: parentWidth * 0.0),
        child: Column(
          children: [
            Container(
                height: parentHeight * 0.05,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        CommonColor.LEFT_COLOR,
                        CommonColor.RIGHT_COLOR
                      ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.43),
                      child: Text(
                        "Eid",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            color: CommonColor.WHITE_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Container(
                        // width: SizeConfig.screenWidth * .09,
                        child: Image.asset(
                          'assets/images/up_arrow.png',
                        ),
                      ),
                    ),
                  ],
                )),
            Visibility(
              visible: eid,
              child: Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.0),
                child: Container(
                  height: parentHeight * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: Offset(5, 0),
                      )
                    ],
                  ),
                  child:   FutureBuilder<NoticeResponceModel>(
                      future: getNotice,
                      builder: (context, snapshot) {
                        return
                          snapshot.data?.weeklyNamaz?.length != null ?
                          Column(
                            children: [

                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.ed?.length,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (context, index) {
                                      return  Column(
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top: parentHeight*0.02),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: parentWidth * 0.1, top: parentHeight * 0.01),
                                                  child: Text("${snapshot.data?.ed?[index].name}",
                                                      style: TextStyle(
                                                        fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                        fontFamily: 'Roboto_Bold',
                                                        fontWeight: FontWeight.w600,
                                                        color: CommonColor.BLACK_COLOR,
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: parentWidth * 0.05, top: parentHeight * 0.01),
                                                  child: Text("Jammat  ${snapshot.data?.ed?[index].jammat?[index].time}",
                                                      style: TextStyle(
                                                        fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                        fontFamily: 'Roboto_Bold',
                                                        fontWeight: FontWeight.w600,
                                                        color: CommonColor.BLACK_COLOR,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          )
                              : Container();
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AllMasjitList()));
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.05,
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
                "JOIN",
                style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    color: CommonColor.RIGHT_COLOR),
              ),
            )),
      ),
    );
  }

  Widget SlideBanner(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.03),
      child: Container(
          height: parentHeight * 0.20,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(-5, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(3, 0),
              )
            ],
          ),
          child: Center(
            child: Text(
              "SLIDE BANNER",
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                fontFamily: 'Roboto_Bold',
                fontWeight: FontWeight.w600,
                color: CommonColor.BLACK_COLOR,
              ),
            ),
          )),
    );
  }

  Widget MasjitNameLocation(double parentHeight, double parentWidth) {
    return Column(children: [
      for (int i = 0; i < 7; i++)
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.03),
          child: GestureDetector(
              onTap: () {
                */
/*Navigator.push(context,/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              MaterialPageRoute(builder: (context) => MasjitNameLocation()));*//*

              },
              child: Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.03),
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
                            padding: EdgeInsets.only(
                                top: parentHeight * 0.02,
                                left: parentHeight * 0.004),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: parentWidth * 0.01),
                                  child: Container(
                                      height: parentHeight * 0.08,
                                      width: parentWidth * 0.17,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/logo.png"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(10))),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: parentHeight * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentWidth * 0.05,
                                          top: parentHeight * 0.01),
                                      child: Text("Masjit Name",
                                          style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w500,
                                            color: CommonColor.MASJIT_NAME,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: parentHeight * 0.01,
                                        left: parentWidth * 0.13,
                                      ),
                                      child: Container(
                                          height: parentHeight * 0.04,
                                          width: parentHeight * 0.12,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  CommonColor.LEFT_COLOR,
                                                  CommonColor.RIGHT_COLOR
                                                ]),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "JOIN",
                                              style: TextStyle(
                                                  fontFamily: "Roboto_Regular",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      4.3,
                                                  color:
                                                  CommonColor.WHITE_COLOR),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),

                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentHeight * 0.02,
                                          top: parentHeight * 0.0),
                                      child: Text("Location :",
                                          style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w400,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                  ],
                                ),

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
                                  padding:
                                  EdgeInsets.only(left: parentWidth * 0.22),
                                  child: Text("FAJR",
                                      style: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            2.8,
                                        fontFamily: 'Roboto_Bold',
                                        fontWeight: FontWeight.w500,
                                        color: CommonColor.BLACK_COLOR,
                                      )),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: parentWidth * 0.01),
                                  child: Text("ZUHAR",
                                      style: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            2.8,
                                        fontFamily: 'Roboto_Bold',
                                        fontWeight: FontWeight.w500,
                                        color: CommonColor.BLACK_COLOR,
                                      )),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: parentWidth * 0.01),
                                  child: Text("ASR",
                                      style: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            2.8,
                                        fontFamily: 'Roboto_Bold',
                                        fontWeight: FontWeight.w500,
                                        color: CommonColor.BLACK_COLOR,
                                      )),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: parentWidth * 0.01),
                                  child: Text("MAGHRIB",
                                      style: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            2.8,
                                        fontFamily: 'Roboto_Bold',
                                        fontWeight: FontWeight.w500,
                                        color: CommonColor.BLACK_COLOR,
                                      )),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: parentWidth * 0.01),
                                  child: Text("ISHA",
                                      style: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            2.8,
                                        fontFamily: 'Roboto_Bold',
                                        fontWeight: FontWeight.w500,
                                        color: CommonColor.BLACK_COLOR,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: parentWidth * 0.02,
                                  ),
                                  child: Text("JUMA",
                                      style: TextStyle(
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            2.8,
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
                                    left: parentWidth * 0.04,
                                    top: parentHeight * 0.02),
                                child: Text("AZAN",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.5,
                                      fontFamily: 'Roboto_Bold',
                                      fontWeight: FontWeight.w500,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.05,
                                    top: parentHeight * 0.02),
                                child: Text("05:00",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.02),
                                child: Text("01:00",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.02),
                                child: Text("05:00",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.02),
                                child: Text("06:30",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.02),
                                child: Text("08:30",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: parentWidth * 0.02,
                                    top: parentHeight * 0.02),
                                child: Text("01:30",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: parentHeight * 0.01,
                                left: parentWidth * .02,
                                right: parentWidth * 0.02),
                            child: Container(
                              color: CommonColor.SEARCH_COLOR,
                              height: parentHeight * 0.001,
                              width: parentWidth,
                              child: Text(
                                "hi",
                                style: TextStyle(color: Colors.transparent),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.05,
                                    top: parentHeight * 0.01),
                                child: Text("JAMAA???T",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.5,
                                      fontFamily: 'Roboto_Bold',
                                      fontWeight: FontWeight.w600,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.01),
                                child: Text("05:30",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.01),
                                child: Text("01:30",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.01),
                                child: Text("05:30",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.01),
                                child: Text("06:35",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: parentWidth * 0.0,
                                    top: parentHeight * 0.01),
                                child: Text("08:85",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: CommonColor.BLACK_COLOR,
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: parentWidth * 0.02,
                                    top: parentHeight * 0.01),
                                child: Text("01:45",
                                    style: TextStyle(
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
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
              )),
        ) //////
    ]);
  }
  Future<NoticeResponceModel> getNoticeSection() async {
    // print(" userId ${userId}");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };

    // final msg = jsonEncode({
    //   "user_id": userId.toString(),
    // });

    var response = await http.post(
      Uri.parse("http://sangh.bizz-manager.com/?id=1"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      // circularLoader = false;

      print("Yess.. ${response.body}");

      print("Hiii");

      return noticeResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}


*/
