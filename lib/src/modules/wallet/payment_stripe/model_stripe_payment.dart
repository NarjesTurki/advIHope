class ModelStripePayment {
  ModelStripePayment({
    dynamic headers,
    Original? original,
    dynamic exception,
  }) {
    _headers = headers;
    _original = original;
    _exception = exception;
  }

  ModelStripePayment.fromJson(dynamic json) {
    _headers = json['headers'];
    _original =
        json['original'] != null ? Original.fromJson(json['original']) : null;
    _exception = json['exception'];
  }
  dynamic _headers;
  Original? _original;
  dynamic _exception;

  dynamic get headers => _headers;
  Original? get original => _original;
  dynamic get exception => _exception;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['headers'] = _headers;
    if (_original != null) {
      map['original'] = _original?.toJson();
    }
    map['exception'] = _exception;
    return map;
  }
}

class Original {
  Original({
    bool? status,
    int? success,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _msg = msg;
  }

  Original.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['success'] = _success;
    map['msg'] = _msg;
    return map;
  }
}
