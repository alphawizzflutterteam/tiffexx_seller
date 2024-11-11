import 'dart:convert';

import 'package:tiffexx_seller/Helper/Constant.dart';
import 'package:tiffexx_seller/Helper/Session.dart';
import 'package:tiffexx_seller/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountDetail extends StatefulWidget {
  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  var sellerData;
bool isLoading=false;
  getSellerDetail() async {
     isLoading=true;
    setState(() {

    });

    var headers = {
      'Cookie': 'ci_session=624212ee9cda04abc249424f5061827c593f795b'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + 'get_seller_details'));
    request.fields.addAll({'id': '${CUR_USERID}'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);

        sellerData = jsonResponse['data'][0];

      isLoading=false;
      setState(() {

      });
    } else {
      print(response.reasonPhrase);
      isLoading=false;
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      return getSellerDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: getAppBar("Bank Detail", context),
      body: sellerData == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Account Holder Name",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: sellerData['account_names'] == null
                        ? Text("Not Added yet")
                        : Text("${sellerData['account_names']}"),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Account Number",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: sellerData['account_numbers'] == null
                        ? Text("Not Added yet")
                        : Text("${sellerData['account_numbers']}"),
                  ),

                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Ifsc Code",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: sellerData['ifsc_code'] == null
                        ? Text("Not Added yet")
                        : Text("${sellerData['ifsc_code']}"),
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Bank Name",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: sellerData['bank_name'] == null
                        ? Text("Not Added yet")
                        : Text("${sellerData['bank_name']}"),
                  ),         Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Account Type",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: sellerData['account_type'] == null
                        ? Text("Not Added yet")
                        : Text("${sellerData['account_type']}"),
                  ),
                ],
              ),
            ),
    );
  }
}
