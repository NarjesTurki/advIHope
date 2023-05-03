class MentorProfileGenericDataModel {
  MentorProfileGenericDataModel({
    bool? status,
    int? success,
    MentorProfileGenericDataModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  MentorProfileGenericDataModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? MentorProfileGenericDataModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  MentorProfileGenericDataModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  MentorProfileGenericDataModelData? get data => _data;
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

class MentorProfileGenericDataModelData {
  MentorProfileGenericDataModelData({
    List<Occupations>? occupations,
    List<Degrees>? degrees,
    List<Banks>? banks,
    List<Countries>? countries,
  }) {
    _occupations = occupations;
    _degrees = degrees;
    _banks = banks;
    _countries = countries;
  }

  MentorProfileGenericDataModelData.fromJson(dynamic json) {
    if (json['occupations'] != null) {
      _occupations = [];
      json['occupations'].forEach((v) {
        _occupations?.add(Occupations.fromJson(v));
      });
    }
    if (json['degrees'] != null) {
      _degrees = [];
      json['degrees'].forEach((v) {
        _degrees?.add(Degrees.fromJson(v));
      });
    }
    if (json['banks'] != null) {
      _banks = [];
      json['banks'].forEach((v) {
        _banks?.add(Banks.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Countries.fromJson(v));
      });
    }
  }
  List<Occupations>? _occupations;
  List<Degrees>? _degrees;
  List<Banks>? _banks;
  List<Countries>? _countries;

  List<Occupations>? get occupations => _occupations;
  List<Degrees>? get degrees => _degrees;
  List<Banks>? get banks => _banks;
  List<Countries>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_occupations != null) {
      map['occupations'] = _occupations?.map((v) => v.toJson()).toList();
    }
    if (_degrees != null) {
      map['degrees'] = _degrees?.map((v) => v.toJson()).toList();
    }
    if (_banks != null) {
      map['banks'] = _banks?.map((v) => v.toJson()).toList();
    }
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Countries {
  Countries({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Countries.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

class Banks {
  Banks({
    int? id,
    String? name,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Banks.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Degrees {
  Degrees({
    int? id,
    String? name,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Degrees.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Occupations {
  Occupations({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Occupations.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class CitiesByIdModel {
  CitiesByIdModel({
    bool? status,
    int? success,
    CitiesByIdModelData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  CitiesByIdModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? CitiesByIdModelData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  CitiesByIdModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  CitiesByIdModelData? get data => _data;
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

class CitiesByIdModelData {
  CitiesByIdModelData({
    List<Cities>? cities,
  }) {
    _cities = cities;
  }

  CitiesByIdModelData.fromJson(dynamic json) {
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
  }
  List<Cities>? _cities;

  List<Cities>? get cities => _cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Cities {
  Cities({
    int? id,
    String? name,
    int? countryId,
  }) {
    _id = id;
    _name = name;
    _countryId = countryId;
  }

  Cities.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
  }
  int? _id;
  String? _name;
  int? _countryId;

  int? get id => _id;
  String? get name => _name;
  int? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    return map;
  }
}
