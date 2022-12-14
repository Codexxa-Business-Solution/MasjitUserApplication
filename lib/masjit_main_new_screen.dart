/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/banners.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/map_screen.dart';

import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:masjiduserapp/util/removed_masjit_dilog_box.dart';

import 'masjit_user_app_api/masjit_app_responce_model/join_masjit_api_responce_model.dart';

late Box box;

class MasjitMainScreen extends StatefulWidget {
  const MasjitMainScreen({
    Key? key,
    required this.tabbr,
    required this.masjitIdRemoved,
    required this.onNext,
  }) : super(key: key);
  final VoidCallback onNext;
  final String tabbr;
  final String masjitIdRemoved;

  @override
  State<MasjitMainScreen> createState() => _MasjitMainScreenState();
}

class _MasjitMainScreenState extends State<MasjitMainScreen>
    with SingleTickerProviderStateMixin, EndFriendDialogInterface {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
    box = Hive.box(kBoxName);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  callUnFriendApi(String userId, String isConverted, int index, String msgId) {
    // TODO: implement callUnFriendApi
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
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
        child: FutureBuilder<AllMasjitJoinListResponceModel>(
            future: getNoticeSection(),
            builder: (context, snap) {
              if (!snap.hasData && !snap.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final data = snap.data?.data;

              if (data == null) {
                return const Center(
                  child: Text('Error'),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    child: const Banners(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return JoinedMasjidCard(masjid: data[index], index: index,);
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

*/
/* Widget getAddEidLayout() {
    return
  }
 */ /*

}

Future<AllMasjitJoinListResponceModel> getNoticeSection() async {
  final Box box = Hive.box(kBoxName);
  var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

  var response = await http.get(
      Uri.parse('http://masjid.exportica.in/api/user/joined'),
      headers: headersList);

  if (response.statusCode == 200) {
    log(response.body);

    return allMasjitJoinListResponceModelFromJson(response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

class JoinedMasjidCard extends StatefulWidget {
  const JoinedMasjidCard({Key? key, required this.masjid, required this.index}) : super(key: key);
  final Datum masjid;
  final int index;

  @override
  State<JoinedMasjidCard> createState() => _JoinedMasjidCardState();
}

class _JoinedMasjidCardState extends State<JoinedMasjidCard>
    with EndFriendDialogInterface {
  bool isImageVisible = false;
  bool isJummaVisible = false;
  bool isEidVisible = false;
  bool isSharVisible = false;
  int currentIndex = 0;
  String masjidId = "";

  @override
  void initState() {
    super.initState();
    box = Hive.box(kBoxName);
    masjidId = widget.masjid.id.toString();
    // NotificationService().scheduleNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
           */
/* Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              child: Container(
                padding:  EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.4,),
                  decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                      Colors.pink, Colors.red, Colors.orange
                       */ /*

            */
/* CommonColor.LEFT_GREDIENT_COLOR,
                        CommonColor.RIGHT_GREDIENT_COLOR*/ /*

            */
/*
                      ]),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text("Primary"),
              */ /*

            */
/*  child: GradientText(
                  'Primary',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  gradientType: GradientType.radial,
                  radius: 2.5,
                  colors: [
                    Colors.pink, Colors.red, Colors.orange
                  ],
                ),*/ /*
*/
/*
              ),
            ),*/ /*


          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 35,
                width: 100,
                child: CircularButton(
                  label: 'Map',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MasjitMappScreen(
                          tabNum: "1",
                          masjitTrusteeId: '${widget.masjid.id}',
                          lat: "${widget.masjid.place?[0].lat}",
                          long: "${widget.masjid.place?[0].long}",
                          masjitNoticeId: '${widget.masjid.id}',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 35,
                width: 100,
                child: CircularButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MasjitMappScreen(
                          tabNum: "2",
                          masjitTrusteeId: '${widget.masjid.id}',
                          lat: "${widget.masjid.place?[0].lat}",
                          long: "${widget.masjid.place?[0].long}",
                          masjitNoticeId: '${widget.masjid.id}',
                        ),
                      ),
                    );
                  },
                  label: "Trustee",
                ),
              ),

              Container(
                height: 35,
                width: 100,
                child: CircularButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MasjitMappScreen(
                          tabNum: "3",
                          masjitTrusteeId: '${widget.masjid.id}',
                          lat: "${widget.masjid.place?[0].lat}",
                          long: "${widget.masjid.place?[0].long}",
                          masjitNoticeId: '${widget.masjid.id}',
                        ),
                      ),
                    );
                  },
                  label: "Notice",
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Row(
            //  mainAxisAlignment: MainAxisAlignment.spaceB,
            children: [
              Image.asset(
                'assets/images/masjit_logo.png',
                width: 35,
                height: 35,
              ),
              SizedBox(
                width: 80,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      '${widget.masjid.place?[0].masjidName}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.12,
                ),
                child: SizedBox(
                  width: 37,
                  child: Text('${widget.masjid.place?[0].subLocality}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      )),
                ),
              ),

              */
/*widget.index==0? SizedBox(
                width: 67,
                height: 45,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.02,

                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.pink, Colors.red, Colors.orange
                          ]),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      "Primary",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: CommonColor.WHITE_COLOR,
                      ),
                    ),
                  ),
                ),
              )
                  : SizedBox(  width: 67,
                height: 45),*/ /*

            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.02,

                ),
                  child: Container(
                    width: 67,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width:1,color:CommonColor.REGISTRARTION_COLOR)
                    ),
                    child:Center(
                      child: Padding(
                        padding:  EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.02),
                        child: Text("Make   Primary",
                            style: const TextStyle(
                              fontSize: 10,
                            )),
                      ),
                    )
                ),
              ),
              GestureDetector(
                onTap: () {
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.8),
                      transitionBuilder: (context, a1, a2, widget) {
                        final curvedValue =
                            Curves.easeInOutBack.transform(a1.value) - 1.0;

                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: EndFriendDialog(
                              mListener: this,
                              masjitRemoveIdd: masjidId,
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      // ignore: missing_return
                      pageBuilder: (context, animation2, animation1) {
                        return Container();
                      });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,

                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: CommonColor.WHITE_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Masjid Image",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,

                  fontWeight: FontWeight.w700,

                  fontSize: 15,
                  color: CommonColor.BLACK_COLOR,
                  //  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTapDown: (tab) {
                  setState(() {
                    isImageVisible = !isImageVisible;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    "View",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                      color: CommonColor.BLACK_COLOR,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: isImageVisible,
              child: SizedBox(
                  //height: SizeConfig.screenHeight*.74,
                  width: SizeConfig.screenWidth,
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.screenHeight * .0,
                          top: SizeConfig.screenHeight * .0),
                      child: CarouselSlider.builder(
                          // carouselController: _controller,
                          itemCount: widget.masjid.images?.length ?? 0,
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                isJummaVisible = !isJummaVisible;
                              });
                            },
                            initialPage: 1,
                            height: SizeConfig.screenHeight * .27,
                            // aspectRatio: 1.1,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int index1) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.03,
                                  right:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .23,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .94,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: widget.masjid.images != null
                                              ? NetworkImage(
                                                  "http://masjid.exportica.in/${widget.masjid.images?[index1]}",
                                                )
                                              : const NetworkImage(""),
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))),
            ),
            Visibility(
              visible: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < (widget.masjid.images?.length ?? 0); i++)
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
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
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  "JAMMAT TIME",
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.0,
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
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.027,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.0),
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
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.0),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.024,
                                        decoration: const BoxDecoration(
                                          // color: Colors.blue,
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color:
                                                    CommonColor.SEARCH_COLOR),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.0),
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
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.masjid.weeklyNamaz?.length,
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index1) {
                                      // box.delete("weeklytimes");
                                      // box.put(kWeeklyTimes, jsonEncode(widget.masjid
                                      //     .weeklyNamaz));
                                      // print(" mainScreen ${box.get(kWeeklyTimes)}");

                                      final file = File(
                                          '/data/data/com.azanforsalah.user/app_flutter/time.json');
                                      if (!file.existsSync())
                                        file.create(recursive: true);

                                      file.writeAsString(jsonEncode(
                                          widget.masjid.weeklyNamaz));

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.006),
                                            child: Text(
                                              "${widget.masjid.weeklyNamaz?[index1].day}",
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
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.145,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.031,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: CommonColor
                                                          .SEARCH_COLOR),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.006),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${widget.masjid.weeklyNamaz?[index1].azan}",
                                                      style: TextStyle(
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              2.7),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${widget.masjid.weeklyNamaz?[index1].jammat}",
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2.7),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              )
                              */
/*   : Container();
                                                  })*/ /*

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
                      isJummaVisible = !isJummaVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.0,
                        right: MediaQuery.of(context).size.width * 0.0),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.33),
                                  child: Text(
                                    "JUMMA TIME",
                                    style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        color: CommonColor.WHITE_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Image.asset(
                                    'assets/images/up_arrow.png',
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                            visible: isJummaVisible,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Row(
                                          children: const [
                                            Text(
                                              "JAMAAT",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      CommonColor.BLACK_COLOR,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: SizedBox(
                                            // color: Colors.red,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.11,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: widget.masjid.jumma
                                                    ?.jammat?.length,
                                                itemBuilder: (context, index1) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${widget.masjid.jumma?.jammat?[index1]}",
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
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (tab) {
                    setState(() {
                      isSharVisible = !isSharVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.0,
                        right: MediaQuery.of(context).size.width * 0.0),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.33),
                                  child: Text(
                                    "SAHAR / IFTAR",
                                    style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        color: CommonColor.WHITE_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Image.asset(
                                    'assets/images/up_arrow.png',
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                          visible: isSharVisible,
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0),
                                          child: Text("SAHAR",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.3,
                                                fontFamily: 'Roboto_Bold',
                                                fontWeight: FontWeight.w600,
                                                color: CommonColor.BLACK_COLOR,
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0),
                                          child: widget.masjid.sahr != null
                                              ? Text("${widget.masjid.sahr}",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.3,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        CommonColor.BLACK_COLOR,
                                                  ))
                                              : Text("5:30 AM",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.3,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        CommonColor.BLACK_COLOR,
                                                  )),
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
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        child: Text("IFTAR",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        child: widget.masjid.iftar != null
                                            ? Text("${widget.masjid.iftar}",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      CommonColor.BLACK_COLOR,
                                                ))
                                            : Text("5:30 AM",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      CommonColor.BLACK_COLOR,
                                                )),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (tab) {
                    setState(() {
                      isEidVisible = !isEidVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.0,
                        right: MediaQuery.of(context).size.width * 0.0),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.43),
                                  child: Text(
                                    "EID",
                                    style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        color: CommonColor.WHITE_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Image.asset(
                                    'assets/images/up_arrow.png',
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                          visible: isEidVisible,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.0),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          // physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget.masjid.eid?.length,
                                          // physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01),
                                                        child: Text(
                                                            "${widget.masjid.eid?[index].name}",
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
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01),
                                                        child: Row(
                                                          children: [
                                                            Text("Jammat",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      SizeConfig
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
                                                                        (widget.masjid.eid?[index].jammat?.length ??
                                                                            0);
                                                                    i++)
                                                                  Text(
                                                                    " ${widget.masjid.eid?[index].jammat?[i]}",
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
                                                                    ),
                                                                  ),
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
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Divider(
            thickness: 1,
            color: Colors.green,
          ),
        )
      ],
    );
  }

  @override
  callUnFriendApi(String userId, String isConverted, int index, String msgId) {}
}

class CircularButton extends StatelessWidget {
  const CircularButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: CommonColor.RIGHT_COLOR, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Roboto_Medium',
            ),
          ),
        ),
      ),
    );
  }
}
*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/banners.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/map_screen.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/showNotificationApi.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:masjiduserapp/util/removed_masjit_dilog_box.dart';

import 'masjit_user_app_api/masjit_app_responce_model/join_masjit_api_responce_model.dart';
import 'masjit_user_app_api/masjit_app_responce_model/make_primary.dart';

late Box box;

class MasjitMainScreen extends StatefulWidget {
  const MasjitMainScreen({
    Key? key,
    required this.tabbr,
    required this.masjitIdRemoved,
    required this.onNext,
  }) : super(key: key);
  final VoidCallback onNext;
  final String tabbr;
  final String masjitIdRemoved;

  @override
  State<MasjitMainScreen> createState() => _MasjitMainScreenState();
}

class _MasjitMainScreenState extends State<MasjitMainScreen>
    with SingleTickerProviderStateMixin, EndFriendDialogInterface {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
    box = Hive.box(kBoxName);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  callUnFriendApi(String userId, String isConverted, int index, String msgId) {
    // TODO: implement callUnFriendApi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
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
        child: FutureBuilder<AllMasjitJoinListResponceModel>(
            future: getNoticeSection(),
            builder: (context, snap) {
              if (!snap.hasData && !snap.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final data = snap.data?.data;

              if (data == null) {
                return const Center(
                  child: Text('Error'),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    child: const Banners(),
                  ),
                  Expanded(
                    child: snap.data?.data?.isNotEmpty ?? false
                        ? ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              /* confirmRemove() {
                          showGeneralDialog(
                              barrierColor: Colors.black.withOpacity(0.8),
                              transitionBuilder: (context, a1, a2, widget) {
                                final curvedValue =
                                    Curves.easeInOutBack.transform(a1.value) -
                                        1.0;

                                return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                    opacity: a1.value,
                                    child: EndFriendDialog(
                                      index: index,
                                      mListener: this,
                                      masjitRemoveIdd: "${masjid.id}",
                                      joinedMasjid: _allCommentsArr,
                                    ),
                                  ),
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              // ignore: missing_return
                              pageBuilder: (context, animation2, animation1) {
                                return Container();
                              });
                        } */

                              return JoinedMasjidCard(masjid: data[index]);
                            },
                          )
                        : GestureDetector(
                            onTap: () {
                              widget.onNext();
                            },
                            child: Center(
                              child: Container(
                                  height: 50,
                                  width: 110,
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
                                              SizeConfig.blockSizeHorizontal *
                                                  4.3,
                                          color: CommonColor.WHITE_COLOR),
                                    ),
                                  )),
                            ),
                          ),
                  ),
                ],
              );
            }),
      ),
    );
  }

/* Widget getAddEidLayout() {
    return
  }
 */
}

Future<AllMasjitJoinListResponceModel> getNoticeSection() async {
  final Box box = Hive.box(kBoxName);
  var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

  var response = await http.get(
      Uri.parse('http://admin.azan4salah.com/api/user/joined'),
      headers: headersList);

  if (response.statusCode == 200) {
    log(response.body);

    return allMasjitJoinListResponceModelFromJson(response.body);
  } else {
    throw Exception('Failed to create album.');
  }
}

class JoinedMasjidCard extends StatefulWidget {
  const JoinedMasjidCard({Key? key, required this.masjid}) : super(key: key);
  final Datum masjid;

  @override
  State<JoinedMasjidCard> createState() => _JoinedMasjidCardState();
}

class _JoinedMasjidCardState extends State<JoinedMasjidCard>
    with EndFriendDialogInterface {
  bool isImageVisible = false;
  bool isJummaVisible = false;
  bool isEidVisible = false;
  bool isSharVisible = false;
  int currentIndex = 0;
  String masjidId = "";

  @override
  void initState() {
    super.initState();
    box = Hive.box(kBoxName);
    masjidId = widget.masjid.id.toString();
    // NotificationService().scheduleNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 35,
                width: 100,
                child: CircularButton(
                  label: 'Map',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MasjitMappScreen(
                          tabNum: "1",
                          masjitTrusteeId: '${widget.masjid.id}',
                          lat: "${widget.masjid.place?[0].lat}",
                          long: "${widget.masjid.place?[0].long}",
                          masjitNoticeId: '${widget.masjid.id}',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 35,
                width: 100,
                child: CircularButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MasjitMappScreen(
                          tabNum: "2",
                          masjitTrusteeId: '${widget.masjid.id}',
                          lat: "${widget.masjid.place?[0].lat}",
                          long: "${widget.masjid.place?[0].long}",
                          masjitNoticeId: '${widget.masjid.id}',
                        ),
                      ),
                    );
                  },
                  label: "Trustee",
                ),
              ),
              Container(
                height: 35,
                width: 100,
                child: CircularButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MasjitMappScreen(
                          tabNum: "3",
                          masjitTrusteeId: '${widget.masjid.id}',
                          lat: "${widget.masjid.place?[0].lat}",
                          long: "${widget.masjid.place?[0].long}",
                          masjitNoticeId: '${widget.masjid.id}',
                        ),
                      ),
                    );
                  },
                  label: "Notice",
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01,),
                child: Image.asset(
                  'assets/images/masjit_logo.png',
                  width: 35,
                  height: 35,
                ),
              ),
              Container(
                width: 159,
                // color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth*0.5,
                        // color: Colors.red,
                        child: Text(
                          '${widget.masjid.place?[0].masjidName}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth*0.6,
                        child:
                        Text('${widget.masjid.place?[0].subLocality}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            )),
                      ),
                    ],
                  ),
                ),
              ),

              widget.masjid.isPrimary == true
                  ? SizedBox(
                    width: 67,
                    height: 47,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.pink,
                                Colors.red,
                                Colors.orange
                              ]),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Text(
                          "Primary",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: CommonColor.WHITE_COLOR,
                          ),
                        ),
                      ),
                    ),
                  )
                  : Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Center(
                              child: Text(
                                "Make Primary",
                                style: TextStyle(
                                  color: CommonColor.REGISTRARTION_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: 'Roboto_Medium',
                                ),
                              )),
                          content: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.04),
                            child: const Text(
                              "Do you want to make this Masjid Primary?",
                              style: TextStyle(
                                color: CommonColor.BLACK,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Roboto_Medium',
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                  SizeConfig.screenHeight * 0.03),
                              child: Center(
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        /* getLogoutUser().then((value) {
                                                box.delete(kToken);
                                                //box.delete(kBoxName);
                                                box.delete(kUserPhoneNumber);

                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        const LoginScreen()),
                                                        (Route route) =>
                                                    false);

                                                //  Navigator.popUntil(context, ModalRoute.withName (EnterMobileNumber()));
                                                */ /*   Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EnterMobileNumber()));*/ /*
                                              });*/
                                        //cityController.text.isEmpty ? _validate = true : _validate = false;
                                        makePrimaryApi(
                                            "${widget.masjid.id}");
                                        /* final file = File(
                                                  '/data/data/com.azanforsalah.user/app_flutter/time.json');
                                              if (!file.existsSync())
                                                file.create(recursive: true);

                                              file.writeAsString(jsonEncode(
                                                  widget.masjid.weeklyNamaz));*/

                                        print(
                                            "new ${widget.masjid.weeklyNamaz}");
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: SizeConfig
                                                .screenWidth *
                                                0.1,
                                            right: SizeConfig
                                                .screenWidth *
                                                0.1),
                                        child: Container(
                                            height: SizeConfig
                                                .screenHeight *
                                                0.05,
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
                                                  .circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    fontFamily:
                                                    "Roboto_Regular",
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        4.5,
                                                    color: CommonColor
                                                        .WHITE_COLOR),
                                              ),
                                            )),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: SizeConfig
                                                .screenHeight *
                                                0.03),
                                        child: GestureDetector(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: SizeConfig
                                                    .screenHeight *
                                                    0.0,
                                                left: SizeConfig
                                                    .screenWidth *
                                                    0.1,
                                                right: SizeConfig
                                                    .screenWidth *
                                                    0.1),
                                            child: Container(
                                                height: SizeConfig
                                                    .screenHeight *
                                                    0.05,
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
                                                      .circular(
                                                      30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontFamily:
                                                        "Roboto_Regular",
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize:
                                                        SizeConfig
                                                            .blockSizeHorizontal *
                                                            4.5,
                                                        color: CommonColor
                                                            .WHITE_COLOR),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ));
                  },
                  child: Container(
                      width: 62,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1,
                              color: CommonColor.REGISTRARTION_COLOR)),
                      child: Center(
                        child: Text("Make Primary",
                            style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold)),
                      )),
                ),
              ),

              GestureDetector(
                onTap: () {
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.8),
                      transitionBuilder: (context, a1, a2, widget) {
                        final curvedValue =
                            Curves.easeInOutBack.transform(a1.value) - 1.0;
                        // return Transform(
                        //   transform: Matrix4.translationValues(
                        //       0.0, curvedValue * 200, 0.0),
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: EndFriendDialog(
                              mListener: this,
                              masjitRemoveIdd: masjidId,
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      // ignore: missing_return
                      pageBuilder: (context, animation2, animation1) {
                        return Container();
                      });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: 10
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                    child: const Text(
                      "Remove",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: CommonColor.WHITE_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Masjid Image",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,

                  fontWeight: FontWeight.w700,

                  fontSize: 16,
                  color: CommonColor.BLACK_COLOR,
                  //  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTapDown: (tab) {
                  setState(() {
                    isImageVisible = !isImageVisible;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05),
                  child: Text(
                    "View",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      color: CommonColor.BLACK_COLOR,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: isImageVisible,
              child: SizedBox(
                  //height: SizeConfig.screenHeight*.74,
                  width: SizeConfig.screenWidth,
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.screenHeight * .0,
                          top: SizeConfig.screenHeight * .0),
                      child: CarouselSlider.builder(
                          // carouselController: _controller,
                          itemCount: widget.masjid.images?.length ?? 0,
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                isJummaVisible = !isJummaVisible;
                              });
                            },
                            initialPage: 1,
                            height: SizeConfig.screenHeight * .27,
                            // aspectRatio: 1.1,
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          itemBuilder: (BuildContext context, int itemIndex,
                              int index1) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.03,
                                  right:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .23,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .94,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: widget.masjid.images != null
                                              ? NetworkImage(
                                                  "http://admin.azan4salah.com/${widget.masjid.images?[index1]}",
                                                )
                                              : const NetworkImage(""),
                                          fit: BoxFit.cover,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }))),
            ),
            Visibility(
              visible: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < (widget.masjid.images?.length ?? 0); i++)
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
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
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  "JAMMAT TIME",
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.0,
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
                          height: MediaQuery.of(context).size.height * 0.13,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.027,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.0),
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
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.0),
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.024,
                                        decoration: const BoxDecoration(
                                          // color: Colors.blue,
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color:
                                                    CommonColor.SEARCH_COLOR),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02),
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.0),
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
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // NotificationService.scheduleNotifications();
                                  },
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          widget.masjid.weeklyNamaz?.length,
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index1) {
                                        final file = File(
                                            '/data/data/com.azanforsalah.user/app_flutter/time.json');
                                        if (!file.existsSync())
                                          file.create(recursive: true);

                                        if (widget.masjid.isPrimary == true) {
                                          NotificationService
                                              .scheduleNotifications();
                                          file.writeAsString(jsonEncode(
                                              widget.masjid.weeklyNamaz));
                                        }

                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.006),
                                              child: Text(
                                                "${widget.masjid.weeklyNamaz?[index1].day}",
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
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.145,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.031,
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: CommonColor
                                                            .SEARCH_COLOR),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.006),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${widget.masjid.weeklyNamaz?[index1].azan}",
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                2.7),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.00),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${widget.masjid.weeklyNamaz?[index1].jammat}",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            2.7),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
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
                      isJummaVisible = !isJummaVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.0,
                        right: MediaQuery.of(context).size.width * 0.0),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.33),
                                  child: Text(
                                    "JUMMA TIME",
                                    style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        color: CommonColor.WHITE_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Image.asset(
                                    'assets/images/up_arrow.png',
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                            visible: isJummaVisible,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03),
                                        child: Row(
                                          children: const [
                                            Text(
                                              "JAMAAT",
                                              style: TextStyle(
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      CommonColor.BLACK_COLOR,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: SizedBox(
                                            // color: Colors.red,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.11,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: widget.masjid.jumma
                                                    ?.jammat?.length,
                                                itemBuilder: (context, index1) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.015,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${widget.masjid.jumma?.jammat?[index1]}",
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
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (tab) {
                    setState(() {
                      isSharVisible = !isSharVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.0,
                        right: MediaQuery.of(context).size.width * 0.0),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.33),
                                  child: Text(
                                    "SAHAR / IFTAR",
                                    style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        color: CommonColor.WHITE_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Image.asset(
                                    'assets/images/up_arrow.png',
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                          visible: isSharVisible,
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0),
                                          child: Text("SAHAR",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4.3,
                                                fontFamily: 'Roboto_Bold',
                                                fontWeight: FontWeight.w600,
                                                color: CommonColor.BLACK_COLOR,
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0),
                                          child: widget.masjid.sahr != null
                                              ? Text("${widget.masjid.sahr}",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.3,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        CommonColor.BLACK_COLOR,
                                                  ))
                                              : Text("5:30 AM",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.3,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        CommonColor.BLACK_COLOR,
                                                  )),
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
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        child: Text("IFTAR",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.3,
                                              fontFamily: 'Roboto_Bold',
                                              fontWeight: FontWeight.w600,
                                              color: CommonColor.BLACK_COLOR,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        child: widget.masjid.iftar != null
                                            ? Text("${widget.masjid.iftar}",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      CommonColor.BLACK_COLOR,
                                                ))
                                            : Text("5:30 AM",
                                                style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      4.3,
                                                  fontFamily: 'Roboto_Bold',
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      CommonColor.BLACK_COLOR,
                                                )),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (tab) {
                    setState(() {
                      isEidVisible = !isEidVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.0,
                        right: MediaQuery.of(context).size.width * 0.0),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.43),
                                  child: Text(
                                    "EID",
                                    style: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        color: CommonColor.WHITE_COLOR),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.05),
                                  child: Image.asset(
                                    'assets/images/up_arrow.png',
                                  ),
                                ),
                              ],
                            )),
                        Visibility(
                          visible: isEidVisible,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.0),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          // physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget.masjid.eid?.length,
                                          // physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01),
                                                        child: Text(
                                                            "${widget.masjid.eid?[index].name}",
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
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.01),
                                                        child: Row(
                                                          children: [
                                                            Text("Jammat",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      SizeConfig
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
                                                                        (widget.masjid.eid?[index].jammat?.length ??
                                                                            0);
                                                                    i++)
                                                                  Text(
                                                                    " ${widget.masjid.eid?[index].jammat?[i]}",
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
                                                                    ),
                                                                  ),
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
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Divider(
            thickness: 1,
            color: Colors.green,
          ),
        )
      ],
    );
  }

  @override
  callUnFriendApi(String userId, String isConverted, int index, String msgId) {}

  Future<MakePrimaryResponseModel> makePrimaryApi(String priamryId) async {
    final Box box = Hive.box(kBoxName);
    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse('http://admin.azan4salah.com/api/user/primary/$priamryId'),
        headers: headersList);

    if (response.statusCode == 200) {
      log(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParentTabBarScreen(),
          ));

      return makePrimaryFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: CommonColor.RIGHT_COLOR, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Roboto_Medium',
            ),
          ),
        ),
      ),
    );
  }
}
