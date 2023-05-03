import 'package:flutter/material.dart';

sendSMSRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    if (response['Status'].toString() == 'true') {
    } else {}
  } else if (!responseCheck) {}
}
