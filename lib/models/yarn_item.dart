
import 'package:flutter/material.dart';

class YarnItem {
  final String name;
  final String brand;
  final String colorName;
  int quantity;
  final String unit;
  final String category;
  final Color color;

  YarnItem({
    required this.name,
    required this.brand,
    required this.colorName,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.color,
  });
}
