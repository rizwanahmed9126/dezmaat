
class PrayerTimingModel{
  String prayerName;
  String prayerId;
  int prayerTimeEpoch;
  String date;
  String location;
  String country;
  String continent;

  PrayerTimingModel({this.location, this.continent, this.country, this.date,
  this.prayerId, this.prayerName, this.prayerTimeEpoch});
}

PrayerTimingModel prayerTimingModel = PrayerTimingModel();