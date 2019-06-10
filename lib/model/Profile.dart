import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

class Profile {
  final String lastName;
  final String firstName;
  final String gender;
  final String phone;
  final String email;
  final DateTime dateOfBirth;
  final ImageProvider avatar;

  Profile(
      {this.firstName,
      this.lastName,
      this.gender,
      this.phone,
      this.email,
      this.dateOfBirth,
      this.avatar});

  factory Profile.fromJson(json) {
    if (json == null) {
      return null;
    } else {
      return new Profile(
        lastName: capitalize(json['name']['last']),
        firstName: capitalize(json['name']['first']),
        gender: json['gender'],
        phone: json['phone'],
        email: json['email'],
        dateOfBirth: DateTime.parse(json['dob']['date']),
        avatar: NetworkImage(json['picture']['large']),
      );
    }
  }
}
