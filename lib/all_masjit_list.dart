import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_list_responce_model.dart';
import 'package:masjiduserapp/parent_masjit_location_name.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/util/constant.dart';

import 'common.color.dart';

class AllMasjitList extends StatefulWidget {
  const AllMasjitList({Key? key, required this.onNext}) : super(key: key);
  final VoidCallback onNext;

  @override
  State<AllMasjitList> createState() => _AllMasjitListState();
}

class _AllMasjitListState extends State<AllMasjitList> {
  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    getAllListFuture = fetchPost();

  }
  var getAllListFuture;
  late Box box;

  @override
  void initState() {
    box = Hive.box(kBoxName);
    getAllListFuture = fetchPost();
    //getIncompletedData = getInCompleteOrderSection(widget.userId);
    print("masjid $getAllListFuture");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: SizeConfig.screenHeight,
        child: getAddTermsTextLayout(
            SizeConfig.screenHeight, SizeConfig.screenWidth,),
      ),
    );
  }

  Widget getAddTermsTextLayout(double parentHeight, double parentWidth, ) {
  //  print("hhhhh ${widget.masjitId}");
    return Stack(
      children: [
        FutureBuilder<AllMasjitListResponceModel>(
            future: getAllListFuture,
            builder: (context, snapshot) {
              return snapshot.data?.data?.length != null?
        ListView.builder(
                  itemCount: snapshot.data?.data?.length,
                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(top: parentHeight * 0.03),
                        child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             MasjitNameLocation(masjit: widget.masjitId)));
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
                                                              /*snapshot.data?.data?[index].images != null?*/
                                                              NetworkImage(
                                                                "${snapshot.data?.data?[index].images}",
                                                              ),/*: NetworkImage(""),*/
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
                                            Container(

                                              width: parentWidth*0.44,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: parentHeight * 0.02,top: parentWidth*0.03),
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
                                                            "${snapshot.data?.data?[index].place?[0].masjidName}",
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
                                                              "${snapshot.data?.data?[index].place?[0].subLocality}",
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



                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: parentWidth*0.05),
                                              child: Container(
                                                width: parentWidth*.23,
                                                height: parentWidth*.08,
                                               // color: Colors.yellow,
                                                child: GestureDetector(
                                                  onTap: () {

                                                    print("id ${snapshot.data?.data?[index].id}");

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MasjitNameLocation(masjitId: snapshot.data?.data?[index].id != null ?
                                                                "${snapshot.data?.data?[index].id}" : "",
                                                              lat: "${snapshot.data?.data?[index].place?[0].lat}",
                                                                  long: "${snapshot.data?.data?[index].place?[0].long}",)));
                                                  },


                                                  child: Container(
                                                    height:
                                                    parentHeight *
                                                        0.04,
                                                    width:
                                                    parentWidth *
                                                        0.3,
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
                                                          7),
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
                                                     )

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ]),
                                    ),
                                    Container(
                                      height: parentHeight*0.13,

                                      //  color: Colors.red,
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [

                                          Column(

                                            children: [


                                              Padding(
                                                padding: EdgeInsets.only(top: parentHeight*0.02,right: parentHeight*0.0),
                                                child: const Text("AZAN",
                                                  style: TextStyle(
                                                      color: Colors.transparent
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
                                                      padding:  EdgeInsets.only(left: parentWidth*0.03),
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
                                                padding: EdgeInsets.only(top: parentHeight*0.012, left: parentWidth*0.0),
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

                                          FutureBuilder<AllMasjitListResponceModel>(
                                              future: getAllListFuture,
                                              builder: (context, snapshot) {
                                                return
                                                  snapshot.data?.data?[index].weeklyNamaz?.length != null ?
                                                  Expanded(
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: snapshot.data?.data?[index].weeklyNamaz?.length,
                                                        scrollDirection: Axis.horizontal,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return  Column(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [


                                                              Padding(
                                                                padding: EdgeInsets.only(top: parentHeight*0.01,right: parentHeight*0.0),
                                                                child: Text("${snapshot.data?.data?[0].weeklyNamaz?[index].day}",
                                                                  style: TextStyle(
                                                                    fontSize: SizeConfig.blockSizeHorizontal*3.0,fontFamily: 'Roboto_Bold',
                                                                  ),),
                                                              ),




                                                              Padding(
                                                                padding: EdgeInsets.only(top: parentHeight*0.008,),
                                                                child: Container(
                                                                  width: parentWidth*0.145,
                                                                  height: parentHeight*0.031,
                                                                  decoration: const BoxDecoration(
                                                                    // color: Colors.blue,
                                                                      border: Border(bottom: BorderSide(width: 1,  color: CommonColor.SEARCH_COLOR))
                                                                  ),
                                                                  child:  Padding(
                                                                    padding: EdgeInsets.only(top: parentHeight*0.0,left: parentHeight*0.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text("${snapshot.data?.data?[0].weeklyNamaz?[index].azan}",
                                                                          style: TextStyle(
                                                                              fontSize: SizeConfig.blockSizeHorizontal*3.0
                                                                          ),),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              Padding(
                                                                padding: EdgeInsets.only(top: parentHeight*0.009,right: parentHeight*0.0),
                                                                child: Row(
                                                                  children: [
                                                                    Text("${snapshot.data?.data?[0].weeklyNamaz?[index].jammat}",
                                                                      style: TextStyle(
                                                                        fontSize: SizeConfig.blockSizeHorizontal*3.0,
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
                                ))));
                  })
              :Container();
            })
      ],
    );
  }

  Future<AllMasjitListResponceModel>fetchPost () async {
    print(" tokennn ${box.get(kToken)}");

    var headersList = {
      'Authorization': 'Bearer ${box.get(kToken)}'
    };

    // final msg = jsonEncode({
    //   "user_id": userId.toString(),
    // });



    var response = await http.get(
      Uri.parse('http://masjid.exportica.in/api/masjids/'),
    headers:headersList
    );



    if (response.statusCode == 200) {


      print("Yess.. ${response.body}");

      print("Hiii");

      return allMasjitListResponceModelFromJson(response.body);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}


