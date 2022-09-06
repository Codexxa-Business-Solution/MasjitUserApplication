import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_list_responce_model.dart';
import 'package:masjiduserapp/parent_masjit_location_name.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:http/http.dart' as http;

import 'common.color.dart';

class AllMasjitList extends StatefulWidget {
  const AllMasjitList({Key? key}) : super(key: key);

  @override
  State<AllMasjitList> createState() => _AllMasjitListState();
}

class _AllMasjitListState extends State<AllMasjitList> {
  var getAllListFuture;

  @override
  void initState() {
    getAllListFuture = fetchPost();
    print("masjid $getAllListFuture");
  }

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
    return Stack(
      children: [
        FutureBuilder<List<AllMasjitListResponceModel>>(
            future: getAllListFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    padding: const EdgeInsets.only(bottom: 20, top: 5),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.only(top: parentHeight * 0.03),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MasjitNameLocation()));
                              },
                              child: Container(
                                  height: parentHeight * 0.23,
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
                                      Container(
                                        height: parentHeight * 0.1,

                                        child: Column(children: [
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
                                                      padding: EdgeInsets.only(
                                                          left: parentWidth *
                                                              0.01),
                                                      child: Container(
                                                          height: parentHeight *
                                                              0.08,
                                                          width: parentWidth *
                                                              0.17,
                                                          decoration:
                                                          BoxDecoration(

                                                              image:
                                                              DecorationImage(
                                                                image:
                                                                NetworkImage(
                                                                    "${snapshot.data?[0].images?[0]}",
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10))),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: parentHeight * 0.02),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                            // right: parentWidth * 0.05,
                                                              top:
                                                              parentHeight *
                                                                  0.01),
                                                          child: Text(
                                                            "${snapshot.data![0].location?.place}",
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  4.3,
                                                              fontFamily:
                                                              'Roboto_Bold',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color: CommonColor
                                                                  .MASJIT_NAME,
                                                            ),
                                                            textAlign:
                                                            TextAlign.start,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                            top: parentHeight *
                                                                0.01,
                                                            left: parentWidth *
                                                                0.10,
                                                          ),
                                                          child: Container(
                                                              height:
                                                              parentHeight *
                                                                  0.04,
                                                              width:
                                                              parentHeight *
                                                                  0.12,
                                                              decoration:
                                                              BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .centerLeft,
                                                                    end: Alignment.centerRight,
                                                                    colors: [
                                                                      CommonColor
                                                                          .LEFT_COLOR,
                                                                      CommonColor
                                                                          .RIGHT_COLOR
                                                                    ]),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "JOIN",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      "Roboto_Regular",
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                      fontSize:
                                                                      SizeConfig.blockSizeHorizontal *
                                                                          4.3,
                                                                      color: CommonColor
                                                                          .WHITE_COLOR),
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
                                                              right:
                                                              parentHeight *
                                                                  0.02,
                                                              top:
                                                              parentHeight *
                                                                  0.0),
                                                          child: Text(
                                                              "Location :",
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    4.0,
                                                                fontFamily:
                                                                'Roboto_Bold',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                color: CommonColor
                                                                    .BLACK_COLOR,
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
                                          /*    Column(
                                                  //  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: parentHeight * 0.01),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: parentWidth *
                                                                    0.22),
                                                            child: Text(  "${snapshot.data![index].weeklyNamaz?[index].day}",
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
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: parentWidth *
                                                                    0.01),
                                                            child: Text("${snapshot.data![index].weeklyNamaz?[index].day}",
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
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: parentWidth *
                                                                    0.01),
                                                            child: Text("${snapshot.data![index].weeklyNamaz?[index].day}",
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
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: parentWidth *
                                                                    0.01),
                                                            child: Text("${snapshot.data![index].weeklyNamaz?[index].day}",
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
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                left: parentWidth *
                                                                    0.01),
                                                            child: Text("${snapshot.data![index].weeklyNamaz?[index].day}",
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
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                              right:
                                                                  parentWidth * 0.02,
                                                            ),
                                                            child: Text("${snapshot.data![index].weeklyNamaz?[index].day}",
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  parentWidth * 0.04,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("${snapshot.data![index].weeklyNamaz?[index].azan}",
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3.5,
                                                                fontFamily:
                                                                    'Roboto_Bold',
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                color: CommonColor
                                                                    .BLACK_COLOR,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  parentWidth * 0.05,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("05:00",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("01:00",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("05:00",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("06:30",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("08:30",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  parentWidth * 0.02,
                                                              top: parentHeight *
                                                                  0.02),
                                                          child: Text("01:30",
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
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: parentHeight * 0.01,
                                                          left: parentWidth * .02,
                                                          right: parentWidth * 0.02),
                                                      child: Container(
                                                        color:
                                                            CommonColor.SEARCH_COLOR,
                                                        height: parentHeight * 0.001,
                                                        width: parentWidth,
                                                        child: Text(
                                                          "hi",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.transparent),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  parentWidth * 0.05,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("${snapshot.data![index].weeklyNamaz?[index].jammt}",
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3.5,
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
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("05:30",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("01:30",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("05:30",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("06:35",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left: parentWidth * 0.0,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("08:85",
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
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                                  parentWidth * 0.02,
                                                              top: parentHeight *
                                                                  0.01),
                                                          child: Text("01:45",
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
                                                      ],
                                                    )
                                                  ],
                                                )*/

                                          /* ListView.builder(
                                itemCount: snapshot.data.toString().length,
                                padding:
                                const EdgeInsets.only(bottom: 20, top: 5),
                                itemBuilder: (context, index) {
                                return Row(
                                children: [
                                  Column(
                                    children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  parentWidth * 0.04,
                                                  top: parentHeight *
                                                      0.02),
                                              child: Text("${snapshot.data![index].weeklyNamaz?[index].azan}",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.5,
                                                    fontFamily:
                                                    'Roboto_Bold',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: CommonColor
                                                        .BLACK_COLOR,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  parentWidth * 0.04,
                                                  top: parentHeight *
                                                      0.02),
                                              child: Text("${snapshot.data![index].weeklyNamaz?[index].azan}",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.5,
                                                    fontFamily:
                                                    'Roboto_Bold',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: CommonColor
                                                        .BLACK_COLOR,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  parentWidth * 0.04,
                                                  top: parentHeight *
                                                      0.02),
                                              child: Text("${snapshot.data![index].weeklyNamaz?[index].azan}",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.5,
                                                    fontFamily:
                                                    'Roboto_Bold',
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color: CommonColor
                                                        .BLACK_COLOR,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: parentHeight * 0.01,
                                                  left: parentWidth * .02,
                                                  right: parentWidth * 0.02),
                                              child: Container(
                                                color:
                                                CommonColor.SEARCH_COLOR,
                                                height: parentHeight * 0.001,
                                                width: parentWidth,
                                                child: Text(
                                                  "hi",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.transparent),
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                ],
                                );
                                    }
                                  ),*/
                                        ]),
                                      ),
                                      Container(
                                        height: parentHeight * 0.13,

                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: parentWidth * 0.04,
                                                      top:
                                                      parentHeight * 0.025),
                                                  child: Text("Azan",
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            3.5,
                                                        fontFamily:
                                                        'Roboto_Bold',
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color:
                                                        Colors.transparent,
                                                      )),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: parentWidth * 0.0,
                                                      top: parentHeight * 0.0),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: parentHeight *
                                                            0.028,
                                                        decoration:
                                                        BoxDecoration(
                                                          // color: Colors.red,
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: parentHeight *
                                                                        0.001))),
                                                        width:
                                                        parentWidth * 0.185,
                                                        child: Text("AZAN",
                                                            style: TextStyle(
                                                              fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  3.5,
                                                              fontFamily:
                                                              'Roboto_Bold',
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              color: CommonColor
                                                                  .BLACK_COLOR,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: parentWidth * 0.0,
                                                      top: parentHeight * 0.0),
                                                  child: Text("JAMAA'T",
                                                      style: TextStyle(
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            3.5,
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
                                            Container(

                                              height: parentHeight * 0.4,
                                              width: parentWidth * 0.73,
                                              child: ListView.builder(
                                                itemCount: 6,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: parentWidth *
                                                            0.019),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                              parentWidth *
                                                                  0.0,
                                                              top:
                                                              parentHeight *
                                                                  0.02),
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                EdgeInsets
                                                                    .only(
                                                                  right:
                                                                  parentWidth *
                                                                      0.02,
                                                                ),
                                                                child: Text(
                                                                    "${snapshot.data![index].weeklyNamaz?[index].day}",
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      SizeConfig.blockSizeHorizontal *
                                                                          2.8,
                                                                      fontFamily:
                                                                      'Roboto_Bold',
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: CommonColor
                                                                          .BLACK_COLOR,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                              parentWidth *
                                                                  0.0,
                                                              top:
                                                              parentHeight *
                                                                  0.01),
                                                          child: Container(
                                                            child: Text("08:85",
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  SizeConfig
                                                                      .blockSizeHorizontal *
                                                                      3.3,
                                                                  fontFamily:
                                                                  'Roboto_Regular',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color: CommonColor
                                                                      .BLACK_COLOR,
                                                                )),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                              parentWidth *
                                                                  0.0,
                                                              top:
                                                              parentHeight *
                                                                  0.01),
                                                          child: Text("08:85",
                                                              style: TextStyle(
                                                                fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    3.3,
                                                                fontFamily:
                                                                'Roboto_Regular',
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                                color: CommonColor
                                                                    .BLACK_COLOR,
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
                                      ),
                                    ],
                                  ))));
                    });
                /* ));*/
              }
              return CircularProgressIndicator();
            })
      ],
    );
  }
}
/*  Future<AllMasjitListResponceModel> getAllMasjidList(userId) async {
    print("userId $userId");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final msg = jsonEncode({"id": 1});
    var response = await http.post(
      Uri.parse('http://sangh.bizz-manager.com/'),
      headers: headers,
      body: msg,
    );
    if (response.statusCode == 200) {
      print("Yess.. ${response.body}");
      return getAllMasjidFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }*/

/*Future<AllMasjitListResponceModel> getAllMasjidList(userId) async {
    try {
      final result =
      await http.post(Uri.parse("http://sangh.bizz-manager.com/"), body: {
        "id": 1,
      });
      print("statusCode ${result.statusCode}");
      if (result.statusCode == 200) {
        print("Yess.. ${result.body}");
        print("Hiii");
      }
      return getPostOrderFromJson(result.body);
    } catch (e) {
      throw e;
    }
  }*/
Future<List<AllMasjitListResponceModel>> fetchPost() async {
  final response = await http.get(Uri.parse('http://sangh.bizz-manager.com/'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<AllMasjitListResponceModel>(
            (json) => AllMasjitListResponceModel.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}