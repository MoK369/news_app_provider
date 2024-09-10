import 'package:flutter/material.dart';

class CategoryModel {
  final String id, label, imagePath;
  final Color bgColor;

  CategoryModel({
    required this.id,
    required this.label,
    required this.imagePath,
    required this.bgColor,
  });
}
