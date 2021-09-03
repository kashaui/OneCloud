import 'dart:io';
import 'package:device_info/device_info.dart';

Future<String> deviceIdentifier() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    return (await deviceInfo.iosInfo).name;
  } else {
    return (await deviceInfo.androidInfo).display;
  }
}