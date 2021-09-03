import 'dart:convert';

import 'package:bedrive/drive/state/file-entry/file-entry.dart';

class ShareableLink {
  ShareableLink({
    this.id,
    this.hash,
    this.userId,
    this.entryId,
    this.allowEdit,
    this.allowDownload,
    this.password,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    this.singleUse,
    this.entry,
  });

  final int id;
  final String hash;
  final int userId;
  final int entryId;
  final bool allowEdit;
  final bool allowDownload;
  final String password;
  DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int singleUse;
  final FileEntry entry;

  factory ShareableLink.fromRawJson(String str) => ShareableLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShareableLink.fromJson(Map<String, dynamic> json) => ShareableLink(
    id: json["id"],
    hash: json["hash"],
    userId: json["user_id"],
    entryId: json["entry_id"],
    allowEdit: json["allow_edit"],
    allowDownload: json["allow_download"],
    password: json["password"] == null ? null : 'password',
    expiresAt: json["expires_at"] != null ? DateTime.parse(json["expires_at"]) : null,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    singleUse: json["single_use"],
    entry: json['entry'] != null ? FileEntry.fromJson(json["entry"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hash": hash,
    "user_id": userId,
    "entry_id": entryId,
    "allow_edit": allowEdit,
    "allow_download": allowDownload,
    "password": password,
    "expires_at": expiresAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "single_use": singleUse,
    "entry": entry.toJson(),
  };
}