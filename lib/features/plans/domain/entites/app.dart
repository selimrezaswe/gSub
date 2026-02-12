import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class AppEntity extends Equatable {
  final String? id;
  final String name;
  final String icon;
  final int createdAt;
  final int updatedAt;

  AppEntity({
    String? id,
    required this.name,
    required this.icon,
    int? createdAt,
    int? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now().microsecondsSinceEpoch,
        updatedAt = updatedAt ?? DateTime.now().microsecondsSinceEpoch;

  @override
  List<Object?> get props => [id, name, icon, createdAt, updatedAt];

  AppEntity copyWith({
    String? id,
    String? name,
    String? icon,
    int? createdAt,
    int? updatedAt,
  }) {
    return AppEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AppEntity.fromMap(Map<String, dynamic> map) {
    return AppEntity(
      id: map['id'] as String?,
      name: map['name'] as String,
      icon: map['icon'] as String,
      createdAt: map['createdAt'] is int ? map['createdAt'] as int : int.tryParse(map['createdAt'].toString()),
      updatedAt: map['updatedAt'] is int ? map['updatedAt'] as int : int.tryParse(map['updatedAt'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppEntity.fromJson(String source) =>
      AppEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}