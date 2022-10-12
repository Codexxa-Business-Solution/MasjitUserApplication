
import 'package:shared_preferences/shared_preferences.dart';


class AppPreferences {
  static SharedPreferences? prefs;

  static Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  /*set latitude value in SharedPreferences*/
  static Future<double> getLatitude() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("latitude") ?? 0.0;
  }

  /*get latitude value form SharedPreferences*/
  static setLatitude(double latitude) async {
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    print("latitude   $latitude");
    prefs.setDouble("latitude", latitude);
  }

  /*set Longitude value in SharedPreferences*/
  static Future<double> getLongitude() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("longitude") ?? 0.0;
  }

  /*get getLongitude value form SharedPreferences*/
  static setLongitude(double longitude) async {
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    print("longitude   $longitude");
    prefs.setDouble("longitude", longitude);
  }


}
