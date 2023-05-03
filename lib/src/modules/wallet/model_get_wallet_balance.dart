class GetWalletBalanceModel {
  GetWalletBalanceModel({
    bool? status,
    int? success,
    GetWalletBalanceModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  GetWalletBalanceModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? GetWalletBalanceModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetWalletBalanceModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetWalletBalanceModelData? get data => _data;
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

class GetWalletBalanceModelData {
  GetWalletBalanceModelData({
    String? userBalance,
  }) {
    _userBalance = userBalance;
  }

  GetWalletBalanceModelData.fromJson(dynamic json) {
    _userBalance = json['userBalance'];
  }
  String? _userBalance;

  String? get userBalance => _userBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userBalance'] = _userBalance;
    return map;
  }
}
