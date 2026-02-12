// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  final String id;
  final String appid;
  final String categoryid;
  final PaymentCycle paymentCycle;
  final int subscriptionDate;
  final double subscriptionCost;
  final SubscriptionReminder subscriptionReminder;
  final String details;

  const Plan({
    required this.id,
    required this.appid,
    required this.categoryid,
    required this.paymentCycle,
    required this.subscriptionDate,
    required this.subscriptionCost,
    required this.subscriptionReminder,
    required this.details,
  });

  @override
  List<Object?> get props => [
        id,
        appid,
        categoryid,
        paymentCycle,
        subscriptionCost,
        subscriptionDate,
        subscriptionReminder,
        details,
      ];

  Plan copyWith({
    String? id,
    String? appid,
    String? categoryid,
    PaymentCycle? paymentCycle,
    int? subscriptionDate,
    double? subscriptionCost,
    SubscriptionReminder? subscriptionReminder,
    String? details,
  }) {
    return Plan(
      id: id ?? this.id,
      appid: appid ?? this.appid,
      categoryid: categoryid ?? this.categoryid,
      paymentCycle: paymentCycle ?? this.paymentCycle,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
      subscriptionCost: subscriptionCost ?? this.subscriptionCost,
      subscriptionReminder: subscriptionReminder ?? this.subscriptionReminder,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'appid': appid,
      'categoryid': categoryid,
      // Store the enum as string
      'paymentCycle': paymentCycle.toShortString(),
      'subscriptionDate': subscriptionDate,
      'subscriptionCost': subscriptionCost,
      'subscriptionReminder': subscriptionReminder.toShortString(),
      'details': details,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'] as String,
      appid: map['appid'] as String,
      categoryid: map['categoryid'] as String,
      paymentCycle: PaymentCycleExt.fromString(map['paymentCycle'] as String),
      subscriptionDate: map['subscriptionDate'] as int,
      subscriptionCost: map['subscriptionCost'] is int
          ? (map['subscriptionCost'] as int).toDouble()
          : map['subscriptionCost'] as double,
      subscriptionReminder: SubscriptionReminderExt.fromString(map['subscriptionReminder'] as String),
      details: map['details'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) => Plan.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum PaymentCycle {
  daily,
  weekly,
  monthly,
  yearly,
  trial
}

extension PaymentCycleExt on PaymentCycle {
  String toShortString() {
    return toString().split('.').last;
  }

  static PaymentCycle fromString(String value) {
    switch (value) {
      case 'daily':
        return PaymentCycle.daily;
      case 'weekly':
        return PaymentCycle.weekly;
      case 'monthly':
        return PaymentCycle.monthly;
      case 'yearly':
        return PaymentCycle.yearly;
      default:
        throw Exception('Unknown PaymentCycle value: $value');
    }
  }

   String capitalize() {
    final str = toShortString();
    if (str.isEmpty) return str;
    return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
  }
}

enum SubscriptionReminder {
  oneDayBefore,
  twoDaysBefore,
  threeDaysBefore,
  oneWeekBefore,
  none
}




extension SubscriptionReminderExt on SubscriptionReminder {
  String toShortString() {
    switch (this) {
      case SubscriptionReminder.oneDayBefore:
        return '1 day before';
      case SubscriptionReminder.twoDaysBefore:
        return '2 days before';
      case SubscriptionReminder.threeDaysBefore:
        return '3 days before';
      case SubscriptionReminder.oneWeekBefore:
        return '1 week before';
      case SubscriptionReminder.none:
        return 'None';
    }
  }

  static SubscriptionReminder fromString(String value) {
    switch (value) {
      case 'oneDayBefore':
        return SubscriptionReminder.oneDayBefore;
      case 'twoDaysBefore':
        return SubscriptionReminder.twoDaysBefore;
      case 'threeDaysBefore':
        return SubscriptionReminder.threeDaysBefore;
      case 'oneWeekBefore':
        return SubscriptionReminder.oneWeekBefore;
      default:
        throw Exception('Unknown SubscriptionReminder value: $value');
    }
  }
}