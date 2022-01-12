
import 'package:dzemaat/layers/data_layer/models/aamal_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetAamalData{

  List<AamalModel> aamalList;
  Future<List<AamalModel>> getAamalData() async {
    String url = '';
    http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 'OK') {
      responseData['data'].forEach((element) {
        if (element['something'] != null) {
          aamalModel = AamalModel(
            aamalText: element['text'],
            aamalNumber: element['number'],
            aamalInfo: element['info'],
            //so on
          );
          aamalList.add(aamalModel);
        }
      });
    }
    return aamalList;
  }

}