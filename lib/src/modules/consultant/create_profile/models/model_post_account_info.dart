class AccountInfoPostModel {
  AccountInfoPostModel({
    bool? status,
    int? success,
    AccountInfoPostModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  AccountInfoPostModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? AccountInfoPostModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  AccountInfoPostModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  AccountInfoPostModelData? get data => _data;
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

class AccountInfoPostModelData {
  AccountInfoPostModelData({
    Card? card,
  }) {
    _card = card;
  }

  AccountInfoPostModelData.fromJson(dynamic json) {
    _card = json['card'] != null ? Card.fromJson(json['card']) : null;
  }
  Card? _card;

  Card? get card => _card;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    return map;
  }
}

class Card {
  Card({
    String? cardTitle,
    String? cardNumber,
    String? cvv,
    String? mentorId,
    int? id,
  }) {
    _cardTitle = cardTitle;
    _cardNumber = cardNumber;
    _cvv = cvv;
    _mentorId = mentorId;
    _id = id;
  }

  Card.fromJson(dynamic json) {
    _cardTitle = json['card_title'];
    _cardNumber = json['card_number'].toString();
    _cvv = json['cvv'].toString();
    _mentorId = json['mentor_id'].toString();
    _id = json['id'];
  }
  String? _cardTitle;
  String? _cardNumber;
  String? _cvv;
  String? _mentorId;
  int? _id;

  String? get cardTitle => _cardTitle;
  String? get cardNumber => _cardNumber;
  String? get cvv => _cvv;
  String? get mentorId => _mentorId;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['card_title'] = _cardTitle;
    map['card_number'] = _cardNumber;
    map['cvv'] = _cvv;
    map['mentor_id'] = _mentorId;
    map['id'] = _id;
    return map;
  }
}
