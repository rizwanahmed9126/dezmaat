import 'package:shared_preferences/shared_preferences.dart';

class PrefsFunctions{

  static String prefsUserLoggedInKey = "ISLOGGEDIN";
  static String prefsEmail= "EMAIL";

  // getting data
  static Future<bool> getUserLoggedInPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(prefsUserLoggedInKey);
  }

  // saving data
  static Future<bool> saveUserLoggedInPrefs(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(prefsUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveEmailPrefs(String val) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(prefsEmail, val);
  }

  static Future<String> getEmailPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(prefsEmail);
  }

  static Future<bool> getFirstTimeUsePrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('firstTimeUse');
  }

  static Future<bool> saveFirstTimeUsePrefs(bool val) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool('firstTimeUse', val);
  }

  static Future<bool> getUserOneTimeUsedPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('userOneTimeUsed');
  }

  static Future<bool> saveUserOneTimeUsedPrefs(bool val) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool('userOneTimeUsed', val);
  }

  static Future<bool> saveLanguagePrefs(String val) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('language', val);
  }

  static Future<String> getLanguagePrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('language');
  }

}

PrefsFunctions prefsFunctions = PrefsFunctions();
