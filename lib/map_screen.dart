import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:masjiduserapp/all_masjit_list.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/notice_response_model.dart';
import 'package:masjiduserapp/notice_user_tab.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/trustee_user_tab.dart';
import 'package:masjiduserapp/user_map_tab.dart';
class MasjitMappScreen extends StatefulWidget {

  final String tabNum;

  const MasjitMappScreen({
    Key? key,
    required this.tabNum,

  }) : super(key: key);



  @override
  State<MasjitMappScreen> createState() => _MasjitMappScreenState();
}

class _MasjitMappScreenState extends State<MasjitMappScreen> with SingleTickerProviderStateMixin {
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
   // getNotice = getNoticeSection();
    print(getNotice);
    if (mounted)
      setState(() {
        showDetails = true;
        widget.tabNum == "1" ?
        mapScreen = true: widget.tabNum == "2" ?
        trusteeScreen = true:noticeScreen=true;
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.white,
        body:  ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.07,
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

                      child: ThreeTabWithDesign(SizeConfig.screenHeight,
                          SizeConfig.screenWidth),
                    ),
    Container(
      height: SizeConfig.screenHeight*0.99,

      child: Container(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * .02),
        height: SizeConfig.screenHeight,
        child: showScreenLayout(
            SizeConfig.screenHeight, SizeConfig.screenWidth),
      ),)


          ],
        ),






    );
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
              padding: EdgeInsets.only(top: parentHeight * 0.01),
              child: Icon(
                Icons.arrow_back_ios,
                size: parentHeight * .03,
                color: CommonColor.WHITE_COLOR,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
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
          padding: EdgeInsets.only(right: parentWidth * .01),
          child: Icon(
            Icons.arrow_back_ios,
            size: parentHeight * .03,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
  Widget ThreeTabWithDesign(double parentHeight, double parentWidth) {
    return Container(
      child: FutureBuilder<NoticeResponceModel>(
          future: getNotice,
          builder: (context, snapshot) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: parentHeight * 0.02),
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
                                    ? CommonColor.REGISTRARTION_TRUSTEE
                                    .withOpacity(0.9)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: CommonColor.RIGHT_COLOR, width: 1)),
                            child: Center(
                              child: Text(
                                "Map",
                                style: TextStyle(
                                  color: mapScreen == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  SizeConfig.blockSizeHorizontal * 3.5,
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
                                    ? CommonColor.REGISTRARTION_TRUSTEE
                                    .withOpacity(0.9)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: CommonColor.RIGHT_COLOR, width: 1)),
                            child: Center(
                              child: Text(
                                "Trustee",
                                style: TextStyle(
                                  color: trusteeScreen
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  SizeConfig.blockSizeHorizontal * 3.5,
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
                                    ? CommonColor.REGISTRARTION_TRUSTEE
                                    .withOpacity(0.9)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: CommonColor.RIGHT_COLOR, width: 1)),
                            child: Center(
                              child: Text(
                                "Notice",
                                style: TextStyle(
                                  color: noticeScreen == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                  SizeConfig.blockSizeHorizontal * 3.5,
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

      ],
    );
  }
}