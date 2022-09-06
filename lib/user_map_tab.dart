import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:masjiduserapp/search_location.dart';
import 'package:masjiduserapp/size_config.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:place_picker/place_picker.dart';
import 'package:place_picker/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'common.color.dart';
import 'database/masjit_user_app_preferances.dart';
import 'localization_item.dart';
import 'package:http/http.dart' as http;
class UserMapLocation extends StatefulWidget {
  const UserMapLocation({Key? key, required this.latitude, required this.longitude,}) : super(key: key);
  final String latitude ;
  final String longitude ;

  @override
  State<UserMapLocation> createState() => _UserMapLocationState();
}

class _UserMapLocationState extends State<UserMapLocation> with TickerProviderStateMixin {
  bool showDetails = true;
  bool mapToggle = false;
  final searchController = TextEditingController();
  String _searchText = "";
  final _searchFocus = FocusNode();
  LocalizationItemClass? localizationItem= new LocalizationItemClass();
  String sessionToken = Uuid().generateV4();
  final Completer<GoogleMapController> mapController = Completer();

  // Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor mapMaker;
  GlobalKey appBarKey = GlobalKey();
  LocationResult? locationResult;
  // late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set();

  LatLng showLocation = const LatLng(0, 0);
  late BitmapDescriptor customIcon;

  bool hasSearchTerm = false;
  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  List<NearbyPlace> nearbyPlaces = [];
  String previousSearchTerm = '';
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  GlobalKey<SearchLocationInputState>  searchGlobalKey=GlobalKey();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  void initState() {
    super.initState();
    setCustomMapPin();
    showLocation = LatLng(20.42796133580664, 75.885749655962);
  //  showLocation = LatLng(double.parse(widget.latitude), double.parse(widget.longitude));
    setMarker(showLocation);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(2.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
  }

  void setCustomMapPin() {
    if (mounted)
      setState(() {
        BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(100, 100)),
            'assets/images/editor.png')
        /*BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1200, 1200)),
            'assets/images/live_location_image.png')*/
            .then((d) {
          customIcon = d;
          AppPreferences.getLatitude().then((lat) {
            AppPreferences.getLongitude().then((lng) {
              print("widget.latitude    ${widget.latitude}    ${widget.longitude}");
             //showLocation = LatLng(double.parse(widget.latitude), double.parse(widget.longitude));
              showLocation = LatLng(20.42796133580664, 75.885749655962);
              print("onMapCreated   $lng   $lat");

            });
          });
        });

      });


  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    /* return Material(
     // resizeToAvoidBottomInset: false,
      key: this.appBarKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onDoubleTap: () {},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              child: Column(
                children: [
                  // getFilterNameLayout(
                  //     SizeConfig.screenHeight, SizeConfig.screenWidth),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight * .02,
                        left: SizeConfig.screenWidth * .06, right: SizeConfig.screenWidth * .05),
                    child: SearchLocationInput(searchPlace),
                  ),
                  // getSearchBarLayout(
                  //     SizeConfig.screenHeight, SizeConfig.screenWidth),
                  getGoogleMapLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth)
                ],
              ),
            ),
            getAddDoneButtonLayout(
                SizeConfig.screenHeight, SizeConfig.screenWidth),
          ],
        ),
      ),
    );*/
    return Builder(
      builder: (context) => Center(
        child: SlideTransition(
          position: _animation,
          transformHitTests: true,
          textDirection: TextDirection.ltr,
          child: Material(
            // resizeToAvoidBottomInset: false,
            key: this.appBarKey,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              onDoubleTap: () {},
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
              // color: Colors.red,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        // getFilterNameLayout(
                        //     SizeConfig.screenHeight, SizeConfig.screenWidth),
                      /*  Padding(
                          padding: EdgeInsets.only(top: SizeConfig.screenHeight * .01,
                              left: SizeConfig.screenWidth * .06, right: SizeConfig.screenWidth * .05),
                          child: SearchLocationInput(onSearchInput: searchPlace,key: searchGlobalKey,),
                        ),*/
                        // getSearchBarLayout(
                        //     SizeConfig.screenHeight, SizeConfig.screenWidth),
                        getGoogleMapLayout(
                            SizeConfig.screenHeight, SizeConfig.screenWidth)
                      ],
                    ),
                  ),
                  getAddDoneButtonLayout(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* Get Add Main Heading Layout */



  /* Get Add Google Map Layout */
  Widget getGoogleMapLayout(double parentHeight, double parentWidth) {
    // createMarker(context);
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.02),
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: parentHeight * 0.66,
                  // color: Colors.red,
                  child: GoogleMap(
                    rotateGesturesEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    indoorViewEnabled: true,
                    trafficEnabled: true,
                    zoomControlsEnabled: false,
                    // buildingsEnabled: false,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    cameraTargetBounds: CameraTargetBounds.unbounded,
                    zoomGesturesEnabled: true,

                    mapType: MapType.normal,
                    //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition(
                      //innital position in map
                      target: showLocation, //initial position
                      zoom: 12.0,
                      //initial zoom level
                    ),
                    onTap: (latLng){
                      setState(() {
                        markers.clear();
                        showLocation=latLng;
                        reverseGeocodeLatLng(showLocation);
                        markers.add(
                          Marker(
                            markerId: MarkerId("1"),
                            position:latLng,
                          ),
                        );
                      });
                    },

                    onCameraMove: (position) {
                      if (mounted)
                        setState(() {
                          showLocation = (position.target);
                          print("onCameraMove   $showLocation");
                          print("position   ${position.target}");
                          reverseGeocodeLatLng(showLocation);

                          markers.add(
                            Marker(
                              markerId: MarkerId('1'),
                              position: position.target,
                            ),
                          );
                        });
                    },
                    //markers to show on map
                    //mapType: MapType.normal, //map type
                    onMapCreated: onMapCreated,

                    markers: markers.toSet(),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void onMapCreated(GoogleMapController controller) {
    this.mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  void moveToCurrentUserLocation() {
    Location().getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude!, locationData.longitude!);
      moveToLocation(target);
      print("target    $target");
    }).catchError((error) {
      // TODO: Handle the exception here
      print(error);
    });
  }
  /* Get Add Done Button Layout */
  Widget getAddDoneButtonLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: parentHeight * .032),
      child: Container(
        height: parentHeight * .06,
        width: parentHeight * .40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),

          gradient:LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                CommonColor.LEFT_COLOR,
                CommonColor.RIGHT_COLOR
              ]),/* CommonWidget.getHeadingTextGradientColour()*/
        ),
        child: TextButton(
            onPressed: () async{
              String googleUrl ='https://www.google.com/maps/place/Rahul+Talkies+70+MM/@18.5315026,73.8464694,15z/data=!4m5!3m4!1s0x0:0xba33fc3bcc21df91!8m2!3d18.5315026!4d73.8464694';
              if (await canLaunch(googleUrl)) {
                await launch(googleUrl);
              } else {
                throw 'Could not open the map.';
              }

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                   "Get Direction",
                //ApplicationLocalizations.of(context)!.translate("done")!,
                style: TextStyle(
                  color: CommonColor.WHITE_COLOR,
                  fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto_Medium',
                ),
                textScaleFactor: 1.05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchPlace(String place) {
    // on keyboard dismissal, the search was being triggered again
    // this is to cap that.
    print("onSearchInput     $place");
    if (place == this.previousSearchTerm) {
      return;
    }

    previousSearchTerm = place;

    if (context == null) {
      return;
    }

    clearOverlay();

    setState(() {
      hasSearchTerm = place.length > 0;
    });

    if (place.length < 1) {
      return;
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final RenderBox? appBarBox =
    this.appBarKey.currentContext!.findRenderObject() as RenderBox?;

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(child: Container(),
        // top: appBarBox!.size.height,
        // width: size.width,
        /* child: Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
               children: <Widget>[
                // SizedBox(
                //     height: 24,
                //     width: 24,
                //     child: CircularProgressIndicator(strokeWidth: 3)),
                // SizedBox(width: 24),
                // Expanded(
                //     child: Text("widget.localizationItem!.findingPlace",
                //         style: TextStyle(fontSize: 16)))
              ],
            ),
          ),
        ),*/
      ),
    );

    Overlay.of(context)!.insert(this.overlayEntry!);

    autoCompleteSearch(place);
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry!.remove();
      this.overlayEntry = null;
    }
  }


  /// Fetches the place autocomplete list with the query [place].
  void autoCompleteSearch(String place) async {
    try {
      place = place.replaceAll(" ", "+");

      var endpoint =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
          "key=AIzaSyDmGf486wAvt_8sDkl7i7qE2RRwGIB5qmk"
          "language=${localizationItem!.languageCode}&"
          "input={$place}&sessiontoken=${this.sessionToken}";

      if (this.locationResult != null) {
        endpoint += "&location=${this.locationResult!.latLng!.latitude}," +
            "${this.locationResult!.latLng!.longitude}";
      }

      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['predictions'] == null) {
        throw Error();
      }

      List<dynamic> predictions = responseJson['predictions'];
      //
      List<RichSuggestion> suggestions = [];
      //
      if (predictions.isEmpty) {
        AutoCompleteItem aci = AutoCompleteItem();
        aci.text =  localizationItem!.noResultsFound;
        aci.offset = 0;
        aci.length = 0;

        suggestions.add(RichSuggestion(aci, () {}));
      } else {
        for (dynamic t in predictions) {
          final aci = AutoCompleteItem()
            ..id = t['place_id']
            ..text = t['description']
            ..offset = t['matched_substrings'][0]['offset']
            ..length = t['matched_substrings'][0]['length'];

          suggestions.add(RichSuggestion(aci, () {
            FocusScope.of(context).requestFocus(FocusNode());
            //searchPlace(aci.text!);
            searchGlobalKey.currentState!.onPassTextInputParameter(aci.text!);
            decodeAndSelectPlace(aci.id);
          }));
        }
      }
      //
      displayAutoCompleteSuggestions(suggestions);
    } catch (e) {
      print(e);
    }
  }

  void decodeAndSelectPlace(String? placeId) async {
    clearOverlay();

    try {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/details/json?key=AIzaSyDmGf486wAvt_8sDkl7i7qE2RRwGIB5qmk" +
              "language=${localizationItem!.languageCode}&" +
              "placeid=$placeId");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['result'] == null) {
        throw Error();
      }

      final location = responseJson['result']['geometry']['location'];
      moveToLocation(LatLng(location['lat'], location['lng']));
    } catch (e) {
      print(e);
    }
  }
  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    final RenderBox? appBarBox =
    this.appBarKey.currentContext!.findRenderObject() as RenderBox?;

    clearOverlay();

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: SizeConfig.screenHeight*0.23,
        child: Material(elevation: 1, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: suggestions)),
      ),
    );
    Overlay.of(context)!.insert(this.overlayEntry!);
  }

  void moveToLocation(LatLng latLng) {
    this.mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: latLng, zoom: 15.0)),
      );
    });

    // setMarker(latLng);
    print("moveToLocation   ");
    reverseGeocodeLatLng(latLng);

    getNearbyPlaces(latLng);
  }
  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
    setState(() {
      markers.clear();
      // latitude = latLng.latitude;
      // longitude = latLng.longitude;

      markers.add(
          Marker(
            draggable: true,
            markerId: MarkerId("selected-location"), position: latLng,));
    });
  }
  /// Fetches and updates the nearby places to the provided lat,lng
  void getNearbyPlaces(LatLng latLng) async {
    try {
      final url = Uri.parse(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
              "key=AIzaSyDmGf486wAvt_8sDkl7i7qE2RRwGIB5qmk&location=${latLng.latitude},${latLng.longitude}"
              "&radius=150&language=${localizationItem!.languageCode}");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      this.nearbyPlaces.clear();

      for (Map<String, dynamic> item in responseJson['results']) {
        final nearbyPlace = NearbyPlace()
          ..name = item['name']
          ..icon = item['icon']
          ..latLng = LatLng(item['geometry']['location']['lat'],
              item['geometry']['location']['lng']);

        this.nearbyPlaces.add(nearbyPlace);
      }

      // to update the nearby places
      setState(() {
        // this is to require the result to show
        this.hasSearchTerm = false;
      });
    } catch (e) {
      //
    }
  }
  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) async {
    try {
      final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?"
          "latlng=${latLng.latitude},${latLng.longitude}&"
          "language=${localizationItem!.languageCode}&"
          "key=AIzaSyDmGf486wAvt_8sDkl7i7qE2RRwGIB5qmk");

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Error();
      }

      final responseJson = jsonDecode(response.body);

      if (responseJson['results'] == null) {
        throw Error();
      }

      final result = responseJson['results'][0];

      setState(() {
        String? name,
            locality,
            postalCode,
            country,
            administrativeAreaLevel1,
            administrativeAreaLevel2,
            city,
            subLocalityLevel1,
            subLocalityLevel2;
        bool isOnStreet = false;
        if (result['address_components'] is List<dynamic> &&
            result['address_components'].length != null &&
            result['address_components'].length > 0) {
          for (var i = 0; i < result['address_components'].length; i++) {
            var tmp = result['address_components'][i];
            var types = tmp["types"] as List<dynamic>?;
            var shortName = tmp['short_name'];
            if (types == null) {
              continue;
            }
            if (i == 0) {
              // [street_number]
              name = shortName;
              isOnStreet = types.contains('street_number');
              // other index 0 types
              // [establishment, point_of_interest, subway_station, transit_station]
              // [premise]
              // [route]
            } else if (i == 1 && isOnStreet) {
              if (types.contains('route')) {
                name = (name ?? "") + ", $shortName";
              }
            } else {
              if (types.contains("sublocality_level_1")) {
                subLocalityLevel1 = shortName;
              } else if (types.contains("sublocality_level_2")) {
                subLocalityLevel2 = shortName;
              } else if (types.contains("locality")) {
                locality = shortName;
              } else if (types.contains("administrative_area_level_2")) {
                administrativeAreaLevel2 = shortName;
              } else if (types.contains("administrative_area_level_1")) {
                administrativeAreaLevel1 = shortName;
              } else if (types.contains("country")) {
                country = shortName;
              } else if (types.contains('postal_code')) {
                postalCode = shortName;
              }
            }
          }
        }
        locality = locality ?? administrativeAreaLevel1;
        city = locality;
        this.locationResult = LocationResult()
          ..name = name
          ..locality = locality
          ..latLng = latLng
          ..formattedAddress = result['formatted_address']
          ..placeId = result['place_id']
          ..postalCode = postalCode
          ..country = AddressComponent(name: country, shortName: country)
          ..administrativeAreaLevel1 = AddressComponent(
              name: administrativeAreaLevel1,
              shortName: administrativeAreaLevel1)
          ..administrativeAreaLevel2 = AddressComponent(
              name: administrativeAreaLevel2,
              shortName: administrativeAreaLevel2)
          ..city = AddressComponent(name: city, shortName: city)
          ..subLocalityLevel1 = AddressComponent(
              name: subLocalityLevel1, shortName: subLocalityLevel1)
          ..subLocalityLevel2 = AddressComponent(
              name: subLocalityLevel2, shortName: subLocalityLevel2);
        // print("namename   $name .locality  $locality subLocalityLevel1 $subLocalityLevel1 formatted_address ${result['formatted_address']}" );

      });

      // searchGlobalKey.currentState!.onPassTextInputParameter(this.locationResult!.subLocalityLevel1!.name!=null?"${this.locationResult!.subLocalityLevel1!.name}, ${this.locationResult!.locality}":'${this.locationResult!.locality}');
      searchGlobalKey.currentState!.onPassTextInputParameter(result['formatted_address']);

    } catch (e) {
      print(e);
    }
  }
}



abstract class FilterLocationMapInterface {
  addbackFilterFragment(String screenName,LatLng showLocation);
}
