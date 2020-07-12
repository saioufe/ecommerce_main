import 'package:flutter/material.dart';

class Address {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String country;
  final String city;
  final bool isSelected;

  Address(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.country,
      this.city,
      this.isSelected});
}
