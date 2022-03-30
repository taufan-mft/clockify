import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clockify/constants.dart' as constant;

import 'ActivityJson.dart';

class ActivityState extends ChangeNotifier {
  late SharedPreferences _prefs;
  Map<String, String> _networkHeader = {};
  List<ActivityJson> activitiesList = [];
  final baseUrl = 'https://e944-2001-448a-3020-5743-20a2-8e44-2810-ad63.ngrok.io';

  _getHeader() async {
    _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    if (token == null) {
      _networkHeader =  {"Content-Type": "application/json"};
      return;
    }
    token = 'Bearer $token';
    log('the token $token' );
    var headers = {"Content-Type": "application/json", "Authorization": token};
    log('the header ${headers} $token');
    _networkHeader = headers;
  }

  _doGet(String path) async {
    return http.get(Uri.parse(baseUrl + path), headers: _networkHeader);
  }
  
  _do(String path, String body) async {
    return http.delete(Uri.parse(baseUrl + path), headers: _networkHeader, body: body);
  }

  _doPost(String path, String body) async {
    // if (_networkHeader == {}) {
    //   await _getHeader();
    // }
    log('header $_networkHeader');
    return http.post(Uri.parse(baseUrl + path), headers: _networkHeader, body: body);
  }

  _doPut(String path, String body) async {
    return http.put(Uri.parse(baseUrl + path), headers: _networkHeader, body: body);
  }

  _doDelete(String path, String body) async {
    return http.delete(Uri.parse(baseUrl + path), headers: _networkHeader, body: body);
  }

  _addToken(String token) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
    await _prefs.setBool(constant.loggedInKey, true);
    _networkHeader = await _getHeader();
  }

  Future<bool> login(String username, String password) async {
    final payload = {
      "email": username.trim(),
      "password": password.trim(),
    };
    log('the payload: ${payload.toString()}');
    final result = await _doPost('/user/login', jsonEncode(payload));
    var d = jsonDecode(result.body);
    log(d.toString());

    if (d.containsKey('data')) {
      log('aku disini ${(d['data'].containsKey('token'))}');
      if (d['data'].containsKey('token')) {
        _addToken(d['data']['token']);
        _prefs.setBool(constant.loggedInKey, true);
        fetchActivities();
        return true;
      }
    } else {
      return false;
    }
    return false;
  }
  
  Future<bool> signUp(String username, String password) async {
    final payload = {
      "email": username,
      "password": password,
    };
    log('payload: ${jsonEncode(payload)}');
    final result = await _doPost('/user/signUp', jsonEncode(payload));
    log(result.body);
    return true;
  }
  
  Future<bool> sendActivity(ActivityJson activity) async {
    log(jsonEncode(activity.toJson()));
    http.Response result = await _doPost('/api/create', jsonEncode(activity.toJson()));
    log(result.body);
    if ( 199 < result.statusCode && result.statusCode < 300) {
      fetchActivities();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateActivity(ActivityJson activity) async {
    final payload = {
        "id": activity.id,
        "name": activity.activity,
    };
    http.Response result = await _doPut('/api/update', jsonEncode(payload));
    if ( 200 < result.statusCode && result.statusCode < 300) {
      fetchActivities();
      return true;
    } else {
      return false;
    }
  }
  
  Future<bool> deleteActivity(String id) async {
    final payload = {
      "id": id,
    };
    final result = await _doDelete('/api/delete', jsonEncode(payload));
    log('delete');
    log(result.body);
    fetchActivities();
    return true;
  }

  Future<List<ActivityJson>> fetchActivities() async {
    final result = await _doGet('/api/all');
    log('tan ${result.body}');
    Iterable d = jsonDecode(result.body)['data'];
    activitiesList = List<ActivityJson>.from(
        d.map((model) => ActivityJson.fromJson(model)));
    log(activitiesList.toString());
    notifyListeners();
    return activitiesList;
  }
  
  logout() {
    _prefs.setBool(constant.loggedInKey, false);
  }

  ActivityState() {
    log('TANIA CALLEDD');
    _getHeader();
  }
}