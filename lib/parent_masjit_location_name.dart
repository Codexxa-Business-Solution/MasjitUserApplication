import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/map_screen.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_joined_tab_button_response_model.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/trustee_user_tab.dart';
import 'package:masjiduserapp/user_map_tab.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'common.color.dart';
import 'notice_user_tab.dart';
import 'package:http/http.dart' as http;


class MasjitNameLocation extends StatefulWidget {
  const MasjitNameLocation({required this.masjitId,required this.lat,required this.long});
final String masjitId;
  final String lat;
  final String long;

  @override
  _MasjitNameLocationState createState() => _MasjitNameLocationState();
}

class _MasjitNameLocationState extends State<MasjitNameLocation>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(text: "Featured"),
    const Tab(text: "Popular"),
    const Tab(text: "Latest")
  ];

  TabController? _tabController;
  bool showDetails = true;
  late Box box;

  bool mapScreen = false;
  bool trusteeScreen = false;
  bool noticeScreen = false;
  int currentIndex = 0;
  int currentPos = 0;


  var getMasjidInfo;
  var getMasjidJoinButton;
//  late final LocalNotificationService service;
  @override
  void initState() {
    box = Hive.box(kBoxName);

    super.initState();
    if (mounted) {
      setState(() {
        showDetails = true;
        getMasjidInfo = getNoticeSection(widget.masjitId);
      //  getMasjidJoinButton = getJoinButtonSection(widget.masjitId);
        print(getMasjidInfo);
        print("parentScreenId ${widget.masjitId}");
      });
    }
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
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
              height: SizeConfig.screenHeight * 0.1,
              child:
              ThreeTabs(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
            Container(
              height: SizeConfig.screenHeight * 0.8,
              child: showScreenLayout(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
          ],
        ));
  }

  Widget MainHeading(double parentHeight, double parentWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          onDoubleTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: parentWidth * .04),
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
          child: Icon(
            Icons.arrow_back_ios,
            size: parentHeight * .03,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget ThreeTabs(double parentHeight, double parentWidth) {
    return Container(
height: parentHeight*0.8,



      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onDoubleTap: () {},
            onTap: () {

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MasjitMappScreen(
                tabNum: "1", masjitTrusteeId: widget.masjitId,
                 lat: widget.lat, long: widget.long,
              )));
              if (mounted) {
                setState(() {
                 /* mapScreen = true;
                  trusteeScreen = false;
                  showDetails = false;
                  noticeScreen = false;*/
                });
              }
            },
            child: Container(
              width: parentWidth * 0.3,
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MasjitMappScreen(
                tabNum: "2", masjitTrusteeId: widget.masjitId, lat: widget.lat, long: widget.long,
              )));
              if (mounted) {
                setState(() {

                 /* mapScreen = false;
                  trusteeScreen = true;
                  showDetails = false;
                  noticeScreen = false;*/
                });
              }
            },
            child: Container(
              width: parentWidth * 0.3,
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MasjitMappScreen(
                tabNum: "3", masjitTrusteeId: widget.masjitId, lat: widget.lat, long: widget.long,
              )));
             /* if (mounted) {
                setState(() {
                 *//* mapScreen = false;
                  showDetails = false;
                  trusteeScreen = false;
                  noticeScreen = true;*//*
                });
              }*/
            },
            child: Container(
              width: parentWidth * 0.3,
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
  }

  Widget showScreenLayout(double parentHeight, double parentWidth) {
    return Container(
      height: parentHeight * 0.8,
      //color: Colors.blue,
      child: Stack(
        children: [
          Visibility(
              visible: mapScreen,
              child:  UserMapLocation(
                  masjitUserMapId: widget.masjitId, lat: '', long: '',)),
           Visibility(visible: trusteeScreen, child:  TrusteeUserTab(masjitTrusteeId:widget.masjitId)),
          Visibility(visible: noticeScreen, child:  NoticeUserTab()),



          Visibility(
            visible: showDetails,
            child: ListView(
                padding: EdgeInsets.only(bottom: parentHeight * 0.03,top: parentHeight*0.01),
                shrinkWrap: true,
                children: [



                  FutureBuilder<AllMasjitDetailsResponceModel>(
                      future: getMasjidInfo,
                      builder: (context, snapshot) {
                        print(" name...  ${snapshot.data?.place?.masjidName.toString()}");

                        return
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: parentHeight * 0.02),
                              child: snapshot.data?.place?.masjidName?.length != null?Text(
                                "${snapshot.data?.place?.masjidName.toString()}",
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                    color: CommonColor.BLACK,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto_bold'),
                              ):Container()
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: parentHeight * 0.003,
                                  left: parentHeight * 0.02),
                              child:snapshot.data?.place?.subLocality?.length != null? Text(
                                "${snapshot.data?.place?.subLocality}",
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                    color: CommonColor.BLACK,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6,
                                    fontFamily: 'Roboto_Regular'),
                              ):Container()
                            ),
                            Container(
                              // height: SizeConfig.screenHeight*.74,
                                width: SizeConfig.screenWidth,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: SizeConfig.screenHeight * .0,
                                          top: SizeConfig.screenHeight * .0),
                                      child: Column(
                                        children: [
                                          CarouselSlider.builder(

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
                                                enlargeStrategy:
                                                CenterPageEnlargeStrategy.height,
                                              ),
                                              itemBuilder: (BuildContext context,
                                                  int itemIndex, int index) {
                                                return getFirstImageFrame(
                                                    SizeConfig.screenHeight,
                                                    SizeConfig.screenWidth,
                                                    snapshot.data?.images?[index],
                                                    snapshot.data?.images?.length);
                                              }),
                                          Padding(
                                            padding: EdgeInsets.only(top: parentHeight*0.007),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                for (int i = 0; i <2; i++)
                                                  Container(
                                                    width: 7,
                                                    height: 7,
                                                    margin: const EdgeInsets.all(2),
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
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Column(
                              children: [
                                getAddFazarLayout(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                                getAddjummaLayout(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                                getAddshariIftarLayout(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                                getAddEidLayout(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                                ContinueButton(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth)
                              ],
                            )
                          ],
                        );
                      }),



                ]),
          ),
        ],
      ),
    );
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth, images, imageLen) {
    return Padding(
      padding: EdgeInsets.only(left: parentWidth * 0.03),
      child: Container(
        width: parentWidth,
        // color:Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.02),
              child: Container(
                height: parentHeight * .23,
                width: parentWidth * .94,
                decoration: BoxDecoration(
                    color: CommonColor.GRAY_COLOR,
                    borderRadius: BorderRadius.circular(0),
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

  Widget getAddFazarLayout(double parentHeight, double parentWidth) {
    return

      Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.03),
        child: Container(
          height: parentHeight * 0.20,
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
                        "DAILY TIME",
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

              Container(
                height: parentHeight * 0.16,

                //  color: Colors.red,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: parentHeight * 0.042,
                              left: parentHeight * 0.03),
                          child: const Text(
                            "AZAN",
                            style: TextStyle(
                                color: Colors.transparent,
                                fontFamily: 'Roboto_Bold',
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.001),
                          child: Container(
                              width: parentWidth * 0.21,
                              height: parentHeight * 0.026,
                              decoration: const BoxDecoration(
                                // color: Colors.blue,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: CommonColor.SEARCH_COLOR))),
                              child: Padding(
                                padding:
                                EdgeInsets.only(left: parentWidth * 0.05),
                                child: const Text(
                                  "AZAN",
                                  style: TextStyle(
                                      fontFamily: 'Roboto_Bold',
                                      fontWeight: FontWeight.w500,
                                      color: CommonColor.BLACK_COLOR,
                                      fontSize: 13),
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: parentHeight * 0.01, left: parentWidth * 0.03),
                          child: Row(
                            children: const [
                              Text(
                                "JAMAA'T",
                                style: TextStyle(
                                    fontFamily: 'Roboto_Bold',
                                    fontWeight: FontWeight.w500,
                                    color: CommonColor.BLACK_COLOR,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<AllMasjitDetailsResponceModel>(
                        future: getMasjidInfo,
                        builder: (context, snapshot) {
                          return  Expanded(
                            child: snapshot.data?.weeklyNamaz?.length !=Null ? ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                snapshot.data?.weeklyNamaz?.length,
                                scrollDirection: Axis.horizontal,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.03,
                                            right: parentHeight * 0.006),
                                        child: Text(
                                          "${snapshot.data?.weeklyNamaz?[index].day}",
                                          style: TextStyle(
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w500,
                                              color: CommonColor.BLACK_COLOR,
                                              fontSize: 10),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.013),
                                        child: Container(
                                          width: parentWidth * 0.145,
                                          height: parentHeight * 0.031,
                                          decoration: const BoxDecoration(
                                            // color: Colors.blue,
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: CommonColor
                                                          .SEARCH_COLOR))),
                                          child:  Padding(
                                            padding: EdgeInsets.only(
                                              top: parentHeight * 0.003,
                                                left: parentHeight * 0.006),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${snapshot.data?.weeklyNamaz?[index].azan}",
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          3.0),
                                                ),
                                              ],
                                            ),
                                          ),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.01,
                                            right: parentHeight * 0.00),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${snapshot.data?.weeklyNamaz?[index].jammat}",
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }):Container()
                          );

                        })
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
  Widget getAddjummaLayout(double parentHeight, double parentWidth) {
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
                        "JUMMA TIME",
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
                }),*/
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: parentHeight * 0.03),
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: parentWidth * 0.0),
                          child: const Text(
                            "AZAN",
                            style: TextStyle(
                                fontFamily: 'Roboto_Bold',
                                fontWeight: FontWeight.w500,
                                color: CommonColor.BLACK_COLOR,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.01, left: parentWidth * 0.03),
                        child: Row(
                          children: const [
                            Text(
                              "JAMAA'T",
                              style: TextStyle(
                                  fontFamily: 'Roboto_Bold',
                                  fontWeight: FontWeight.w500,
                                  color: CommonColor.BLACK_COLOR,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<AllMasjitDetailsResponceModel>(
                      future: getMasjidInfo,
                      builder: (context, snapshot) {


                        return Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(
                                  top: parentHeight * 0.03,right: parentHeight*0.25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data?.jumma?.azan}",
                                    style: TextStyle(
                                        fontSize: SizeConfig
                                            .blockSizeHorizontal *
                                            3.3),
                                  ),
                                ],
                              ),
                            ),

                            Container(

                                height: parentHeight*0.04,
                                width: parentWidth*0.7,

                                child:


                                ListView.builder(
                                  //physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.jumma?.jammat?.length,
                                    itemBuilder: (context, index) {

                                      return

                                        /* snapshot.data?.jumma?.jammat?.length != null
                                       ?*/
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: parentHeight * 0.01,
                                              left: parentHeight * 0.02),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${snapshot.data?.jumma?.jammat?[index]}",
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.3),
                                              ),
                                            ],
                                          ),
                                        );

                                    })
                            ),

                          ],
                        );
                      })
                ],
              ),
            ],
          ),
        ),
      );
  }

  Widget getAddshariIftarLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.03),
      child: Container(
          height: parentHeight * 0.16,
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
          child:  FutureBuilder<AllMasjitDetailsResponceModel>(
              future: getMasjidInfo,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: Container(
                        height: parentHeight * 0.04,
                        decoration: const BoxDecoration(
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
                              "SAHR / IFTAR",
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: parentWidth * 0.1, top: parentHeight * 0.02),
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
                                  right: parentWidth * 0.1, top: parentHeight * 0.02),
                              child:
                              Text("${snapshot.data?.sahr}",
                                  style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                    fontFamily: 'Roboto_Bold',
                                    fontWeight: FontWeight.w600,
                                    color: CommonColor.BLACK_COLOR,
                                  )) ,
                            ),
                          ],
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
                                  right: parentWidth * 0.1, top: parentHeight * 0.02),
                              child:
                              Text("${snapshot.data?.iftar}",
                                  style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                    fontFamily: 'Roboto_Bold',
                                    fontWeight: FontWeight.w600,
                                    color: CommonColor.BLACK_COLOR,
                                  ))

                            )
                          ],
                        )
                      ],
                    )
                  ],
                );
              })

      ),
    );
  }

  Widget getAddEidLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.02),
      child: Container(
          height: parentHeight * 0.18,
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
                offset: Offset(-5, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: const Offset(5, 0),
              )
            ],
          ),
          child:   FutureBuilder<AllMasjitDetailsResponceModel>(
              future: getMasjidInfo,
              builder: (context, snapshot) {
                return

                  Column(
                    children: [

                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                        child: Container(
                          height: parentHeight * 0.04,
                          decoration: const BoxDecoration(
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
                                "EID",
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

                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.eid?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder:
                                (context, index) {
                              return  Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: parentWidth * 0.1, top: parentHeight * 0.01),
                                        child: Text("${snapshot.data?.eid?[index].name}",
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
                                        child: Text("Jammat  ${snapshot.data?.eid?[index].jammat?[0]}",
                                            style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  );

              })





      ),
    ); //////
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    print("lllll   ${widget.masjitId}");
    return GestureDetector(
      onTap: () async {
      /*  await service.showScheduledNotification(
          id: 0,
          title: 'Notification Title',
          body: 'Some body',
          seconds: 2,
        );*/
        getJoinButtonSection(widget.masjitId);

      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.05,
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
                "JOIN",
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


  Future<AllMasjitDetailsResponceModel>getNoticeSection(masjitId) async {
    print(" tokennn ${box.get(kToken)}");

    var headersList = {
      'Authorization': 'Bearer ${box.get(kToken)}'
    };


    var response = await http.get(
      Uri.parse('http://masjid.exportica.in/api/masjids/${masjitId}'),
      headers: headersList,
      //  body: msg,
    );


    if (response.statusCode == 200) {


      print("Yess.. ${response.body}");

      print("Hiii");

      return allMasjitDetailsResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<AllMasjitJoinedTabButtonResponceModel>getJoinButtonSection(masjitId) async {


    var headersList = {
      'Authorization': 'Bearer ${box.get(kToken)}'
    };
    // final msg = jsonEncode({
    //   "user_id": userId.toString(),
    // });



    var response = await http.get(
      Uri.parse('http://masjid.exportica.in/api/user/join?masjid=${masjitId}'),
      headers:headersList,
      //  body: msg,
    );



    if (response.statusCode == 200) {
      box.put(kJoinedCommonId,masjitId );
      print(" kjoined ${box.get(kJoinedCommonId)}");
       Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ParentTabBarScreen()));
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      // circularLoader = false;

      print("Yess.. ${response.body}");

      print("yyyyyy");

      return allMasjitJoinedTabButtonResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }




}
