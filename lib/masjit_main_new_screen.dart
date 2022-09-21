import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/all_masjit_list.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/map_screen.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/constant.dart';

import 'masjit_user_app_api/masjit_app_responce_model/join_masjit_api_responce_model.dart';

class MasjitMainScreen extends StatefulWidget {
  const MasjitMainScreen({Key? key, required this.tabbr}) : super(key: key);
  final String tabbr;

  @override
  State<MasjitMainScreen> createState() => _MasjitMainScreenState();
}

class _MasjitMainScreenState extends State<MasjitMainScreen>
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
  TabController? _tabController;
  var getNotice;
  late Box box;
  List<dynamic> _allCommentsArr = [];

  @override
  void initState() {
    box = Hive.box(kBoxName);
    _tabController = TabController(length: 1, vsync: this);

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
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
          child: Container(
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
            child: ThreeTabWithDesign(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
        ));
  }

  Widget ThreeTabWithDesign(double parentHeight, double parentWidth) {
    return FutureBuilder<AllMasjitJoinListResponceModel>(
        future: getNotice,
        builder: (context, snapshot) {
          print("nnnn  ${snapshot.data?.data?.length}");
          return Stack(
            children: [
              snapshot.data?.data?.length != 0
                  ? Container(
                  child: ListView.builder(
                      itemCount: snapshot.data?.data?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                          EdgeInsets.only(top: parentHeight * 0.04),
                          child: Column(
                            children: [
                              Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: parentHeight * 0.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onDoubleTap: () {},
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MasjitMappScreen(
                                                          tabNum: "1",
                                                          masjitTrusteeId: '',
                                                          lat: '',
                                                          long: '',
                                                        )));

                                            if (mounted) {
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                            width: parentWidth * 0.28,
                                            height: parentHeight * 0.05,
                                            decoration: BoxDecoration(
                                              /*mapScreen == true*/
                                              // CommonColor.REGISTRARTION_TRUSTEE,

                                              // Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                border: Border.all(
                                                    color:
                                                    CommonColor.RIGHT_COLOR,
                                                    width: 1)),
                                            child: Center(
                                              child: Text(
                                                "Map",
                                                style: TextStyle(
                                                  /*color: mapScreen == true
                                                  ? Colors.white
                                                  : Colors.black,*/
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3.5,
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
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MasjitMappScreen(
                                                            tabNum: "2",
                                                            masjitTrusteeId: '',
                                                            lat: '',
                                                            long: '')));

                                            if (mounted)
                                              setState(() {
                                                /*mapScreen = false;
                                            trusteeScreen = true;
                                            showDetails = false;
                                            noticeScreen = false;*/
                                              });
                                          },
                                          child: Container(
                                            width: parentWidth * 0.28,
                                            height: parentHeight * 0.05,
                                            decoration: BoxDecoration(
                                              /*color: trusteeScreen
                                                ? CommonColor.REGISTRARTION_TRUSTEE
                                                .withOpacity(0.9)
                                                : Colors.white,*/
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                border: Border.all(
                                                    color:
                                                    CommonColor.RIGHT_COLOR,
                                                    width: 1)),
                                            child: Center(
                                              child: Text(
                                                "Trustee",
                                                style: TextStyle(
                                                  /*color: trusteeScreen
                                                  ? Colors.white
                                                  : Colors.black,*/
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3.5,
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
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MasjitMappScreen(
                                                          tabNum: "3",
                                                          masjitTrusteeId: '',
                                                          lat: '',
                                                          long: '',
                                                        )));
                                            if (mounted)
                                              setState(() {
                                                /* mapScreen = false;
                                            showDetails = false;
                                            trusteeScreen = false;
                                            noticeScreen = true;*/
                                              });
                                          },
                                          child: Container(
                                            width: parentWidth * 0.28,
                                            height: parentHeight * 0.05,
                                            decoration: BoxDecoration(
                                              /*color: noticeScreen
                                                ? CommonColor.REGISTRARTION_TRUSTEE
                                                .withOpacity(0.9)
                                                : Colors.white,*/
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                border: Border.all(
                                                    color:
                                                    CommonColor.RIGHT_COLOR,
                                                    width: 1)),
                                            child: Center(
                                              child: Text(
                                                "Notice",
                                                style: TextStyle(
                                                  /* color: noticeScreen == true
                                                  ? Colors.white
                                                  : Colors.black,*/
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                      3.5,
                                                  fontFamily: 'Roboto_Medium',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                /* });
                      }),*/
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: parentHeight * 0.03),
                                child: Visibility(
                                    visible: showDetails,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  parentHeight * 0.02),
                                              child: Text(
                                                "${snapshot.data?.data?[index]
                                                    .place?[0].masjidName}",
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        4.0,
                                                    color: CommonColor
                                                        .BLACK_COLOR,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontFamily:
                                                    'Roboto_Bold'),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: parentWidth * 0.05,
                                                  top:
                                                  parentHeight * 0.005),
                                              child: Container(
                                                width: parentWidth * .20,
                                                height: parentWidth * .07,
                                                // color: Colors.yellow,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print(
                                                        "id ${snapshot.data
                                                            ?.data?[index]
                                                            .id}");
                                                    setState(() {
                                                      _allCommentsArr.removeAt(
                                                          index);
                                                    });

                                                  },
                                                  child: Container(
                                                      height: parentHeight *
                                                          0.03,
                                                      width:
                                                      parentWidth * 0.3,
                                                      decoration:
                                                      BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            colors: [
                                                              CommonColor
                                                                  .LEFT_COLOR,
                                                              CommonColor
                                                                  .RIGHT_COLOR
                                                            ]),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            7),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Removed",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "Roboto_Regular",
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                              fontSize:
                                                              SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  3.0,
                                                              color: CommonColor
                                                                  .WHITE_COLOR),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: parentHeight * 0.003,
                                              left: parentHeight * 0.02),
                                          child: Text(
                                            " ${snapshot.data?.data?[index]
                                                .place?[0].subLocality}",
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                    .blockSizeHorizontal *
                                                    4.0,
                                                color:
                                                CommonColor.BLACK_COLOR,
                                                fontWeight: FontWeight.w400,
                                                height: 1.6,
                                                fontFamily: 'Roboto_Bold'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: parentHeight * 0.02),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "Masjid Image",
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        4.0,
                                                    color: CommonColor
                                                        .BLACK_COLOR,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    height: 1.6,
                                                    fontFamily:
                                                    'Roboto_Bold'),
                                              ),
                                              GestureDetector(
                                                onTapDown: (tab) {
                                                  setState(() {
                                                    ViewImage = !ViewImage;
                                                  });
                                                },
                                                child: Container(
                                                  height:
                                                  parentHeight * 0.02,
                                                  color: Colors.transparent,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: parentWidth *
                                                            0.05),
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                              4.0,
                                                          color: CommonColor
                                                              .BLACK_COLOR,
                                                          fontWeight:
                                                          FontWeight
                                                              .w400,
                                                          fontFamily:
                                                          'Roboto_Regular'),
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
                                                      right:
                                                      SizeConfig.screenHeight *
                                                          .0,
                                                      top: SizeConfig
                                                          .screenHeight *
                                                          .0),
                                                  child: snapshot.data?.data
                                                      ?.length !=
                                                      null
                                                      ? CarouselSlider
                                                      .builder(
                                                    // carouselController: _controller,
                                                      itemCount: snapshot
                                                          .data
                                                          ?.data
                                                          ?.length,
                                                      /* snapshot.data?.data?[index].images?[0].length,*/
                                                      //widget.getChatGroupInfoData.length,
                                                      options:
                                                      CarouselOptions(
                                                        onPageChanged:
                                                            (index,
                                                            reason) {
                                                          setState(
                                                                  () {
                                                                currentIndex =
                                                                    index;
                                                              });
                                                        },
                                                        initialPage:
                                                        1,
                                                        height:
                                                        SizeConfig
                                                            .screenHeight *
                                                            .27,
                                                        // aspectRatio: 1.1,
                                                        viewportFraction:
                                                        1.0,
                                                        enableInfiniteScroll:
                                                        false,
                                                        autoPlay:
                                                        false,
                                                        enlargeStrategy:
                                                        CenterPageEnlargeStrategy
                                                            .height,
                                                      ),
                                                      itemBuilder: (
                                                          BuildContext context,
                                                          int itemIndex,
                                                          int index) {
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left: parentWidth *
                                                                  0.03,
                                                              right:
                                                              parentWidth *
                                                                  0.03),
                                                          child:
                                                          Container(
                                                            width:
                                                            parentWidth,
                                                            child:
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      top: parentHeight *
                                                                          0.02),
                                                                  child: Container(
                                                                    height: parentHeight *
                                                                        .23,
                                                                    width: parentWidth *
                                                                        .94,
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                          image: snapshot
                                                                              .data
                                                                              ?.data?[index]
                                                                              .images !=
                                                                              null
                                                                              ? NetworkImage(
                                                                            "${snapshot
                                                                                .data
                                                                                ?.data?[index]
                                                                                .images}",
                                                                          )
                                                                              : NetworkImage(
                                                                              ""),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      })
                                                      : Container())),
                                        ),
                                        Visibility(
                                          visible: ViewImage,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              for (int i = 0; i < 2; i++)
                                                Container(
                                                  width: 7,
                                                  height: 7,
                                                  margin: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    color: currentIndex == i
                                                        ? Colors.green
                                                        : Colors
                                                        .grey.shade400,
                                                    shape: BoxShape.circle,
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            getAddJammatTimeLayout(
                                                SizeConfig.screenHeight,
                                                SizeConfig.screenWidth),
                                            getAddFridayTimeLayout(
                                                SizeConfig.screenHeight,
                                                SizeConfig.screenWidth),
                                            getAddshariIftarLayout(
                                                SizeConfig.screenHeight,
                                                SizeConfig.screenWidth,
                                                "${snapshot.data?.data?[index]
                                                    .sahr}",
                                                "${snapshot.data?.data?[index]
                                                    .iftar}"),
                                            getAddEidLayout(
                                                SizeConfig.screenHeight,
                                                SizeConfig.screenWidth),
                                            Container(
                                              //height: SizeConfig.screenHeight*.74,
                                                width:
                                                SizeConfig.screenWidth,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: SizeConfig
                                                            .screenHeight *
                                                            .0,
                                                        top: SizeConfig
                                                            .screenHeight *
                                                            .0),
                                                    child: snapshot.data?.data
                                                        ?.length !=
                                                        null
                                                        ? CarouselSlider
                                                        .builder(
                                                      // carouselController: _controller,
                                                        itemCount: snapshot
                                                            .data
                                                            ?.data
                                                            ?.length,
                                                        //widget.getChatGroupInfoData.length,
                                                        options:
                                                        CarouselOptions(
                                                          onPageChanged:
                                                              (index,
                                                              reason) {
                                                            setState(
                                                                    () {
                                                                  currentIndex =
                                                                      index;
                                                                });
                                                          },
                                                          initialPage:
                                                          1,
                                                          height:
                                                          SizeConfig
                                                              .screenHeight *
                                                              .27,
                                                          // aspectRatio: 1.1,
                                                          viewportFraction:
                                                          1.0,
                                                          enableInfiniteScroll:
                                                          false,
                                                          autoPlay:
                                                          false,
                                                          enlargeStrategy:
                                                          CenterPageEnlargeStrategy
                                                              .height,
                                                        ),
                                                        itemBuilder:
                                                            (
                                                            BuildContext context,
                                                            int itemIndex,
                                                            int index) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: parentHeight *
                                                                    0.03,
                                                                bottom:
                                                                parentHeight *
                                                                    0.06),
                                                            child: Container(
                                                                height: parentHeight *
                                                                    0.17,
                                                                decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade200,
                                                                  borderRadius: BorderRadius
                                                                      .circular(
                                                                      20),
                                                                  boxShadow: <
                                                                      BoxShadow>[
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      spreadRadius: 1,
                                                                      blurRadius: 2,
                                                                      offset: Offset(
                                                                          0, 1),
                                                                    ),
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade50,
                                                                      offset: Offset(
                                                                          -3,
                                                                          0),
                                                                    ),
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade50,
                                                                      offset: Offset(
                                                                          1, 0),
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Center(
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image: snapshot
                                                                                .data
                                                                                ?.data?[index]
                                                                                .banners !=
                                                                                null
                                                                                ? NetworkImage(
                                                                              "${snapshot
                                                                                  .data
                                                                                  ?.data?[index]
                                                                                  .banners}",
                                                                            )
                                                                                : NetworkImage(
                                                                                ""),
                                                                            fit: BoxFit
                                                                                .cover)),
                                                                  ),
                                                                )),
                                                          );

                                                          /*getFirstImageFrame(
                                                              SizeConfig.screenHeight,
                                                              SizeConfig.screenWidth,
                                                              snapshot.data?.data?[0].images?[0],
                                                              snapshot
                                                                  .data?.data?[0].images?.length);*/
                                                        })
                                                        : Container()))

                                            /* MasjitNameLocation(
                                      SizeConfig.screenHeight, SizeConfig.screenWidth),*/
                                          ],
                                        )

                                        /* Text("Masjid Name"),
                          Text ("Location :")*/
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        );
                      }))
                  : GestureDetector(
                onTap: () {
                  _tabController?.animateTo(1);
                },
                child: Center(
                  child: Container(
                      height: parentHeight * 0.06,
                      width: parentWidth * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              CommonColor.LEFT_COLOR,
                              CommonColor.RIGHT_COLOR
                            ]),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          "Join Masjid",
                          style: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontWeight: FontWeight.w700,
                              fontSize:
                              SizeConfig.blockSizeHorizontal * 4.3,
                              color: CommonColor.WHITE_COLOR),
                        ),
                      )),
                ),
              ),

              // Text("Hii")
            ],
          );
        });
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth, images,
      imageLen) {
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
                        image: images != null
                            ? NetworkImage(
                          images,
                        )
                            : NetworkImage(""),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddJammatTimeLayout(double parentHeight, double parentWidth) {
    // print("data null  ${}")
    return Padding(
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
            Container(
              height: parentHeight * 0.13,

              //  color: Colors.red,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.027,
                            right: parentHeight * 0.0),
                        child: const Text(
                          "AZAN",
                          style: TextStyle(
                              color: Colors.transparent,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: parentHeight * 0.0),
                        child: Container(
                            width: parentWidth * 0.14,
                            height: parentHeight * 0.024,
                            decoration: const BoxDecoration(
                              // color: Colors.blue,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: CommonColor.SEARCH_COLOR))),
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: parentWidth * 0.02),
                              child: const Text(
                                "AZAN",
                                style: TextStyle(
                                    fontFamily: 'Roboto_Bold',
                                    fontWeight: FontWeight.w500,
                                    color: CommonColor.BLACK_COLOR,
                                    fontSize: 10),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.01, left: parentWidth * 0.0),
                        child: Row(
                          children: const [
                            Text(
                              "JAMAA'T",
                              style: TextStyle(
                                  fontFamily: 'Roboto_Bold',
                                  fontWeight: FontWeight.w500,
                                  color: CommonColor.BLACK_COLOR,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<AllMasjitJoinListResponceModel>(
                      future: getNotice,
                      builder: (context, snapshot) {
                        return snapshot.data?.data?[0].weeklyNamaz?.length !=
                            null
                            ? Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot
                                  .data?.data?[0].weeklyNamaz?.length,
                              scrollDirection: Axis.horizontal,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.01,
                                          right: parentHeight * 0.006),
                                      child: Text(
                                        "${snapshot.data?.data?[0]
                                            .weeklyNamaz?[index].day}",
                                        style: TextStyle(
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w500,
                                            color:
                                            CommonColor.BLACK_COLOR,
                                            fontSize: 10),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.01),
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
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            //left: parentHeight * 0.0,
                                              left: parentHeight * 0.006),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${snapshot.data?.data?[0]
                                                    .weeklyNamaz?[index].azan}",
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: parentHeight * 0.01,
                                          right: parentHeight * 0.00),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${snapshot.data?.data?[0]
                                                .weeklyNamaz?[index].jammat}",
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
                  //  color: Colors.red,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: parentHeight * 0.03),
                            child: Padding(
                              padding: EdgeInsets.only(left: parentWidth * 0.0),
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
                                top: parentHeight * 0.01,
                                left: parentWidth * 0.03),
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
                      FutureBuilder<AllMasjitJoinListResponceModel>(
                          future: getNotice,
                          builder: (context, snapshot) {
                            return Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.03,
                                      right: parentHeight * 0.25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data?.data?[0].jumma
                                            ?.azan}",
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.3),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: parentHeight * 0.04,
                                    width: parentWidth * 0.7,
                                    child: snapshot.data?.data?.length != null
                                        ? ListView.builder(
                                      //physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                        snapshot.data?.data?.length,
                                        itemBuilder: (context, index) {
                                          return

                                            /* snapshot.data?.jumma?.jammat?.length != null
                                       ?*/
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: parentHeight * 0.01,
                                                  left: parentHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapshot.data?.data?[0]
                                                        .jumma?.jammat?[0]}",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            3.3),
                                                  ),
                                                ],
                                              ),
                                            );
                                        })
                                        : Container()),
                              ],
                            );
                          })
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget getAddshariIftarLayout(double parentHeight, double parentWidth, sahr,
      iftar) {
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
                    child: FutureBuilder<AllMasjitJoinListResponceModel>(
                        future: getNotice,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                EdgeInsets.only(top: parentHeight * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.1,
                                          top: parentHeight * 0.0),
                                      child: Text("SAHR",
                                          style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: parentWidth * 0.1,
                                          top: parentHeight * 0.0),
                                      child: sahr != null
                                          ? Text(sahr,
                                          style: TextStyle(
                                            fontSize: SizeConfig
                                                .blockSizeHorizontal *
                                                4.3,
                                            fontFamily: 'Roboto_Bold',
                                            fontWeight: FontWeight.w600,
                                            color: CommonColor.BLACK_COLOR,
                                          ))
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentHeight * 0.05,
                                        top: parentHeight * 0.03),
                                    child: Text("IFTAR",
                                        style: TextStyle(
                                          fontSize:
                                          SizeConfig.blockSizeHorizontal *
                                              4.3,
                                          fontFamily: 'Roboto_Bold',
                                          fontWeight: FontWeight.w600,
                                          color: CommonColor.BLACK_COLOR,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: parentWidth * 0.1,
                                        top: parentHeight * 0.03),
                                    child: iftar != null
                                        ? Text(iftar,
                                        style: TextStyle(
                                          fontSize: SizeConfig
                                              .blockSizeHorizontal *
                                              4.3,
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
                        })))
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
                  child: FutureBuilder<AllMasjitJoinListResponceModel>(
                      future: getNotice,
                      builder: (context, snapshot) {
                        return snapshot.data?.data?[0].eid?.length != null
                            ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                  snapshot.data?.data?[0].eid?.length,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: parentHeight * 0.02),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                    parentWidth * 0.1,
                                                    top: parentHeight *
                                                        0.01),
                                                child: Text(
                                                    "${snapshot.data
                                                        ?.data?[index]
                                                        .eid?[index].name}",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          4.3,
                                                      fontFamily:
                                                      'Roboto_Bold',
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: CommonColor
                                                          .BLACK_COLOR,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentWidth *
                                                        0.05,
                                                    top: parentHeight *
                                                        0.01),
                                                child: Text(
                                                    "Jammat  ${snapshot.data
                                                        ?.data?[0].eid?[0]
                                                        .jammat?[0]}",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          4.3,
                                                      fontFamily:
                                                      'Roboto_Bold',
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: CommonColor
                                                          .BLACK_COLOR,
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AllMasjitList()));
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

  Widget SlideBanner(double parentHeight, double parentWidth, images,
      imageLen) {
    return Padding(
      padding: EdgeInsets.only(
          top: parentHeight * 0.03, bottom: parentHeight * 0.06),
      child: Container(
          height: parentHeight * 0.17,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(-3, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: Offset(1, 0),
              )
            ],
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: images != null
                          ? NetworkImage(
                        images.toString(),
                      )
                          : NetworkImage(""),
                      fit: BoxFit.cover)),
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
                /*Navigator.push(context,/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              MaterialPageRoute(builder: (context) => MasjitNameLocation()));*/
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
                                    top: parentHeight * 0.03),
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
                                child: Text("JAMAA’T",
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

  Future<AllMasjitJoinListResponceModel> getNoticeSection() async {
    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    // final msg = jsonEncode({
    //   "user_id": userId.toString(),
    // });

    var response = await http.get(
        Uri.parse('http://masjid.exportica.in/api/user/joined'),
        headers: headersList);

    var jsonData = json.decode(response.body);

    print("Hiiiiiii $jsonData");

    var masjid = jsonData["data"]["id"];

    if (response.statusCode == 200) {
      _allCommentsArr.add(response.body);
      print(" list ${_allCommentsArr}");
      print("Yess.. ${response.body}");

      print("Hiii");

      return allMasjitJoinListResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
