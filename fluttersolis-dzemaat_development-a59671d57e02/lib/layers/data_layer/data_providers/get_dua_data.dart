
import 'package:dzemaat/layers/data_layer/models/dua_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetDuaData{

  List<DuaModel> duaList;
  Future<List<DuaModel>> getDuaData() async {
    String url = '';
    http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 'OK') {
      responseData['data'].forEach((element) {
        if (element['something'] != null) {
          duaModel = DuaModel(
            duaText: element['duaText'],
            duaNumber: element['duaNumber'],
            duaInfo: element['duaInfo'],
            //so on
          );
          duaList.add(duaModel);
        }
      });
    }
    return duaList;
  }

}