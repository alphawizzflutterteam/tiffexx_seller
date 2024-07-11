import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tiffexx_seller/Helper/String.dart';
import 'package:tiffexx_seller/Model/SubsPlanModel.dart';
import 'package:tiffexx_seller/Model/SubsUsersModel.dart';

class SubsProvider with ChangeNotifier {
  bool isLoading = false;
  bool visible = false;
  setVisiblity() {
    visible = !visible;
    notifyListeners();
  }

  setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  setStatus(String status) {
    selectedStatus = status;
    notifyListeners();
  }

  final List<Map<String, String>> status = [
    {
      'key': '1',
      'val': 'Pending',
    },
    {
      'key': '2',
      'val': 'In Progress',
    },
    {
      'key': '3',
      'val': 'Picked Up',
    },
    {
      'key': '4',
      'val': ' On The way',
    },
    {
      'key': '5',
      'val': 'Delivered',
    },
    {
      'key': '6',
      'val': 'Leave',
    },
  ];
  String selectedStatus = '';
  List<PlanData> plans = [];
  List<SubsUsersData> users = [];
  List<SubsUsersData> pausedPlans = [];
  Future<void> getPlans() async {
    try {
      plans.clear();
      setLoading(true);
      var request = http.MultipartRequest('POST', getSubsPlans);
      request.fields.addAll({'user_id': CUR_USERID.toString()});

      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        SubsPlanModel data = SubsPlanModel.fromJson(json);
        plans.addAll(data.data);
        print(plans.length);
        setLoading(false);
      } else {
        setLoading(false);
        print(response.reasonPhrase);
      }
    } catch (e, st) {
      print(st);
      throw Exception(e);
    }
  }

  Future<void> getSubsUsers() async {
    try {
      users.clear();
      setLoading(true);
      var request = http.MultipartRequest('POST', SubsUsers);
      request.fields.addAll({'user_id': CUR_USERID.toString()});

      http.StreamedResponse response = await request.send();
      debugPrint(request.url.toString());
      debugPrint(request.fields.toString());
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        SubsUsersModel data = SubsUsersModel.fromJson(json);
        users.addAll(data.data);
        print(users.length);
        setLoading(false);
      } else {
        setLoading(false);
        print(response.reasonPhrase);
      }
    } catch (e, st) {
      print(st);
      throw Exception(e);
    }
  }
  Future<void> getSubsUsersPaused(String value) async {
    try {
      pausedPlans.clear();
      setLoading(true);
      var request = http.MultipartRequest('POST', SubsUsersPaused);
      request.fields.addAll({'user_id': CUR_USERID.toString(),'type' : value=='1' ? '' :  'pause'});

      http.StreamedResponse response = await request.send();
      debugPrint(request.url.toString());
      debugPrint(request.fields.toString());
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        SubsUsersModel data = SubsUsersModel.fromJson(json);
        pausedPlans.addAll(data.data);
        print(pausedPlans.length);
        setLoading(false);
      } else {
        setLoading(false);
        print(response.reasonPhrase);
      }
    } catch (e, st) {
      print(st);
      throw Exception(e);
    }
  }

  Future<bool> updateOrderStatus({
    required String subsId,
    required String date,
  }) async {
    try {
      setLoading(true);
      var request = http.MultipartRequest('POST', UpdatePlanStatus);
      request.fields.addAll({
        'subscription_id': subsId,
        'date': date,
        'status': selectedStatus,
      });
      print(request.fields);
      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200 && json['status']) {
        setLoading(false);
        Fluttertoast.showToast(msg: json['message']);
        return true;
      } else {
        Fluttertoast.showToast(msg: json['message']);
        setLoading(false);
        return false;
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
