import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes_flutter/api/settings.dart';
import 'package:jokes_flutter/model/Profile.dart';

Future<Profile> fetchProfile() async {
  final response = await http.get('${API.USERS_BASE_URL}');
  if (response.statusCode == 200) {
    return Profile.fromJson(json.decode(response.body)['results'][0]);
  } else {
    throw Exception('Failed to load profile :(');
  }
}