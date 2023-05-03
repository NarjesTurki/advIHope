class GetPaymentMethods {
  GetPaymentMethods({
    List<GetPaymentMethodData>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetPaymentMethods.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetPaymentMethodData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  List<GetPaymentMethodData>? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetPaymentMethods copyWith({
    List<GetPaymentMethodData>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetPaymentMethods(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  List<GetPaymentMethodData>? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }
}

class GetPaymentMethodData {
  GetPaymentMethodData({
    int? id,
    String? name,
    String? description,
    String? imagePath,
    int? isActive,
    int? isDefault,
    String? code,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _imagePath = imagePath;
    _isActive = isActive;
    _isDefault = isDefault;
    _code = code;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetPaymentMethodData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _imagePath = json['image_path'];
    _isActive = json['is_active'];
    _isDefault = json['is_default'];
    _code = json['code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _description;
  String? _imagePath;
  int? _isActive;
  int? _isDefault;
  String? _code;
  String? _createdAt;
  String? _updatedAt;
  GetPaymentMethodData copyWith({
    int? id,
    String? name,
    String? description,
    String? imagePath,
    int? isActive,
    int? isDefault,
    String? code,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetPaymentMethodData(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        imagePath: imagePath ?? _imagePath,
        isActive: isActive ?? _isActive,
        isDefault: isDefault ?? _isDefault,
        code: code ?? _code,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get imagePath => _imagePath;
  int? get isActive => _isActive;
  int? get isDefault => _isDefault;
  String? get code => _code;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image_path'] = _imagePath;
    map['is_active'] = _isActive;
    map['is_default'] = _isDefault;
    map['code'] = _code;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
