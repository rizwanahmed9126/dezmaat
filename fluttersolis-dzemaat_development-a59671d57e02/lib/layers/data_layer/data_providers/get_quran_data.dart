import 'package:dzemaat/layers/data_layer/models/ayat_model.dart';
import 'package:dzemaat/layers/data_layer/models/surah_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetQuranData {
  SurahModel surahModel;
  List<SurahModel> surahModelList = [];

  AyahsModel ayahsModel;
  List<AyahsModel> ayahsModelList = [];

  Future<List<SurahModel>> getQuranData() async {
    String url = "http://api.alquran.cloud/v1/surah";
    http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    if (responseData["status"] == "OK") {
      responseData["data"].forEach((element) {
        if (element["englishName"] != null &&
            element["englishNameTranslation"] != null) {
          surahModel = SurahModel(
            surahName: element["englishName"],
            surahNumber: element["number"],
            surahNameTranslation: element["englishNameTranslation"],
          );
          surahModelList.add(surahModel);
        }
      });
    }
    return surahModelList;
  }

  Future<List<AyahsModel>> getQuranAyahData({String name}) async {
    String url = "http://api.alquran.cloud/v1/quran/en.asad";
    http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    if (responseData["status"] == "OK") {
      responseData["data"]["surahs"].forEach((element) {
        if (element["englishName"] == name) {
          element["ayahs"].forEach((element) {
            ayahsModel = AyahsModel(
                ayahsNumber: element["numberInSurah"],
                ayahName: "asdasd",
                ayahsNameTranslation: element["text"]);
            ayahsModelList.add(ayahsModel);
          });
        }
      });
    }
    return ayahsModelList;
  }
}
