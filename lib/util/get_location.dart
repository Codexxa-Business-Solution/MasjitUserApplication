import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as location;
import 'package:masjiduserapp/all_masjit_list.dart';
import 'package:masjiduserapp/common.color.dart';
import 'package:masjiduserapp/size_config.dart';
import 'package:masjiduserapp/user_parent_tab_bar.dart';

import '../masjit_user_app_api/place.dart';

class GetLocation extends StatefulWidget {

  final String comeFrom;

  const GetLocation({Key? key, this.comeFrom=""}) : super(key: key);

  @override
  State<GetLocation> createState() => GetLocationState();
}

class GetLocationState extends State<GetLocation> {
  late GoogleMapController _controller;
  final location.Location _location = location.Location();
  Timer? _debounce;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  static const kGoogleApiKey = "AIzaSyDmKx2C1OIAxNzTeoxEH1U8getJT3hTQF4";
  double selectLat = 0.0;
  double selectLang = 0.0;
  final Map<String, Marker> _markers = {};
  bool locationCaputed = false;
  String _address = '';
  late Placemark address;
  Place? place;
  final _searchFocus = FocusNode();
  final searchController = TextEditingController();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.563072, 73.8000896),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
  }

  _updateAddress(LatLng target) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      Future<List<Placemark>> placemarks = placemarkFromCoordinates(
        target.latitude,
        target.longitude,
      );

      placemarks.then(
        (value) {
          address = value[0];
          _address =
              '${address.name}, ${address.street}, ${address.subLocality}, ${address.locality}, ${address.postalCode}, ${address.administrativeArea}, ${address.country}';

          place = Place(
            administrativeArea: address.administrativeArea,
            street: address.street,
            lat: target.latitude.toString(),
            long: target.longitude.toString(),
            locality: address.locality,
            subLocality: address.subLocality,
            country: address.country,
            postalCode: address.postalCode,
          );
          setState(() {});
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: homeScaffoldKey,
      body: Stack(children: [
        GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: _markers.values.toSet(),
            onCameraMove: (position) {
              _updateAddress(position.target);
              setState(() {
                _markers.clear();
                _markers['location'] = Marker(
                  markerId: const MarkerId('location'),
                  position: position.target,
                );
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _location.onLocationChanged.listen((location) async {
                if (locationCaputed) return;

                locationCaputed = true;

                final latLng = LatLng(
                  location.latitude!,
                  location.longitude!,
                );

                _markers.clear();
                _controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: latLng,
                      zoom: 15.0,
                    ),
                  ),
                );

                _updateAddress(latLng);

                setState(() {
                  _markers['location'] = Marker(
                    markerId: const MarkerId('location'),
                    position: latLng,
                  );
                });
              });
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .2,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_address),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {

                      Navigator.of(context).pop(place);

                     widget.comeFrom=="1"?
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ParentTabBarScreen())):
                      Container();

                    },
                    child: const Text('Save Address'),
                  )
                ]),
          ),
        ),
        getSearchBarLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)
      ]),
    );
  }

  Widget getSearchBarLayout(double parentHeight, parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * .05,
          right: SizeConfig.screenWidth * .05,
          top: SizeConfig.screenHeight * 0.07),
      child: Container(
        height: SizeConfig.screenHeight * .050,
        decoration: const BoxDecoration(
          color: Colors.white,
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
                child: GestureDetector(
                  onTap: () async {

                    _handlePressButton();


                  },
                  child: /*TextFormField(
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
                      hintText: "Search Location",
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                        color: CommonColor.SEARCH_TEXT_COLOR,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )*/
                  Text("Search Location",style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                    color: CommonColor.SEARCH_TEXT_COLOR,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
  void onError(PlacesAutocompleteResponse response) {

  }
  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      offset: 0,
      radius: 1000,
      types: [],
      strictbounds: false,
      components: [],
    );

    displayPrediction(p);
    setState(
          () {
        // address = '${p!.description}';
        // _textFullAddress.text = address;
      },
    );

  }
  Future<Null> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,

        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      selectLang = double.parse('$lng');
      selectLat = double.parse('$lat');

      setState(() {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(selectLat, selectLang), zoom: 18),
            ),
          );
          // _initialCameraPosition = LatLng(selectLat, selectLang);
          // _createMarker();
        });

  }}


}
