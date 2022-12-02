import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'masjit_user_app_api/place.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/request_masjid_response.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:http/http.dart' as http;
import 'package:masjiduserapp/util/get_location.dart';



class UserRequestForm extends StatefulWidget {
  const UserRequestForm({Key? key}) : super(key: key);

  @override
  State<UserRequestForm> createState() => _UserRequestFormState();
}

class _UserRequestFormState extends State<UserRequestForm> {
  TextEditingController imamNameController = TextEditingController();
  TextEditingController imamNumberController = TextEditingController();
  TextEditingController masjidNameController = TextEditingController();

  final _imamNameFocus = FocusNode();
  final _imamNumberFocus = FocusNode();
  final _masjiNameFocus = FocusNode();

  String countryValue = "";
  String stateValue = "";
  String cityValue = "";

  late Box box;

  final _formKey = GlobalKey<FormState>();

  Future<RequestFormResponse>? result;

  Place? address;
  String _address = '';


  validate() {
    if (_formKey.currentState!.validate()) {
      print("validated");
      result = postRequestForm();

      result?.then((value) {

        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );

      });

    } else {
      print("not validated");
    }
  }


  @override
  void initState() {
    super.initState();
    box = Hive.box(kBoxName);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          getHeadingLayout(),
          getAllLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
        ],
      ),
    );
  }

  Widget getHeadingLayout() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
      ),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5, left: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Text(
              "Request Masjid Form",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 15),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget getAllLayout(double parentHeight, double parentWidth) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.03,
                      left: parentWidth * 0.03,
                      right: parentWidth * 0.03),
                  child: TextFormField(
                      focusNode: _imamNameFocus,
                      controller: imamNameController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Imam Name Field Is Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Imam Name',
                          labelStyle: const TextStyle(
                              color: CommonColor.REGISTRARTION_COLOR),
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.SEARCH_TEXT_COLOR))))),
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.03,
                      left: parentWidth * 0.03,
                      right: parentWidth * 0.03),
                  child: TextFormField(
                      focusNode: _imamNumberFocus,
                      controller: imamNumberController,
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Imam Number Field Is Required';
                        }
                        if (value.trim().length < 10 ||
                            value.trim().length > 10) {
                          return 'Please Enter Valid Number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Imam Number',
                          labelStyle: const TextStyle(
                              color: CommonColor.REGISTRARTION_COLOR),
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.SEARCH_TEXT_COLOR))))),
          Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.02, right: parentWidth * 0.02),
              child: Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.03,
                      left: parentWidth * 0.03,
                      right: parentWidth * 0.03),
                  child: TextFormField(
                      focusNode: _masjiNameFocus,
                      controller: masjidNameController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Masjid Name Field Is Required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Masjid Name',
                          labelStyle: const TextStyle(
                              color: CommonColor.REGISTRARTION_COLOR),
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: CommonColor.REGISTRARTION_COLOR),
                              borderRadius: BorderRadius.circular(10.0)),
                          hintStyle: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.SEARCH_TEXT_COLOR))))),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.03),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                child: Column(
                  children: [
                    CSCPicker(
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.DISABLE,
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",
                      countryDropdownLabel: "*Country",
                      stateDropdownLabel: "*State",
                      cityDropdownLabel: "*City",
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      dropdownHeadingStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      dropdownItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      dropdownDialogRadius: 10.0,
                      searchBarRadius: 10.0,
                      onCountryChanged: (value) {
                        setState(() {
                          value != null ? countryValue = value : "Country";
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          value != null ? stateValue = value : "State";
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          value != null ? cityValue = value : "City";
                        });
                      },
                    ),

                    /* TextButton(
                          onPressed: () {
                            setState(() {
                              _addressss = "$cityValue, $stateValue, $countryValue";
                            });
                          },
                          child: Text("Print Data")),
                      Text(_addressss)*/
                  ],
                )),
          ),
          Stack(
            children: [
              Visibility(
                visible: _address.isNotEmpty ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.03,
                      left: parentWidth * 0.3,
                      right: parentWidth * 0.3),
                  child: GestureDetector(
                    onDoubleTap: () {},
                    onTap: () {
                      final result = Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GetLocation(),
                        ),
                      );

                      result.then((value) {
                        if (value == null) return;
                        setState(() {
                          address = value;
                          _address =
                          'Area ${address?.lat},\n City ${address?.long}, \n Postal Code ${address?.postalCode},\n State ${address?.administrativeArea}, \n Country ${address?.country}';
                          setState(() {});
                        });
                      });
                    },
                    child: Container(
                      height: parentHeight * 0.06,
                      decoration: BoxDecoration(

                        //color: Colors.green,


                          border: Border.all(color: CommonColor.REGISTRARTION_COLOR),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: parentWidth * 0.01, right: parentWidth * 0.01),
                            child: Text(
                              "Select Location",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _address.isNotEmpty ? true : false,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.02, left: parentWidth * 0.04,right: parentWidth*0.04),
                  child: Container(
                    width: parentWidth * 1,
                    height: parentHeight * 0.06,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: CommonColor.REGISTRARTION_COLOR),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: parentWidth * 0.02),
                          child: _address.isNotEmpty
                              ? Text(
                              "${address?.subLocality}, ${address?.locality}, ${address?.postalCode}")
                              : Text(""),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              // var box = Hive.box(kBoxName);
              // box.put(kUserLatitude, address?.lat);
              // box.put(kUserLongitude, address?.long);
              // box.put(kUserSubLocality, address?.subLocality);
              // box.put(kUserLocality, address?.locality);
              //
              // print("${box.get("currentLatitude")}  ${box.get("currentLongitude")}");
              //
              //
              // if(cityValue.isNotEmpty){
              //   _address.isNotEmpty
              //       ? validate()
              //       : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //       content: Text("Please Select Your Current Location")));
              // } else{
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //       content: Text("Please Select Country, State, City")));
              // }

              // postRequestForm();

              if(countryValue.isNotEmpty && stateValue.isNotEmpty && cityValue.isNotEmpty){
                validate();
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please Select Country, State, City.")));
              }



            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.1,
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
                      "Submit",
                      style: TextStyle(
                          fontFamily: "Roboto_Regular",
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                          color: CommonColor.WHITE_COLOR),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPopupDialog(BuildContext context) {
    return Container(
      child: AlertDialog(
            content: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.04),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    // color: Colors.red,
                    height: 250,
                    child: const Center(
                      child:  Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          "Will register your Masjid As soon as possible",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontFamily: 'Roboto_Medium',
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Icon(Icons.clear_sharp,
                        color: Colors.red,),
                    ),
                  )
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
    );
  }



  Future<RequestFormResponse> postRequestForm() async {
    try {

      var headersList = {'Authorization': 'Bearer ${box.get(kToken)}'};

      final result = await http
          .post(Uri.parse("http://admin.azan4salah.com/api/masjids/request"),
          headers: headersList,
          body: {

        "imam_number": imamNumberController.text.trim(),
        "imam_name" : imamNameController.text.trim(),
        "masjid_name" : masjidNameController.text.trim(),
        "country" : countryValue,
        "state" : stateValue,
        "city" : cityValue,
            "locality":address?.locality.toString()??"",
            "sub_locality" : address?.subLocality.toString()??"",
            "postal_code" : address?.postalCode.toString()??"",
            "street" : address?.street.toString()??"",
            "lat" : address?.lat.toString()??"",
            "lng": address?.long.toString()


      });
      print("new order:" + result.body);

      if(result.statusCode == 200){

        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text("Request sent Successfully.")));
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );


      }

      return requestFormResponseFromJson(result.body);
    } catch (e) {
      rethrow;
    }
  }


}
