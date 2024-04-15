import 'package:flutter/cupertino.dart';

class MyPriceEntity {
  final TextEditingController controller;
  final String name;
  final String? image;
  final int method;

  MyPriceEntity({
    required this.controller,
    required this.name,
    this.image,
    required this.method,
  });
}
