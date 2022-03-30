/// id : "tania"
/// start : "2021-01-18T04:33:12Z"
/// end : "2022-03-09T15:55:07.952Z"
/// hour : 10
/// minute : 11
/// second : 12
/// latitude : 10.123456
/// longitude : -100.123456
/// activity : "test"

class ActivityJson {
  ActivityJson({
      String? id, 
      String? start, 
      String? end, 
      int? hour, 
      int? minute, 
      int? second, 
      double? latitude, 
      double? longitude, 
      String? activity,}){
    _id = id;
    _start = start;
    _end = end;
    _hour = hour;
    _minute = minute;
    _second = second;
    _latitude = latitude;
    _longitude = longitude;
    _activity = activity;
}

  ActivityJson.fromJson(dynamic json) {
    _id = json['uuid'];
    _start = json['startTime'];
    _end = json['endTime'];
    _hour = json['hour'];
    _minute = json['minute'];
    _second = json['second'];
    _latitude = double.parse(json['latitude']);
    _longitude = double.parse(json['longitude']);
    _activity = json['activity'];
  }
  String? _id;
  String? _start;
  String? _end;
  int? _hour;
  int? _minute;
  int? _second;
  double? _latitude;
  double? _longitude;
  String? _activity;

  String? get id => _id;
  String? get start => _start;
  set setAct(String activity) => _activity = activity;
  String? get end => _end;
  int? get hour => _hour;
  int? get minute => _minute;
  int? get second => _second;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get activity => _activity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['start'] = _start;
    map['end'] = _end;
    map['hour'] = _hour;
    map['minute'] = _minute;
    map['second'] = _second;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['activity'] = _activity;
    return map;
  }

}