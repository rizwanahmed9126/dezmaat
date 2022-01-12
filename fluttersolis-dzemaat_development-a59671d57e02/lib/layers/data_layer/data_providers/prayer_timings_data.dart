// import 'package:dzemaat/layers/data_layer/models/prayer_timing_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:dzemaat/layers/data_layer/data_providers/prayer_json_data.dart';
//
// class GetPrayerTimingsData{
//
//   // List<PrayerTimingModel> prayerTimingsList;
//   // Future<List<PrayerTimingModel>> getPrayerTimingsData() async {
//   //   String url = 'http://api.aladhan.com/v1/timings/1398332113?latitude=51.508515&longitude=-0.1254872&method=2';
//   //   http.Response response = await http.get(url);
//   //   var responseData = jsonDecode(response.body);
//   //   if (responseData['status'] == 'OK') {
//   //     responseData['data'].forEach((element) {
//   //       if (element['something'] != null) {
//   //         prayerTimingModel = PrayerTimingModel(
//   //           prayerTimeEpoch: element[''],
//   //           prayerName: element[''],
//   //           prayerId: element[''],
//   //           //so on
//   //         );
//   //         prayerTimingsList.add(prayerTimingModel);
//   //       }
//   //     });
//   //   }
//   //
//   //   return prayerTimingsList;
//   // }
//
//   //
//   Future getPTdata() async{
//   Data List;
//   String url = 'http://api.aladhan.com/v1/timingsByCity?city=Karachi&country=Pakistan&method=4';
//   Future getPrayerTimingsData() async {
//     http.Response response = await http.get(url, headers: {
//       "Accept": "Accept: text/html, application/xhtml+xml, application/xml;q=0.9, image/webp, */*;q=0.8"
//     });
//     final data = jsonDecode(response.body);
//
//     List = Data.fromJson(data);
//     print(List.data.timings.fajr);
//   }
//
//   }
//
//
// }