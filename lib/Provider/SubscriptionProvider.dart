import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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

  List<PlanData> plans = [];
  List<SubsUsersData> users = [];
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
}
