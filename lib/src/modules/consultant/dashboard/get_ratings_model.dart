class GetRatingsModel {
  GetRatingsModel({
      bool? status, 
      int? success,
    MentorRatingData? data,
      String? msg,}){
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
}

  GetRatingsModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? MentorRatingData.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  MentorRatingData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  MentorRatingData? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['msg'] = _msg;
    return map;
  }

}

class MentorRatingData {
  MentorRatingData({
      int? totalRatings, 
      int? avgRatings,
      int? fiveRatings,
      int? fourRatings, 
      int? threeRatings, 
      int? twoRatings, 
      int? oneRatings,}){
    _totalRatings = totalRatings;
    _avgRatings = avgRatings;
    _fiveRatings = fiveRatings;
    _fourRatings = fourRatings;
    _threeRatings = threeRatings;
    _twoRatings = twoRatings;
    _oneRatings = oneRatings;
}

  MentorRatingData.fromJson(dynamic json) {
    _totalRatings = json['totalRatings'];
    _avgRatings = json['avgRatings'];
    _fiveRatings = json['fiveRatings'];
    _fourRatings = json['fourRatings'];
    _threeRatings = json['threeRatings'];
    _twoRatings = json['twoRatings'];
    _oneRatings = json['oneRatings'];
  }
  int? _totalRatings;
  int? _avgRatings;
  int? _fiveRatings;
  int? _fourRatings;
  int? _threeRatings;
  int? _twoRatings;
  int? _oneRatings;

  int? get totalRatings => _totalRatings;
  int? get avgRatings => _avgRatings;
  int? get fiveRatings => _fiveRatings;
  int? get fourRatings => _fourRatings;
  int? get threeRatings => _threeRatings;
  int? get twoRatings => _twoRatings;
  int? get oneRatings => _oneRatings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalRatings'] = _totalRatings;
    map['avgRatings'] = _avgRatings;
    map['fiveRatings'] = _fiveRatings;
    map['fourRatings'] = _fourRatings;
    map['threeRatings'] = _threeRatings;
    map['twoRatings'] = _twoRatings;
    map['oneRatings'] = _oneRatings;
    return map;
  }

}