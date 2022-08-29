import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/trustee_user_tab.dart';
import 'package:masjiduserapp/user_map_tab.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';


import 'common.color.dart';
import 'masjit_name_masjit_jioned_user.dart';
import 'notice_user_tab.dart';

class MasjitNameLocation extends StatefulWidget {
  const MasjitNameLocation({Key? key}) : super(key: key);

  @override
  _MasjitNameLocationState createState() => _MasjitNameLocationState();
}

class _MasjitNameLocationState extends State<MasjitNameLocation>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "Featured"),
    new Tab(text: "Popular"),
    new Tab(text: "Latest")
  ];

  TabController? _tabController;
  bool showDetails = true;

  get gradient => null;

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

  @override
  void initState() {
    super.initState();
    if (mounted)
      setState(() {
        showDetails = true;
      });
    _tabController = new TabController(vsync: this, length: tabs.length);
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
                  CityContant(SizeConfig.screenHeight, SizeConfig.screenWidth),
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
    return Row(
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
            if (mounted)
              setState(() {
                mapScreen = false;
                trusteeScreen = true;
                showDetails = false;
                noticeScreen = false;
              });
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
                  color: trusteeScreen  ? Colors.white : Colors.black,
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
    );
  }

  Widget showScreenLayout(double parentHeight, double parentWidth) {
    return Container(
      //child: Container(
      height: parentHeight * 0.8,
      //color: Colors.blue,
      child: Stack(
        children: [
          Visibility(visible: mapScreen, child: UserMapLocation()),
          Visibility(visible: trusteeScreen, child: TrusteeUserTab()),
          Visibility(visible: noticeScreen, child: NoticeUserTab()),
          Visibility(
            visible: showDetails,
            child: ListView(
                padding: EdgeInsets.only(bottom: parentHeight * 0.03),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: parentHeight * 0.02),
                        child: Text(
                          "Masjid Name",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.BLACK,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Roboto_bold'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.003,
                            left: parentHeight * 0.02),
                        child: Text(
                          "Location :",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              color: CommonColor.BLACK,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                              fontFamily: 'Roboto_Regular'),
                        ),
                      ),
                      Container(
                          // height: SizeConfig.screenHeight*.74,
                          width: SizeConfig.screenWidth,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.screenHeight * .0,
                                top: SizeConfig.screenHeight * .0),
                            child: CarouselSlider.builder(
                                // carouselController: _controller,
                                itemCount: listPaths.length,
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
                                      SizeConfig.screenWidth);
                                }),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          for (int i = 0; i < listPaths.length; i++)
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
                      Column(
                        children: [
                          getAddFazarLayout(
                              SizeConfig.screenHeight, SizeConfig.screenWidth),
                          getAddshariIftarLayout(
                              SizeConfig.screenHeight, SizeConfig.screenWidth),
                          getAddEidLayout(
                              SizeConfig.screenHeight, SizeConfig.screenWidth),
                          ContinueButton(
                              SizeConfig.screenHeight, SizeConfig.screenWidth)
                        ],
                      )

                      /* Text("Masjid Name"),
                        Text ("Location :")*/
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(left: parentWidth * 0.03),
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
                    color: CommonColor.GRAY_COLOR,
                    borderRadius: BorderRadius.circular(0)),

                /* child: ClipRRect(
                 borderRadius: BorderRadius.all(Radius.circular(20)),

                // borderRadius: BorderRadius.circular(8),
                child: const Image(
                    image: AssetImage("assets/images/frame_one.png"),
                    fit: BoxFit.cover,
                  ),
               ),*/
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAddFazarLayout(double parentHeight, double parentWidth) {
    return Padding(
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
                      "Jammat Time",
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
                Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.18),
                        child: Text("FAJR",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.BLACK_COLOR,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.0),
                        child: Text("ZUHAR",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.BLACK_COLOR,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.0),
                        child: Text("FAJR",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.BLACK_COLOR,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.0),
                        child: Text("FAJR",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.BLACK_COLOR,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: parentWidth * 0.0),
                        child: Text("FAJR",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.BLACK_COLOR,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: parentWidth * 0.08),
                        child: Text("FAJR",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Bold',
                              fontWeight: FontWeight.w500,
                              color: CommonColor.BLACK_COLOR,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.02),
                      child: Text("AZAN",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Bold',
                            fontWeight: FontWeight.w600,
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
                          right: parentWidth * 0.07, top: parentHeight * 0.02),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.03, top: parentHeight * 0.02),
                      child: Text("JAMAA’T",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Bold',
                            fontWeight: FontWeight.w600,
                            color: CommonColor.BLACK_COLOR,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.0, top: parentHeight * 0.02),
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
                          left: parentWidth * 0.0, top: parentHeight * 0.02),
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
                          left: parentWidth * 0.0, top: parentHeight * 0.02),
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
                          left: parentWidth * 0.0, top: parentHeight * 0.02),
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
                          left: parentWidth * 0.0, top: parentHeight * 0.02),
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
                          right: parentWidth * 0.07, top: parentHeight * 0.02),
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
                      child: Text("04:30",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Bold',
                            fontWeight: FontWeight.w600,
                            color: CommonColor.BLACK_COLOR,
                          )),
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
                      child: Text("07:10",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Bold',
                            fontWeight: FontWeight.w600,
                            color: CommonColor.BLACK_COLOR,
                          )),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getAddEidLayout(double parentHeight, double parentWidth) {
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentWidth * 0.1, top: parentHeight * 0.02),
                      child: Text("EID AL-FITR",
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
                      child: Text("Jamaat 08:30",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Bold',
                            fontWeight: FontWeight.w600,
                            color: CommonColor.BLACK_COLOR,
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: parentHeight * 0.05, top: parentHeight * 0.03),
                      child: Text("EID AL-ADHA",
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
                      child: Text("Jamaat 07:30",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Bold',
                            fontWeight: FontWeight.w600,
                            color: CommonColor.BLACK_COLOR,
                          )),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );//////
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParentTabBarScreen()));
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
                    color: CommonColor.WHITE_COLOR),
              ),
            )),
      ),
    );
  }
}
