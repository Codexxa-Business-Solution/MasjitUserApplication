import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_list_responce_model.dart';
import 'package:masjiduserapp/parent_masjit_location_name.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/size_config.dart';

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
    SizeConfig().init(context);
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
        FutureBuilder<AllMasjitListResponceModel>(
            future: getAllListFuture,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data?.data?.length,
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
                                                              snapshot.data?.data?[index].images != null?
                                                              NetworkImage(
                                                                "${snapshot.data?.data?[index].images}",
                                                              ): NetworkImage(""),
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
                                                            "${snapshot.data?.data?[0].place?[0].subLocality}",
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
                                            )
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
                                                                child: Text("${snapshot.data?.data?[index].weeklyNamaz?[index].day}",
                                                                  style: TextStyle(
                                                                    fontSize: SizeConfig.blockSizeHorizontal*3.0,fontFamily: 'Roboto_Bold',
                                                                  ),),
                                                              ),


                                                              /*Padding(
                                                                  padding: EdgeInsets.only(top: parentHeight*0.01),
                                                                  child: Container(
                                                                      width: parentWidth*0.145,
                                                                      height: parentHeight*0.031,
                                                                      decoration: const BoxDecoration(
                                                                        // color: Colors.blue,
                                                                          border: Border(bottom: BorderSide(width: 1,  color: CommonColor.SEARCH_COLOR))
                                                                      ),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.only(left: parentWidth*0.03),
                                                                        child: Text("${snapshot.data?[index].weeklyNamaz?[index].azan}",
                                                                          style: TextStyle(
                                                                              fontSize: SizeConfig.blockSizeHorizontal*3.0
                                                                          ),),
                                                                      )
                                                                  ),
                                                                ),*/

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
                                                                        Text("${snapshot.data?.data?[index].weeklyNamaz?[index].azan}",
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
                                                                    Text("${snapshot.data?.data?[index].weeklyNamaz?[index].jammat}",
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
                  });
            })
      ],
    );
  }
  Future<AllMasjitListResponceModel>fetchPost () async {
    // print(" userId ${userId}");

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization': 'Bearer 8|ZqL0Xvdz7hF098wrfFbh90UFLDKBiOrMDgfzgjIu'
    };

    // final msg = jsonEncode({
    //   "user_id": userId.toString(),
    // });



    var response = await http.get(
      Uri.parse('http://masjid.exportica.in/api/masjids'),
    headers:headersList
    );



    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

      // circularLoader = false;

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

/*
Future<List<AllMasjitListResponceModel>> fetchPost() async {
  final response = await http.get(Uri.parse('http://masjid.exportica.in/api/masjids'));

  if (response.statusCode == 200) {
   // final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    print("Hii ${response.body}");

    return parsed
        .map<AllMasjitListResponceModel>(
            (json) => AllMasjitListResponceModel.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}*/
