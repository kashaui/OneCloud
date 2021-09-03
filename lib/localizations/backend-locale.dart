import 'dart:convert';

import 'package:flutter/material.dart';

class BackendLocale {
  BackendLocale({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.language = 'en',
    this.lines,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String language;
  final Map<String, String> lines;

  factory BackendLocale.fromRawJson(String str) => BackendLocale.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BackendLocale.fromJson(Map<String, dynamic> json, [Map<String, dynamic> lines]) {
    final langLines = lines ?? json['lines'];
    return BackendLocale(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      language: json["language"],
      lines: langLines == null ? null : Map.from(langLines),
    );
  }

  Locale toFlutterLocale() {
    return Locale(language);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "language": language,
    "lines": lines,
  };
}