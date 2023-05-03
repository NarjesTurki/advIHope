class RatingExistModel {
  RatingExistModel({
    bool? status,
    int? success,
    RatingDetails? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  RatingExistModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? RatingDetails.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  RatingDetails? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  RatingDetails? get data => _data;
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

class RatingDetails {
  RatingDetails({
    bool? ratingExist,
  }) {
    _ratingExist = ratingExist;
  }

  RatingDetails.fromJson(dynamic json) {
    _ratingExist = json['ratingExist'];
  }
  bool? _ratingExist;

  bool? get ratingExist => _ratingExist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ratingExist'] = _ratingExist;
    return map;
  }
}
