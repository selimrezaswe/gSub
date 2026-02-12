import 'package:flutter/material.dart';

class Subscription {
  final String name;
  final double amount;
  final String icon;
  final Color color;

  const Subscription({
    required this.name,
    required this.amount,
    required this.icon,
    required this.color,
  });
}
