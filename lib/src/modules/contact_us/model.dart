class ContactUsModel {
  ContactUsModel({
    bool? status,
    int? success,
    ContactUsModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  ContactUsModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data =
        json['data'] != null ? ContactUsModelData.fromJson(json['data']) : null;
    _msg = json['msg'];
  }

  bool? _status;
  int? _success;
  ContactUsModelData? _data;
  String? _msg;

  bool? get status => _status;

  int? get success => _success;

  ContactUsModelData? get data => _data;

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

class ContactUsModelData {
  ContactUsModelData({
    int? contactus,
  }) {
    _contactus = contactus;
  }

  ContactUsModelData.fromJson(dynamic json) {
    _contactus = json['contactus'];
  }

  int? _contactus;

  int? get contactus => _contactus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactus'] = _contactus;
    return map;
  }
}
