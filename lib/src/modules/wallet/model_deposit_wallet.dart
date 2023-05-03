class DepositWalletModel {
  DepositWalletModel({
    bool? status,
    int? success,
    DepositWalletModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  DepositWalletModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? DepositWalletModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  DepositWalletModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  DepositWalletModelData? get data => _data;
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

class DepositWalletModelData {
  DepositWalletModelData({
    DepositTransactionModel? transaction,
  }) {
    _transaction = transaction;
  }

  DepositWalletModelData.fromJson(dynamic json) {
    _transaction = json['transaction'] != null
        ? DepositTransactionModel.fromJson(json['transaction'])
        : null;
  }
  DepositTransactionModel? _transaction;

  DepositTransactionModel? get transaction => _transaction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transaction != null) {
      map['transaction'] = _transaction?.toJson();
    }
    return map;
  }
}

class DepositTransactionModel {
  DepositTransactionModel({
    String? uuid,
    String? payableType,
    int? payableId,
    int? walletId,
    String? type,
    String? amount,
    bool? confirmed,
    dynamic meta,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) {
    _uuid = uuid;
    _payableType = payableType;
    _payableId = payableId;
    _walletId = walletId;
    _type = type;
    _amount = amount;
    _confirmed = confirmed;
    _meta = meta;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  DepositTransactionModel.fromJson(dynamic json) {
    _uuid = json['uuid'];
    _payableType = json['payable_type'];
    _payableId = json['payable_id'];
    _walletId = json['wallet_id'];
    _type = json['type'];
    _amount = json['amount'];
    _confirmed = json['confirmed'];
    _meta = json['meta'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _uuid;
  String? _payableType;
  int? _payableId;
  int? _walletId;
  String? _type;
  String? _amount;
  bool? _confirmed;
  dynamic _meta;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get uuid => _uuid;
  String? get payableType => _payableType;
  int? get payableId => _payableId;
  int? get walletId => _walletId;
  String? get type => _type;
  String? get amount => _amount;
  bool? get confirmed => _confirmed;
  dynamic get meta => _meta;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
    map['payable_type'] = _payableType;
    map['payable_id'] = _payableId;
    map['wallet_id'] = _walletId;
    map['type'] = _type;
    map['amount'] = _amount;
    map['confirmed'] = _confirmed;
    map['meta'] = _meta;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
