import 'dart:convert';

import 'dart:ui';

class BackendThemeConfig {
  BackendThemeConfig({
    this.id,
    this.name,
    this.isDark,
    this.defaultLight,
    this.defaultDark,
    this.userId,
    this.colors,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  bool isDark;
  bool defaultLight;
  bool defaultDark;
  int userId;
  Map<String, Color> colors;
  DateTime createdAt;
  DateTime updatedAt;

  factory BackendThemeConfig.fromRawJson(String str) => BackendThemeConfig.fromJson(json.decode(str));

  factory BackendThemeConfig.fromJson(Map<String, dynamic> json) => BackendThemeConfig(
    id: json["id"],
    name: json["name"],
    isDark: json["is_dark"],
    defaultLight: json["default_light"],
    defaultDark: json["default_dark"],
    userId: json["user_id"],
    colors: Map.from(json["colors"]).map((k, v) {
      return MapEntry<String, Color>(k, Color.fromRGBO(v[0], v[1], v[2], v[3].toDouble()));
    }),
    createdAt: json["created_at"] == null ? DateTime.now() : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? DateTime.now() : DateTime.parse(json["updated_at"]),
  );
}

class BackendThemeColors {
  BackendThemeColors({
    this.bePrimaryLighter,
    this.bePrimaryDefault,
    this.bePrimaryDarker,
    this.beAccentDefault,
    this.beAccentLighter,
    this.beAccentContrast,
    this.beAccentEmphasis,
    this.beForegroundBase,
    this.beText,
    this.beHintText,
    this.beSecondaryText,
    this.beLabel,
    this.beBackground,
    this.beBackgroundAlternative,
    this.beDividerLighter,
    this.beDividerDefault,
    this.beDisabledButtonText,
    this.beDisabledToggle,
    this.beChip,
    this.beHover,
    this.beSelectedButton,
    this.beDisabledButton,
    this.beRaisedButton,
    this.beBackdrop,
    this.beLink,
  });

  List<int> bePrimaryLighter;
  List<int> bePrimaryDefault;
  List<int> bePrimaryDarker;
  List<int> beAccentDefault;
  List<int> beAccentLighter;
  List<int> beAccentContrast;
  List<int> beAccentEmphasis;
  List<int> beForegroundBase;
  List<int> beText;
  List<int> beHintText;
  List<int> beSecondaryText;
  List<int> beLabel;
  List<int> beBackground;
  List<int> beBackgroundAlternative;
  List<int> beDividerLighter;
  List<int> beDividerDefault;
  List<int> beDisabledButtonText;
  List<int> beDisabledToggle;
  List<int> beChip;
  List<int> beHover;
  List<int> beSelectedButton;
  List<int> beDisabledButton;
  List<int> beRaisedButton;
  List<int> beBackdrop;
  List<int> beLink;

  factory BackendThemeColors.fromRawJson(String str) => BackendThemeColors.fromJson(json.decode(str));

  factory BackendThemeColors.fromJson(Map<String, dynamic> json) => BackendThemeColors(
    bePrimaryLighter: json["--be-primary-lighter"],
    bePrimaryDefault: json["--be-primary-default"],
    bePrimaryDarker: json["--be-primary-darker"],
    beAccentDefault: json["--be-accent-default"],
    beAccentLighter: json["--be-accent-lighter"],
    beAccentContrast: json["--be-accent-contrast"],
    beAccentEmphasis: json["--be-accent-emphasis"],
    beForegroundBase: json["--be-foreground-base"],
    beText: json["--be-text"],
    beHintText: json["--be-hint-text"],
    beSecondaryText: json["--be-secondary-text"],
    beLabel: json["--be-label"],
    beBackground: json["--be-background"],
    beBackgroundAlternative: json["--be-background-alternative"],
    beDividerLighter: json["--be-divider-lighter"],
    beDividerDefault: json["--be-divider-default"],
    beDisabledButtonText: json["--be-disabled-button-text"],
    beDisabledToggle: json["--be-disabled-toggle"],
    beChip: json["--be-chip"],
    beHover: json["--be-hover"],
    beSelectedButton: json["--be-selected-button"],
    beDisabledButton: json["--be-disabled-button"],
    beRaisedButton: json["--be-raised-button"],
    beBackdrop: json["--be-backdrop"],
    beLink: json["--be-link"],
  );
}
