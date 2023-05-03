class GetAllTransactionModel {
  GetAllTransactionModel({
    bool? status,
    int? success,
    GetAllTransactionModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetAllTransactionModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetAllTransactionModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetAllTransactionModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetAllTransactionModelData? get data => _data;
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

class GetAllTransactionModelData {
  GetAllTransactionModelData({
    List<TransactionsModel>? transactions,
  }) {
    _transactions = transactions;
  }

  GetAllTransactionModelData.fromJson(dynamic json) {
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(TransactionsModel.fromJson(v));
      });
    }
  }
  List<TransactionsModel>? _transactions;

  List<TransactionsModel>? get transactions => _transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TransactionsModel {
  TransactionsModel({
    int? id,
    String? payableType,
    int? payableId,
    int? walletId,
    String? type,
    String? amount,
    bool? confirmed,
    dynamic meta,
    String? uuid,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _payableType = payableType;
    _payableId = payableId;
    _walletId = walletId;
    _type = type;
    _amount = amount;
    _confirmed = confirmed;
    _meta = meta;
    _uuid = uuid;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  TransactionsModel.fromJson(dynamic json) {
    _id = json['id'];
    _payableType = json['payable_type'];
    _payableId = json['payable_id'];
    _walletId = json['wallet_id'];
    _type = json['type'];
    _amount = json['amount'];
    _confirmed = json['confirmed'];
    _meta = json['meta'];
    _uuid = json['uuid'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _payableType;
  int? _payableId;
  int? _walletId;
  String? _type;
  String? _amount;
  bool? _confirmed;
  dynamic _meta;
  String? _uuid;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get payableType => _payableType;
  int? get payableId => _payableId;
  int? get walletId => _walletId;
  String? get type => _type;
  String? get amount => _amount;
  bool? get confirmed => _confirmed;
  dynamic get meta => _meta;
  String? get uuid => _uuid;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['payable_type'] = _payableType;
    map['payable_id'] = _payableId;
    map['wallet_id'] = _walletId;
    map['type'] = _type;
    map['amount'] = _amount;
    map['confirmed'] = _confirmed;
    map['meta'] = _meta;
    map['uuid'] = _uuid;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
