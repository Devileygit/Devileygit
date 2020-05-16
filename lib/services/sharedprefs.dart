import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static String sharedPreferencesUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferencesUserIdKey = "USERIDKEY";
  static String sharedPreferencesUserEmailIdKey = "USEREMAILIDKEY";

  //save
  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferencesUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserIdSharedPreference(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencesUserIdKey, userId);
  }

  static Future<bool> saveUserEmailIdSharedPreference(
      String userEmailId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
        sharedPreferencesUserEmailIdKey, userEmailId);
  }

  //get

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferencesUserLoggedInKey);
  }

  static Future<String> getUserIdSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferencesUserIdKey);
  }

  static Future<String> getUserEmailIdSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferencesUserEmailIdKey);
  }
}
