import 'package:flutter/material.dart';

class TaskCreateModel {
  int index;
  TextEditingController controller;
  DateTime dateTime;

  TaskCreateModel({
    required this.index,
    required this.controller,
    required this.dateTime,
  });
}
