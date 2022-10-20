import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/all_masjit_list.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/map_screen.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/banner_response_model.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:masjiduserapp/util/removed_masjit_dilog_box.dart';

import 'masjit_user_app_api/masjit_app_responce_model/join_masjit_api_responce_model.dart';

class MasjitMainScreen extends StatefulWidget {
  const MasjitMainScreen(
      {Key? key,
      required this.tabbr,
      required this.masjitIdRemoved,
      required this.onNext})
      : super(key: key);
  final VoidCallback onNext;
  final String tabbr;
  final String masjitIdRemoved;

  @override
  State<MasjitMainScreen> createState() => _MasjitMainScreenState();
}

class _MasjitMainScreenState extends State<MasjitMainScreen>
    with SingleTickerProviderStateMixin, EndFriendDialogInterface {
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
  var getBanner;
  late Box box;
  final int _selectedIndex = 0;
  final List<dynamic> _allCommentsArr = [];

  @override
  void initState() {
    box = Hive.box(kBoxName);
    _tabController = TabController(length: 1, vsync: this);

    super.initState();
    getNotice = getNoticeSection();
    getBanner = getBannerImage();
    print(getNotice);
    if (mounted) {
      setState(() {
        showDetails = true;
        //   ViewImage = false;
      });
    }
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


                getBannerLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
                Expanded(
                  child: ThreeTabWithDesign(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getBannerLayout(double parentHeight, double parentWidth) {
    return FutureBuilder<BannerImage>(
        future: getBanner,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(
                  width: SizeConfig.screenWidth,
                  child: snapshot.data?.data?.length != null
                      ? CarouselSlider.builder(
                          itemCount: snapshot.data?.data?.length,
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
                            autoPlay: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int index1) {
                            final img = snapshot.data?.data?.isNotEmpty ?? false
                                ? NetworkImage(
                                    "http://masjid.exportica.in${snapshot.data?.data?[index1]}",
                                  )
                                : const NetworkImage("");

                            return Padding(
                              padding: EdgeInsets.only(
                                  top: parentHeight * 0.03,
                                  bottom: parentHeight * 0.01),
                              child: Container(
                                  height: parentHeight * 0.17,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                      BoxShadow(
                                        color: Colors.grey.shade50,
                                        offset: const Offset(-3, 0),
                                      ),
                                      BoxShadow(
                                        color: Colors.grey.shade50,
                                        offset: const Offset(1, 0),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: img, fit: BoxFit.cover)),
                                      ),
                                    ),
                                  )),
                            );
                          })
                      : Container()),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  for (int i = 0;
                  i <
                      (snapshot
                          .data
                          ?.data?.length ??
                          0);
                  i++)
                    Container(
                      width: 7,
                      height: 7,
                      margin:
                      const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? Colors.green
                            : Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    )
                ],
              ),
            ],
          );
        });
  }

  Widget ThreeTabWithDesign(double parentHeight, double parentWidth) {
    return FutureBuilder<AllMasjitJoinListResponceModel>(
        future: getNotice,
        builder: (context, snapshot) {
          print("nnnn  ${snapshot.data?.data?.length}");
          return snapshot.data?.data?.isNotEmpty ?? false
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 30),
                  itemCount: snapshot.data?.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: parentHeight * 0.03),
                      child: Column(
                        children: [
                          Row(
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
                                                masjitTrusteeId:
                                                    "${snapshot.data?.data?[index].id}",
                                                lat:
                                                    "${snapshot.data?.data?[index].place?[0].lat}",
                                                long:
                                                    "${snapshot.data?.data?[index].place?[0].long}",
                                                masjitNoticeId:
                                                    "${snapshot.data?.data?[index].id}",
                                              )));

                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  width: parentWidth * 0.28,
                                  height: parentHeight * 0.047,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50),
                                      border: Border.all(
                                          color: CommonColor.RIGHT_COLOR,
                                          width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Map",
                                      style: TextStyle(
                                        /*color: mapScreen == true
                                        ? Colors.white
                                        : Colors.black,*/
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
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
                                                masjitTrusteeId:
                                                    "${snapshot.data?.data?[index].id}",
                                                lat:
                                                    "${snapshot.data?.data?[index].place?[0].lat}",
                                                long:
                                                    "${snapshot.data?.data?[index].place?[0].long}",
                                                masjitNoticeId:
                                                    "${snapshot.data?.data?[index].id}",
                                              )));

                                  if (mounted) {
                                    setState(() {
                                      /*mapScreen = false;
                                  trusteeScreen = true;
                                  showDetails = false;
                                  noticeScreen = false;*/
                                    });
                                  }
                                },
                                child: Container(
                                  width: parentWidth * 0.28,
                                  height: parentHeight * 0.047,
                                  decoration: BoxDecoration(
                                      /*color: trusteeScreen
                                      ? CommonColor.REGISTRARTION_TRUSTEE
                                      .withOpacity(0.9)
                                      : Colors.white,*/
                                      borderRadius:
                                          BorderRadius.circular(50),
                                      border: Border.all(
                                          color: CommonColor.RIGHT_COLOR,
                                          width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Trustee",
                                      style: TextStyle(
                                        /*color: trusteeScreen
                                        ? Colors.white
                                        : Colors.black,*/
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
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
                                                masjitTrusteeId:
                                                    "${snapshot.data?.data?[index].id}",
                                                lat:
                                                    "${snapshot.data?.data?[index].place?[0].lat}",
                                                long:
                                                    "${snapshot.data?.data?[index].place?[0].long}",
                                                masjitNoticeId:
                                                    "${snapshot.data?.data?[index].id}",
                                              )));
                                  if (mounted) {
                                    setState(() {
                                      /* mapScreen = false;
                                  showDetails = false;
                                  trusteeScreen = false;
                                  noticeScreen = true;*/
                                    });
                                  }
                                },
                                child: Container(
                                  width: parentWidth * 0.28,
                                  height: parentHeight * 0.047,
                                  decoration: BoxDecoration(
                                      /*color: noticeScreen
                                      ? CommonColor.REGISTRARTION_TRUSTEE
                                      .withOpacity(0.9)
                                      : Colors.white,*/
                                      borderRadius:
                                          BorderRadius.circular(50),
                                      border: Border.all(
                                          color: CommonColor.RIGHT_COLOR,
                                          width: 1)),
                                  child: Center(
                                    child: Text(
                                      "Notice",
                                      style: TextStyle(
                                        /* color: noticeScreen == true
                                        ? Colors.white
                                        : Colors.black,*/
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.5,
                                        fontFamily: 'Roboto_Medium',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: parentHeight * 0.03),
                            child: Visibility(
                                visible: showDetails,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: parentWidth * 0.07),
                                          child: Row(
                                            /*  mainAxisAlignment:
                                            MainAxisAlignment.start,*/
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: SizeConfig
                                                          .screenWidth *
                                                      0.0,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: parentWidth *
                                                          0.02),
                                                  child: Image.asset(
                                                    'assets/images/masjit_logo.png',
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        .05,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: parentWidth * 0.5,
                                                // color:Colors.red,

                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: parentHeight *
                                                          0.01,
                                                      left: parentWidth *
                                                          0.02),
                                                  child: Text(
                                                    snapshot
                                                                .data
                                                                ?.data?[
                                                                    index]
                                                                .place?[0]
                                                                .masjidName !=
                                                            null
                                                        ? "${snapshot.data?.data?[index].place?[0].masjidName}"
                                                        : "",
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
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: parentWidth * 0.04,
                                              top: parentHeight * 0.005),
                                          child: SizedBox(
                                            width: parentWidth * .20,
                                            height: parentWidth * .07,
                                            // color: Colors.yellow,
                                            child: GestureDetector(
                                              onTap: () {
                                                showGeneralDialog(
                                                    barrierColor: Colors
                                                        .black
                                                        .withOpacity(0.8),
                                                    transitionBuilder:
                                                        (context, a1, a2,
                                                            widget) {
                                                      final curvedValue = Curves
                                                              .easeInOutBack
                                                              .transform(a1
                                                                  .value) -
                                                          1.0;
                                                      // return Transform(
                                                      //   transform: Matrix4.translationValues(
                                                      //       0.0, curvedValue * 200, 0.0),
                                                      return Transform
                                                          .scale(
                                                        scale: a1.value,
                                                        child: Opacity(
                                                          opacity: a1.value,
                                                          child:
                                                              EndFriendDialog(
                                                            index: index,
                                                            mListener: this,
                                                            masjitRemoveIdd:
                                                                "${snapshot.data?.data?[index].id}",
                                                            joinedMasjid:
                                                                _allCommentsArr,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    transitionDuration:
                                                        const Duration(
                                                            milliseconds:
                                                                200),
                                                    barrierDismissible:
                                                        true,
                                                    barrierLabel: '',
                                                    context: context,
                                                    // ignore: missing_return
                                                    pageBuilder: (context,
                                                        animation2,
                                                        animation1) {
                                                      return Container();
                                                    });
                                                print(
                                                    "MasjitIdRemovessss   ${widget.masjitIdRemoved}");
                                                print(
                                                    "id ${snapshot.data?.data?[index].id}");
                                              },
                                              child: Container(
                                                  height:
                                                      parentHeight * 0.03,
                                                  width: parentWidth * 0.3,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
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
                                                            .circular(7),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Roboto_Regular",
                                                          fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.0,
                                                          letterSpacing:
                                                              parentWidth *
                                                                  0.001,
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
                                          left: parentHeight * 0.01),
                                      child: Text(
                                        snapshot
                                                    .data
                                                    ?.data?[index]
                                                    .place?[0]
                                                    .subLocality !=
                                                null
                                            ? "${snapshot.data?.data?[index].place?[0].subLocality}"
                                            : "",
                                        style: TextStyle(
                                            fontSize: SizeConfig
                                                    .blockSizeHorizontal *
                                                4.0,
                                            color: CommonColor.BLACK_COLOR,
                                            fontWeight: FontWeight.w400,
                                            height: 1.6,
                                            fontFamily: 'Roboto_Bold'),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentHeight * 0.014),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Masjid Image",
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
                                                    right:
                                                        parentWidth * 0.05),
                                                child: Text(
                                                  "View",
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      color: CommonColor
                                                          .BLACK_COLOR,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                      child: SizedBox(
                                          //height: SizeConfig.screenHeight*.74,
                                          width: SizeConfig.screenWidth,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: SizeConfig
                                                          .screenHeight *
                                                      .0,
                                                  top:
                                                      SizeConfig.screenHeight *
                                                          .0),
                                              child: snapshot
                                                          .data
                                                          ?.data?[index]
                                                          .images
                                                          ?.length !=
                                                      null
                                                  ? CarouselSlider.builder(
                                                      // carouselController: _controller,
                                                      itemCount: snapshot
                                                          .data
                                                          ?.data?[index]
                                                          .images
                                                          ?.length,
                                                      /* snapshot.data?.data?[index].images?[0].length,*/
                                                      //widget.getChatGroupInfoData.length,
                                                      options:
                                                          CarouselOptions(
                                                        onPageChanged:
                                                            (index,
                                                                reason) {
                                                          setState(() {
                                                            currentIndex =
                                                                index;
                                                          });
                                                        },
                                                        initialPage: 1,
                                                        height: SizeConfig
                                                                .screenHeight *
                                                            .27,
                                                        // aspectRatio: 1.1,
                                                        viewportFraction:
                                                            1.0,
                                                        enableInfiniteScroll:
                                                            false,
                                                        autoPlay: false,
                                                        enlargeStrategy:
                                                            CenterPageEnlargeStrategy
                                                                .height,
                                                      ),
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int itemIndex,
                                                              int index1) {
                                                        return Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  parentWidth *
                                                                      0.03,
                                                              right:
                                                                  parentWidth *
                                                                      0.03),
                                                          child: SizedBox(
                                                            width:
                                                                parentWidth,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: parentHeight *
                                                                          0.02),
                                                                  child:
                                                                      Container(
                                                                    height: parentHeight *
                                                                        .23,
                                                                    width: parentWidth *
                                                                        .94,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                            image: DecorationImage(
                                                                      image: snapshot.data?.data?[index].images != null
                                                                          ? NetworkImage(
                                                                              "http://masjid.exportica.in/${snapshot.data?.data?[index].images?[index1]}",
                                                                            )
                                                                          : const NetworkImage(""),
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
                                          for (int i = 0;
                                              i <
                                                  (snapshot
                                                          .data
                                                          ?.data?[index]
                                                          .images
                                                          ?.length ??
                                                      0);
                                              i++)
                                            Container(
                                              width: 7,
                                              height: 7,
                                              margin:
                                                  const EdgeInsets.all(2),
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: parentHeight * 0.03),
                                          child: Container(
                                            height: parentHeight * 0.18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color:
                                                      Colors.grey.shade300,
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset:
                                                      const Offset(0, 5),
                                                ),
                                                BoxShadow(
                                                  color:
                                                      Colors.grey.shade50,
                                                  offset:
                                                      const Offset(-5, 0),
                                                ),
                                                BoxShadow(
                                                  color:
                                                      Colors.grey.shade50,
                                                  offset:
                                                      const Offset(5, 0),
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                              .only(
                                                          topRight: Radius
                                                              .circular(10),
                                                          topLeft: Radius
                                                              .circular(
                                                                  10)),
                                                  child: Container(
                                                    height:
                                                        parentHeight * 0.04,
                                                    decoration: const BoxDecoration(
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
                                                        ])),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "DAILY TIME",
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                4.0,
                                                            fontFamily:
                                                                'Roboto_Bold',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600,
                                                            color: CommonColor
                                                                .WHITE_COLOR,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      parentHeight * 0.13,

                                                  //  color: Colors.red,
                                                  child: Row(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: parentHeight *
                                                                    0.027,
                                                                right:
                                                                    parentHeight *
                                                                        0.0),
                                                            child:
                                                                const Text(
                                                              "AZAN",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .transparent,
                                                                  fontFamily:
                                                                      'Roboto_Bold',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      10),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                    top: parentHeight *
                                                                        0.0),
                                                            child: Container(
                                                                width: parentWidth * 0.14,
                                                                height: parentHeight * 0.024,
                                                                decoration: const BoxDecoration(
                                                                    // color: Colors.blue,
                                                                    border: Border(bottom: BorderSide(width: 1, color: CommonColor.SEARCH_COLOR))),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: parentWidth *
                                                                          0.02),
                                                                  child:
                                                                      const Text(
                                                                    "AZAN",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Roboto_Bold',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: CommonColor.BLACK_COLOR,
                                                                        fontSize: 10),
                                                                  ),
                                                                )),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                top: parentHeight *
                                                                    0.01,
                                                                left:
                                                                    parentWidth *
                                                                        0.0),
                                                            child: Row(
                                                              children: const [
                                                                Text(
                                                                  "JAMAAT",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Roboto_Bold',
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      color: CommonColor
                                                                          .BLACK_COLOR,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      /* FutureBuilder<
                                                              AllMasjitJoinListResponceModel>(
                                                          future:
                                                              getNotice,
                                                          builder: (context,
                                                              snapshot) {
                                                            return snapshot.data?.data?[0].weeklyNamaz?.length !=
                                                                    null
                                                                ?*/
                                                      Expanded(
                                                        child: ListView
                                                            .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount: snapshot
                                                                    .data
                                                                    ?.data?[
                                                                        0]
                                                                    .weeklyNamaz
                                                                    ?.length,
                                                                scrollDirection:
                                                                    Axis
                                                                        .horizontal,
                                                                physics:
                                                                    const NeverScrollableScrollPhysics(),
                                                                itemBuilder:
                                                                    (context,
                                                                        index1) {
                                                                  return Column(
                                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: parentHeight * 0.01, right: parentHeight * 0.006),
                                                                        child:
                                                                            Text(
                                                                          "${snapshot.data?.data?[index].weeklyNamaz?[index1].day}",
                                                                          style: const TextStyle(fontFamily: 'Roboto_Bold', fontWeight: FontWeight.w500, color: CommonColor.BLACK_COLOR, fontSize: 10),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: parentHeight * 0.01),
                                                                        child:
                                                                            Container(
                                                                          width: parentWidth * 0.145,
                                                                          height: parentHeight * 0.031,
                                                                          decoration: const BoxDecoration(
                                                                              // color: Colors.blue,
                                                                              border: Border(bottom: BorderSide(width: 1, color: CommonColor.SEARCH_COLOR))),
                                                                          child: Padding(
                                                                            padding: EdgeInsets.only(
                                                                                //left: parentHeight * 0.0,
                                                                                left: parentHeight * 0.006),
                                                                            child: Row(
                                                                              children: [
                                                                                Text(
                                                                                  "${snapshot.data?.data?[index].weeklyNamaz?[index1].azan}",
                                                                                  style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.0),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: parentHeight * 0.01, right: parentHeight * 0.00),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              "${snapshot.data?.data?[index].weeklyNamaz?[index1].jammat}",
                                                                              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.0),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }),
                                                      )
                                                      /*   : Container();
                                                          })*/
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
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
                                                    height:
                                                        parentHeight * 0.04,
                                                    decoration:
                                                        BoxDecoration(
                                                      gradient: const LinearGradient(
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
                                                              .circular(30),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  parentWidth *
                                                                      0.33),
                                                          child: Text(
                                                            "JUMMA TIME",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Roboto_Regular",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize:
                                                                    SizeConfig.blockSizeHorizontal *
                                                                        4.0,
                                                                color: CommonColor
                                                                    .WHITE_COLOR),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  parentWidth *
                                                                      0.05),
                                                          child:
                                                              Image.asset(
                                                            'assets/images/up_arrow.png',
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                Visibility(
                                                    visible: FridayTime,
                                                    child: Container(
                                                      height: parentHeight *
                                                          0.13,
                                                      decoration:
                                                          BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            bottomRight:
                                                                Radius
                                                                    .circular(
                                                                        20),
                                                            bottomLeft: Radius
                                                                .circular(
                                                                    20)),
                                                        boxShadow: <
                                                            BoxShadow>[
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey
                                                                .shade300,
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 5),
                                                          ),
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey
                                                                .shade50,
                                                            offset:
                                                                const Offset(
                                                                    -5, 0),
                                                          ),
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey
                                                                .shade50,
                                                            offset:
                                                                const Offset(
                                                                    5, 0),
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
                                                                padding: EdgeInsets.only(
                                                                    top: parentHeight *
                                                                        0.03,
                                                                    left: parentWidth *
                                                                        0.03),
                                                                child: Row(
                                                                  children: const [
                                                                    Text(
                                                                      "JAMAAT",
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
                                                          FutureBuilder<
                                                                  AllMasjitJoinListResponceModel>(
                                                              future:
                                                                  getNotice,
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Column(
                                                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.only(top: 12),
                                                                      child: SizedBox(
                                                                          // color: Colors.red,
                                                                          height: parentHeight * 0.11,
                                                                          width: parentWidth * 0.7,
                                                                          child: ListView.builder(
                                                                              //physics: NeverScrollableScrollPhysics(),
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                              itemCount: snapshot.data?.data?[index].jumma?.jammat?.length,
                                                                              itemBuilder: (context, index1) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.only(top: parentHeight * 0.015, left: parentHeight * 0.02),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(
                                                                                        "${snapshot.data?.data?[index].jumma?.jammat?[index1]}",
                                                                                        style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.3),
                                                                                        maxLines: 3,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              })),
                                                                    ),
                                                                  ],
                                                                );
                                                              })
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        getAddshariIftarLayout(
                                            SizeConfig.screenHeight,
                                            SizeConfig.screenWidth,
                                            "${snapshot.data?.data?[index].sahr}",
                                            "${snapshot.data?.data?[index].iftar}"),
                                        getAddEidLayout(
                                          SizeConfig.screenHeight,
                                          SizeConfig.screenWidth,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Divider(
                              thickness: 1,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    );
                  })
              : GestureDetector(
                  onTap: () {
                    widget.onNext();
                  },
                  child: Center(
                    child: Container(
                        height: parentHeight * 0.06,
                        width: parentWidth * 0.4,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
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
                );
        });
  }

  Widget getFirstImageFrame(
      double parentHeight, double parentWidth, images, imageLen) {
    return Padding(
      padding:
          EdgeInsets.only(left: parentWidth * 0.03, right: parentWidth * 0.03),
      child: SizedBox(
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
                            : const NetworkImage(""),
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
                      "DAILY TIME",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                        fontFamily: 'Roboto_Bold',
                        fontWeight: FontWeight.w600,
                        color: CommonColor.WHITE_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
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
                              "JAMAAT",
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
                                              "${snapshot.data?.data?[0].weeklyNamaz?[index].day}",
                                              style: const TextStyle(
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
                                                      "${snapshot.data?.data?[0].weeklyNamaz?[index].azan}",
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
                                                  "${snapshot.data?.data?[0].weeklyNamaz?[index].jammat}",
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

  Widget getAddFridayTimeLayout(
      double parentHeight, double parentWidth, int index) {
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
                height: parentHeight * 0.04,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.WHITE_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Image.asset(
                        'assets/images/up_arrow.png',
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
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
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
                  //  color: Colors.red,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          /*  Padding(
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
                          ),*/
                          Padding(
                            padding: EdgeInsets.only(
                                top: parentHeight * 0.03,
                                left: parentWidth * 0.03),
                            child: Row(
                              children: const [
                                Text(
                                  "JAMAAT",
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
                                /*Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.03,
                                      right: parentHeight * 0.25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data?.data?[0].jumma?.azan}",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.3),
                                      ),
                                    ],
                                  ),
                                ),*/
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: SizedBox(
                                      // color: Colors.red,
                                      height: parentHeight * 0.11,
                                      width: parentWidth * 0.7,
                                      child: ListView.builder(
                                          //physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data?.data?[index]
                                              .jumma?.jammat?.length,
                                          itemBuilder: (context, index1) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: parentHeight * 0.015,
                                                  left: parentHeight * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapshot.data?.data?[index].jumma?.jammat?[index1]}",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            3.3),
                                                    maxLines: 3,
                                                  ),
                                                ],
                                              ),
                                            );
                                          })),
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget getAddshariIftarLayout(
      double parentHeight, double parentWidth, sahr, iftar) {
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
                height: parentHeight * 0.04,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                        "SAHAR / IFTAR",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.WHITE_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Image.asset(
                        'assets/images/up_arrow.png',
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
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
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
                                      child: Text("SAHAR",
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
                                        : const Text(""),
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
                height: parentHeight * 0.04,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
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
                        "EID",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.WHITE_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.05),
                      child: Image.asset(
                        'assets/images/up_arrow.png',
                      ),
                    ),
                  ],
                )),
            Visibility(
              visible: eid,
              child: Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.0),
                child: Container(
                  height: parentHeight * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
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
                  child: FutureBuilder<AllMasjitJoinListResponceModel>(
                      future: getNotice,
                      builder: (context, snapshot) {
                        final masjids = snapshot.data?.data;
                        return masjids?[0].eid?.length != null
                            ? Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: masjids?[0].eid?.length,
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
                                                          "${masjids?[0].eid?[index].name}",
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
                                                    /* Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentWidth *
                                                        0.05,
                                                    top: parentHeight *
                                                        0.01),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "Jammat",
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
                                                    Text(
                                                        "${snapshot.data?.data?[0].eid?[index].jammat?[0]}",
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
                                                  ],
                                                ),
                                              ),*/
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: parentWidth *
                                                              0.05,
                                                          top: parentHeight *
                                                              0.01),
                                                      child: Row(
                                                        children: [
                                                          Text("Jammat",
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    4.3,
                                                                fontFamily:
                                                                    'Roboto_Bold',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: CommonColor
                                                                    .BLACK_COLOR,
                                                              )),
                                                          Column(
                                                            children: [
                                                              for (int i = 0;
                                                                  i <
                                                                      (masjids?[0]
                                                                              .eid?[
                                                                                  index]
                                                                              .jammat
                                                                              ?.length ??
                                                                          0);
                                                                  i++)
                                                                Text(
                                                                    " ${masjids?[0].eid?[index].jammat?[i]}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          SizeConfig.blockSizeHorizontal *
                                                                              4.3,
                                                                      fontFamily:
                                                                          'Roboto_Bold',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: CommonColor
                                                                          .BLACK_COLOR,
                                                                    )),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
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
            context,
            MaterialPageRoute(
                builder: (context) => AllMasjitList(
                      onNext: () {},
                    )));
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
                    color: CommonColor.RIGHT_COLOR),
              ),
            )),
      ),
    );
  }

  Widget SlideBanner(
      double parentHeight, double parentWidth, images, imageLen) {
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
                offset: const Offset(0, 1),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: const Offset(-3, 0),
              ),
              BoxShadow(
                color: Colors.grey.shade50,
                offset: const Offset(1, 0),
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
                          : const NetworkImage(""),
                      fit: BoxFit.cover)),
            ),
          )),
    );
  }

  Future<AllMasjitJoinListResponceModel> getNoticeSection() async {
    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse('http://masjid.exportica.in/api/user/joined'),
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      var masjid = jsonData["data"];
      if (mounted) {
        setState(() {
          _allCommentsArr.addAll(masjid);
        });
      }

      print(" list $_allCommentsArr");
      //  print("Yess.. ${response.body}");

      print("Hiii");

      return allMasjitJoinListResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<BannerImage> getBannerImage() async {
    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse('http://masjid.exportica.in/api/user/banners'),
        headers: headersList);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      print("Bannner ${jsonData['data']}");

      for(int i =0;i<2;i++){
        print("${jsonData['data'][i]}");
      }
      print("Hiii");

      return bannerImageFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  /* Future<UseRemoveResponceModel> getRemoveMasjit(
      masjitIdRemoved, int index) async {
    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse(
            'http://masjid.exportica.in/api/user/remove?masjid=${masjitIdRemoved}'),
        headers: headersList);

    if (response.statusCode == 200) {
      if (mounted)
        setState(() {
          _allCommentsArr.removeAt(index);

          getNoticeSection();

        });

      print("Yess.. ${response.body}");

      print("Hiii");

      return useRemoveResponceModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }*/

  @override
  callUnFriendApi(String userId, String isConverted, int index, String msgId) {
    // TODO: implement callUnFriendApi
    throw UnimplementedError();
  }
}
