import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/all_masjit_list_responce_model.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/searh_near_masjid_data.dart';
import 'package:masjiduserapp/parent_masjit_location_name.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_request_form.dart';
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
    await Future.delayed(const Duration(seconds: 3));
    getAllSearchListFuture = fetchSearchList();
  }

  final _key = GlobalKey<RefreshIndicatorState>();
  var getAllListFuture;
  var getAllSearchListFuture;
  late Box box;
  var imagess;
  final _searchFocus = FocusNode();
  final searchController = TextEditingController();

  _searchTextController() {
    print("searchController   $searchController");
    int textLength = searchController.text.length;
    if (textLength > 0 || textLength != 0) {
      setState(() {
        getAllListFuture = fetchPost();
      });
    } else if (textLength == 0) {
      _searchFocus.unfocus();
      setState(() {
        getAllSearchListFuture = fetchSearchList();
      });
    }
  }

  @override
  void initState() {
    box = Hive.box(kBoxName);
    setState(() {
      fetchSearchList();
    });
    setState(() {});
    getAllListFuture = fetchPost();
    getAllSearchListFuture = fetchSearchList();
    print("masjid $getAllListFuture");
    searchController.addListener(_searchTextController);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: Column(
            children: [
              getSearchBarLayout(
                SizeConfig.screenHeight,
                SizeConfig.screenWidth,
              ),


              getRequestFormCode(
                SizeConfig.screenHeight,
                SizeConfig.screenWidth,
              ),

              searchController.text.isEmpty
                  ? getAddSearchMasjidList(
                SizeConfig.screenHeight,
                SizeConfig.screenWidth,
              )
                  : getAddTermsTextLayout(
                SizeConfig.screenHeight,
                SizeConfig.screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget getRequestFormCode(double parentHeight, parentWidth){
    return /*RichText(
      maxLines: 1,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: "If you don't find masjid in the list click below",
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal*4.0,)),
          TextSpan(text: " Click Here.",
            style: TextStyle(
              color: Colors.blue,
              fontSize: SizeConfig.blockSizeHorizontal*3.5,),
          ),
        ],
      ),
    );*/

    Padding(
      padding: EdgeInsets.only(top: parentHeight*0.03, left: parentWidth* 0.15, right: parentWidth* 0.15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text("If you don't find masjid in the list click below.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeHorizontal*4.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: parentHeight*0.01),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRequestForm()));
              },
              child: Container(
                height: parentHeight*0.04,
                width: parentWidth*0.42,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text("Request For Masjid ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeHorizontal*4.0,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getSearchBarLayout(double parentHeight, parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * .0,
          right: SizeConfig.screenWidth * .0,
          top: SizeConfig.screenHeight * 0.03),
      child: Container(
        height: SizeConfig.screenHeight * .050,
        decoration: const BoxDecoration(
          color: CommonColor.SEARCH_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
              child: const Image(
                image: AssetImage("assets/images/searchs.png"),
                // fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.02,
                    right: SizeConfig.screenWidth * .01),
                child: TextFormField(
                  scrollPadding:
                  EdgeInsets.only(bottom: SizeConfig.screenHeight * .005),
                  controller: searchController,
                  focusNode: _searchFocus,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    counterText: "",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Search Masjid",
                    hintStyle: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                      color: CommonColor.SEARCH_TEXT_COLOR,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAddNoDataTextLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Masjid Found",
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.safeBlockHorizontal * 3.61,
              fontFamily: "Avenir_Book",
              fontWeight: FontWeight.w800,
            ),
            // textAlign: TextAlign.center,
            textScaleFactor: 1.1,
          ),
        ],
      ),
    );
  }

  Widget getAddTermsTextLayout(
      double parentHeight,
      double parentWidth,
      ) {
    return FutureBuilder<AllMasjitListResponceModel>(
        future: getAllListFuture,
        builder: (context, snapshot) {
          return snapshot.data?.data?.length != null
              ? Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.01),
              child: Stack(
                children: [
                  getAddNoDataTextLayout(parentHeight, parentWidth),
                  ListView.builder(
                      itemCount: snapshot.data?.data?.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final img = snapshot.data?.data?[index].images
                            ?.isNotEmpty ??
                            false
                            ? NetworkImage(
                          "http://admin.azan4salah.com/${snapshot.data?.data?[index].images?[0]}",
                        )
                            : const NetworkImage(
                            "https://image.shutterstock.com/image-photo/medina-saudi-arabia-july-07-260nw-1773824582.jpg");

                        return Padding(
                            padding:
                            EdgeInsets.only(top: parentHeight * 0.03),
                            child: Container(
                                height: parentHeight * 0.23,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
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
                                    SizedBox(
                                      // color: Colors.blue,
                                      height: parentHeight * 0.1,
                                      child: Column(children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                  parentHeight * 0.02,
                                                  left: parentHeight *
                                                      0.004),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                        parentWidth *
                                                            0.01),
                                                    child: Container(
                                                        height:
                                                        parentHeight *
                                                            0.08,
                                                        width:
                                                        parentWidth *
                                                            0.17,
                                                        decoration:
                                                        BoxDecoration(
                                                            image:
                                                            DecorationImage(
                                                              image:
                                                              img,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: parentHeight *
                                                      0.02,
                                                  top: parentWidth *
                                                      0.03),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
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
                                                        padding: EdgeInsets
                                                            .only(
                                                          // right: parentWidth * 0.05,
                                                            top: parentHeight *
                                                                0.01),
                                                        child: Container(
                                                          width: parentWidth*0.39,
                                                          // color: Colors.red,
                                                          child: Text(
                                                            "${snapshot.data?.data?[index].place?[0].masjidName}",
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              SizeConfig.blockSizeHorizontal *
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
                                                            TextAlign
                                                                .start,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                            textScaleFactor: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        // color: Colors.red,
                                                        width: SizeConfig.screenWidth*0.4,
                                                        child: Text(
                                                            "${snapshot.data?.data?[index].place?[0].subLocality}",
                                                            overflow: TextOverflow.ellipsis,
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              SizeConfig.blockSizeHorizontal *
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
                                            Stack(
                                              children: [
                                                snapshot
                                                    .data
                                                    ?.data?[index]
                                                    .joined ==
                                                    false
                                                    ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      parentWidth *
                                                          0.05),
                                                  child: SizedBox(
                                                    width:
                                                    parentWidth *
                                                        .23,
                                                    height:
                                                    parentWidth *
                                                        .08,
                                                    child:
                                                    GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            "id ${snapshot.data?.data?[index].id}");

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => MasjitNameLocation(
                                                                  masjitId: snapshot.data?.data?[index].id != null ? "${snapshot.data?.data?[index].id}" : "",
                                                                  lat: "${snapshot.data?.data?[index].place?[0].lat}",
                                                                  long: "${snapshot.data?.data?[index].place?[0].long}",
                                                                )));
                                                      },
                                                      child: Container(
                                                          height: parentHeight * 0.04,
                                                          width: parentWidth * 0.3,
                                                          decoration: BoxDecoration(
                                                            gradient: const LinearGradient(
                                                                begin:
                                                                Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                                colors: [
                                                                  CommonColor.LEFT_COLOR,
                                                                  CommonColor.RIGHT_COLOR
                                                                ]),
                                                            borderRadius:
                                                            BorderRadius.circular(7),
                                                          ),
                                                          child: Center(
                                                            child:
                                                            Text(
                                                              "JOIN",
                                                              style: TextStyle(
                                                                  fontFamily: "Roboto_Regular",
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                                  color: CommonColor.WHITE_COLOR),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                                    : Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      parentWidth *
                                                          0.05),
                                                  child: SizedBox(
                                                    width:
                                                    parentWidth *
                                                        0.2,
                                                    child: Center(
                                                      child: Text(
                                                        "Joined",
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
                                                                .REGISTRARTION_COLOR),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: parentHeight * 0.13,

                                      // color: Colors.green,
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight *
                                                        0.02,
                                                    right: parentHeight *
                                                        0.0),
                                                child: const Text(
                                                  "AZAN",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .transparent),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight *
                                                        0.0),
                                                child: Container(
                                                    width: parentWidth *
                                                        0.14,
                                                    height: parentHeight *
                                                        0.024,
                                                    decoration:
                                                    const BoxDecoration(
                                                      // color: Colors.blue,
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                width:
                                                                1,
                                                                color:
                                                                CommonColor.SEARCH_COLOR))),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                          parentWidth *
                                                              0.03),
                                                      child: const Text(
                                                        "AZAN",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'Roboto_Bold',
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            color: CommonColor
                                                                .BLACK_COLOR,
                                                            fontSize: 10),
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight *
                                                        0.012,
                                                    left: parentWidth *
                                                        0.0),
                                                child: Row(
                                                  children: const [
                                                    Text(
                                                      "JAMAAT",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Roboto_Bold',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color: CommonColor
                                                              .BLACK_COLOR,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          /* FutureBuilder<
                                                      AllMasjitListResponceModel>(
                                                  future: getAllListFuture,
                                                  builder: (context, snapshot) {
                                                    return snapshot
                                                                .data
                                                                ?.data?[index]
                                                                .weeklyNamaz
                                                                ?.length !=
                                                            null
                                                        ?*/
                                          Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data
                                                    ?.data?[index]
                                                    .weeklyNamaz
                                                    ?.length,
                                                scrollDirection:
                                                Axis.horizontal,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (context, index1) {
                                                  return Column(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                            parentHeight *
                                                                0.01,
                                                            right:
                                                            parentHeight *
                                                                0.0),
                                                        child: Text(
                                                          "${snapshot.data?.data?[index].weeklyNamaz?[index1].day}",
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            SizeConfig
                                                                .blockSizeHorizontal *
                                                                3.0,
                                                            fontFamily:
                                                            'Roboto_Bold',
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets
                                                            .only(
                                                          top:
                                                          parentHeight *
                                                              0.008,
                                                        ),
                                                        child: Container(
                                                          width:
                                                          parentWidth *
                                                              0.145,
                                                          height:
                                                          parentHeight *
                                                              0.031,
                                                          decoration:
                                                          const BoxDecoration(
                                                            // color: Colors.blue,
                                                              border: Border(
                                                                  bottom:
                                                                  BorderSide(width: 1, color: CommonColor.SEARCH_COLOR))),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top: parentHeight *
                                                                    0.0,
                                                                left: parentHeight *
                                                                    0.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "${snapshot.data?.data?[index].weeklyNamaz?[index1].azan}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      SizeConfig.blockSizeHorizontal * 3.0),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                            parentHeight *
                                                                0.009,
                                                            right:
                                                            parentHeight *
                                                                0.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${snapshot.data?.data?[index].weeklyNamaz?[index1].jammat}",
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                SizeConfig.blockSizeHorizontal *
                                                                    3.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )
                                          /*: Container();
                                                  })*/
                                        ],
                                      ),
                                    )
                                  ],
                                )));
                      }),
                ],
              ),
            ),
          )
              : Center(
              child: Padding(
                padding: EdgeInsets.only(top: parentHeight*0.1),
                child: Text(
                  "No Masjid Found at this Location",
                  style: TextStyle(color: Colors.black),
                ),
              ));
        });
  }

  Widget getAddSearchMasjidList(
      double parentHeight,
      double parentWidth,
      ) {
    return FutureBuilder<SearchMasjidData>(
        future: getAllSearchListFuture,
        builder: (context, snapshot) {
          return snapshot.data?.data?.length != null
              ? Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.01),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: parentHeight*0.05),
                        child: const Text(
                          "No Masjid Found at this Location",
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      itemCount: snapshot.data?.data?.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final img = snapshot
                            .data?.data?[index].images?.isNotEmpty ??
                            false
                            ? NetworkImage(
                          "http://admin.azan4salah.com/${snapshot.data?.data?[index].images?[0]}",
                        )
                            : const NetworkImage(
                            "https://image.shutterstock.com/image-photo/medina-saudi-arabia-july-07-260nw-1773824582.jpg");

                        return Padding(
                            padding:
                            EdgeInsets.only(top: parentHeight * 0.03),
                            child: Container(
                                height: parentHeight * 0.23,
                                decoration: BoxDecoration(
                                  // color: Colors.red,
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
                                    SizedBox(
                                      // color: Colors.blue,
                                      height: parentHeight * 0.1,
                                      child: Column(children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top:
                                                  parentHeight * 0.02,
                                                  left: parentHeight *
                                                      0.004),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                        parentWidth *
                                                            0.01),
                                                    child: Container(
                                                        height:
                                                        parentHeight *
                                                            0.08,
                                                        width:
                                                        parentWidth *
                                                            0.17,
                                                        decoration:
                                                        BoxDecoration(
                                                            image:
                                                            DecorationImage(
                                                              image:
                                                              img,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: parentHeight *
                                                      0.02,
                                                  top: parentWidth *
                                                      0.03),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
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
                                                        padding: EdgeInsets
                                                            .only(
                                                          // right: parentWidth * 0.05,
                                                            top: parentHeight *
                                                                0.01),
                                                        child: Container(
                                                          width: parentWidth*0.39,
                                                          // color: Colors.red,
                                                          child: Text(
                                                            "${snapshot.data?.data?[index].place?[0].masjidName}",
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              SizeConfig.blockSizeHorizontal *
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
                                                            TextAlign
                                                                .start,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: SizeConfig.screenWidth*0.4,
                                                        // color: Colors.red,
                                                        child: Text(
                                                            "${snapshot.data?.data?[index].place?[0].subLocality}",
                                                            overflow: TextOverflow.ellipsis,
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              SizeConfig.blockSizeHorizontal *
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
                                            Stack(
                                              children: [
                                                snapshot
                                                    .data
                                                    ?.data?[index]
                                                    .joined ==
                                                    false
                                                    ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      parentWidth *
                                                          0.05),
                                                  child: SizedBox(
                                                    width:
                                                    parentWidth *
                                                        .23,
                                                    height:
                                                    parentWidth *
                                                        .08,
                                                    child:
                                                    GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            "id ${snapshot.data?.data?[index].id}");

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => MasjitNameLocation(
                                                                  masjitId: snapshot.data?.data?[index].id != null ? "${snapshot.data?.data?[index].id}" : "",
                                                                  lat: "${snapshot.data?.data?[index].place?[0].lat}",
                                                                  long: "${snapshot.data?.data?[index].place?[0].long}",
                                                                )));
                                                      },
                                                      child: Container(
                                                          height: parentHeight * 0.04,
                                                          width: parentWidth * 0.3,
                                                          decoration: BoxDecoration(
                                                            gradient: const LinearGradient(
                                                                begin:
                                                                Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                                colors: [
                                                                  CommonColor.LEFT_COLOR,
                                                                  CommonColor.RIGHT_COLOR
                                                                ]),
                                                            borderRadius:
                                                            BorderRadius.circular(7),
                                                          ),
                                                          child: Center(
                                                            child:
                                                            Text(
                                                              "JOIN",
                                                              style: TextStyle(
                                                                  fontFamily: "Roboto_Regular",
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                                  color: CommonColor.WHITE_COLOR),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                )
                                                    : Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      parentWidth *
                                                          0.05),
                                                  child: SizedBox(
                                                    width:
                                                    parentWidth *
                                                        0.2,
                                                    child: Center(
                                                      child: Text(
                                                        "Joined",
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
                                                                .REGISTRARTION_COLOR),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: parentHeight * 0.13,

                                      // color: Colors.green,
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight *
                                                        0.02,
                                                    right: parentHeight *
                                                        0.0),
                                                child: const Text(
                                                  "AZAN",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .transparent),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight *
                                                        0.0),
                                                child: Container(
                                                    width: parentWidth *
                                                        0.14,
                                                    height: parentHeight *
                                                        0.024,
                                                    decoration:
                                                    const BoxDecoration(
                                                      // color: Colors.blue,
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                width:
                                                                1,
                                                                color:
                                                                CommonColor.SEARCH_COLOR))),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                          parentWidth *
                                                              0.03),
                                                      child: const Text(
                                                        "AZAN",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'Roboto_Bold',
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            color: CommonColor
                                                                .BLACK_COLOR,
                                                            fontSize: 10),
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight *
                                                        0.012,
                                                    left: parentWidth *
                                                        0.0),
                                                child: Row(
                                                  children: const [
                                                    Text(
                                                      "JAMAAT",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Roboto_Bold',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          color: CommonColor
                                                              .BLACK_COLOR,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          /* FutureBuilder<
                                                      AllMasjitListResponceModel>(
                                                  future: getAllListFuture,
                                                  builder: (context, snapshot) {
                                                    return snapshot
                                                                .data
                                                                ?.data?[index]
                                                                .weeklyNamaz
                                                                ?.length !=
                                                            null
                                                        ?*/
                                          Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data
                                                    ?.data?[index]
                                                    .weeklyNamaz
                                                    ?.length,
                                                scrollDirection:
                                                Axis.horizontal,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (context, index1) {
                                                  return Column(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                            parentHeight *
                                                                0.01,
                                                            right:
                                                            parentHeight *
                                                                0.0),
                                                        child: Text(
                                                          "${snapshot.data?.data?[index].weeklyNamaz?[index1].day}",
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            SizeConfig
                                                                .blockSizeHorizontal *
                                                                3.0,
                                                            fontFamily:
                                                            'Roboto_Bold',
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets
                                                            .only(
                                                          top:
                                                          parentHeight *
                                                              0.008,
                                                        ),
                                                        child: Container(
                                                          width:
                                                          parentWidth *
                                                              0.145,
                                                          height:
                                                          parentHeight *
                                                              0.031,
                                                          decoration:
                                                          const BoxDecoration(
                                                            // color: Colors.blue,
                                                              border: Border(
                                                                  bottom:
                                                                  BorderSide(width: 1, color: CommonColor.SEARCH_COLOR))),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top: parentHeight *
                                                                    0.0,
                                                                left: parentHeight *
                                                                    0.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "${snapshot.data?.data?[index].weeklyNamaz?[index1].azan}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      SizeConfig.blockSizeHorizontal * 3.0),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top:
                                                            parentHeight *
                                                                0.009,
                                                            right:
                                                            parentHeight *
                                                                0.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${snapshot.data?.data?[index].weeklyNamaz?[index1].jammat}",
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                SizeConfig.blockSizeHorizontal *
                                                                    3.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )
                                          /*: Container();
                                                  })*/
                                        ],
                                      ),
                                    )
                                  ],
                                )));
                      }),
                ],
              ),
            ),
          )
              : Container();
        });
  }

  Future<AllMasjitListResponceModel> fetchPost() async {
    print(" tokennn ${box.get(kToken)}");

    print("key ${searchController.text.trim()}");

    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse(
            'http://admin.azan4salah.com/api/masjids?keyword=${searchController.text.trim()}'),
        headers: headersList);

    if (response.statusCode == 200) {
      print("Yess.. ${response.body}");
      print("Hiii");

      return allMasjitListResponceModelFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<SearchMasjidData> fetchSearchList() async {
    print(" tokennn ${box.get(kToken)}");

    var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

    var response = await http.get(
        Uri.parse(
            'http://admin.azan4salah.com/api/masjids/nearby?lat=${box.get(kUserLatitude)}&long=${box.get(kUserLongitude)}'),
        headers: headersList);

    if (response.statusCode == 200) {
      print("Search Data.. ${response.body}");

      print("Hiii");

      return searchMasjidDataFromJson(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
