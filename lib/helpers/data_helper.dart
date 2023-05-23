import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DataHelper with ChangeNotifier {
  //API
  static String get apiEndPoint => '127.0.0.1:8000';
  static String get apiPath => 'api/mobile';

  SharedPreferences? _pref;
  String? _deviceId;
  String? _token;
  String? supportDirectory;
  static double? _deviceSize;

  Map? _userData;

  void Function(int type)? _operationCallback;

  DataHelper() {
    _loadDevice().then((val) => notifyListeners());
  }

  Future<void> _getAppSettings() async {
    _pref = await SharedPreferences.getInstance();
  }

  /// Load information from the storage
  Future<bool> _loadDevice() async {
    //Load app settings
    _getAppSettings();

    //Locate application DIR
    var dir = await getApplicationSupportDirectory();

    supportDirectory = dir.path;

    var file = File('${dir.path}/.device');
    String content = '';

    //If file exists, read contents
    if (true == await file.exists()) {
      content = file.readAsStringSync();
    } else {
      file.create(); //Create if not exists
    }

    if (content.trim().isEmpty) {
      content = const Uuid().v4();
      file.writeAsStringSync(content); //Write generated UUID
    }

    _deviceId = content;

    var tokenFile = File('${dir.path}/token.file');

    //If file exists, read contents
    if (true == await tokenFile.exists()) {
      _token = tokenFile.readAsStringSync();
    }

    return true;
  }

  ///Get automatically generated device ID
  String getDeviceId() {
    return _deviceId ?? '';
  }

  /// Get the login token
  String getToken() {
    return _token ?? '';
  }

  Future<String> writeToken(String token) async {
    var tokenFile = File('$supportDirectory/token.file');

    if (false == await tokenFile.exists()) {
      tokenFile = await tokenFile.create();
    }

    tokenFile.openWrite();
    tokenFile.writeAsStringSync(token);

    _token = token;

    notifyListeners();
    _operationCallback?.call(0);

    return token;
  }

  /// Sets basic information of the user
  void setUserData(Map<String, dynamic> data) {
    _userData = <String, String>{};

    data.forEach((key, value) {
      _userData?[key] = value.toString();
    });
  }

  ///Sets callback which will be called when data has changed
  DataHelper setOperationCallback(void Function(int) fn) {
    _operationCallback = fn;
    return this;
  }

  /// Get basic information of user
  Map<String, String> getUserData() {
    var out = <String, String>{};

    _userData?.forEach((key, value) {
      out[key] = value;
    });

    return out;
  }

  /// Get first name of logged in user
  String getFirstName() {
    return _userData?['firstName'] ?? '';
  }

  /// Get last name of logged in user
  String getLastName() {
    return _userData?['lastName'] ?? '';
  }

  /// Get timezone of the server
  String get timezone {
    return _userData?['tz'] ?? 'UTC';
  }

  /// Get UTC difference
  String get tzDiff {
    return _userData?['zDiff'] ?? 'Z';
  }

  /// Get image of user
  Uint8List? getImage() {
    if (_userData?['image'] != null) {
      return base64Decode(_userData?['image']);
    }

    return null;
  }

  void setImage(Uint8List data) {
    _userData?['image'] = base64Encode(data);
  }

  Future<void> logout() async {
    var tokenFile = File('$supportDirectory/token.file');

    //If file exists, read contents
    if (true == await tokenFile.exists()) {
      try {
        await tokenFile.delete();
      } catch (e) {
        //Catch
      }
    }

    _token = "";
  }

  static double getDeviceSize(BuildContext context) {
    _deviceSize ??= MediaQuery.of(context).size.width;

    return _deviceSize!;
  }

  static double getPropotion(BuildContext context) {
    return getDeviceSize(context) < 600 ? 0.8 : 1;
  }

  ///Get settings from the Preferences
  T? getSetting<T>(String key) {
    if (_pref?.containsKey(key) == false) {
      return null;
    }

    return _pref?.get(key) as T;
  }

  SharedPreferences? getPrefManager() {
    return _pref;
  }
}
