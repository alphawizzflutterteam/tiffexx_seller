import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:tiffexx_seller/Helper/Session.dart';
import 'package:tiffexx_seller/Helper/String.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Helper/Constant.dart';
import '../../Model/RestaurantListModel.dart';

class RestaurantReport extends StatefulWidget {
  const RestaurantReport({Key? key}) : super(key: key);

  @override
  State<RestaurantReport> createState() => _RestaurantReportState();
}

class _RestaurantReportState extends State<RestaurantReport> with SingleTickerProviderStateMixin{
  RestaurantListModel? restaurantListModell;
  RestaurantListModel? tiffinListModel;
  List<Rows> tiffinReportList = [];
  List<Rows> orderReportList = [];

  getRestaurantResports() async {
    var headers = {
      'Cookie': 'ci_session=2991faecda9f11bb27075abcabcecdbbcbdf589c'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}get_resturant_report'));
    request.fields.addAll({'seller_id': '${CUR_USERID}'});
    request.headers.addAll(headers);
    print(
        "dddddddddd ${baseUrl}get_resturant_report       and ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
          RestaurantListModel.fromJson(json.decode(finalResult));
      setState(() {

        restaurantListModell = jsonResponse;
        orderReportList = restaurantListModell?.rows ?? [];
        orderReportList = orderReportList.reversed.toList();
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getRestaurantTiffinReports() async {
    var headers = {
      'Cookie': 'ci_session=2991faecda9f11bb27075abcabcecdbbcbdf589c'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}get_resturant_subscription_report'));
    request.fields.addAll({'seller_id': '${CUR_USERID}'});
    request.headers.addAll(headers);
    print(
        "dddddddddd ${baseUrl}get_resturant_report       and ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
      RestaurantListModel.fromJson(json.decode(finalResult));
      setState(() {
        tiffinListModel = jsonResponse;
        tiffinReportList = tiffinListModel?.rows ?? [];
        tiffinReportList = tiffinReportList.reversed.toList();
       // tiffinListModel?.rows?.reversed.toList();
      });
    } else {
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Future.delayed(Duration(milliseconds: 300), () {
      return getRestaurantResports();

    });
    getRestaurantTiffinReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Restaurant Report", context),
      body: Container(
        child: restaurantListModell == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : restaurantListModell!.rows!.length == 0
                ? Center(
                    child: Text("No data to show"),
                  )
                : Column(children: [
                  SizedBox(height: 10,),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.green,

                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        SizedBox(
                          width: 200,
                          child: Tab(
                            text: 'Order Report',
                          ),
                        ),

                        // second tab [you can add an icon using the icon property]
                        SizedBox(
                          width: 200,

                          child: Tab(
                            text: 'Tiffin Report',
                          ),
                        ),
                      ],
                    ),
                  ),

                 Expanded(child: TabBarView(
                   controller: _tabController,
                   children: [
                     ListView.builder(
                         shrinkWrap: true,
                         //reverse: true,
                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                         physics: BouncingScrollPhysics(),
                         itemCount: orderReportList.length,
                         itemBuilder: (c, i) {
                           //DateTime parsedDate = DateFormat('dd-MM-yyyy HH:mm:ss').parse(restaurantListModell!.rows![i].orderDate!);
                           String parsedDate = orderReportList[i].orderDate!;
                           var item = orderReportList[i];

                           return Card(
                             elevation: 1,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Container(
                               padding: EdgeInsets.symmetric(
                                   horizontal: 10, vertical: 10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.white,
                               ),
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "#Order Id",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${item.orderId}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Order Date",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${parsedDate}",//DateFormat('dd MMM, yyyy hh:mma').format(parsedDate)
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   /*SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Restaurant Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "${restaurantListModell!.rows![i].resturantName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),*/
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Payment Mode",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${item.paymentMethod}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Active Status",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${item.activeStatus!.toUpperCase()}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Order Amount",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${double.parse(item.total.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   /*SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Restaurant Discount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  restaurantListModell!.rows![i]
                                                  .restaurantDiscount ==
                                              null ||
                                          restaurantListModell!.rows![i]
                                                  .restaurantDiscount ==
                                              ""
                                      ? Text("")
                                      : Text(
                                          "\u{20B9}${double.parse(restaurantListModell!.rows![i].restaurantDiscount.toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Admin Discount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  restaurantListModell!
                                                  .rows![i].adminDiscount ==
                                              null ||
                                          restaurantListModell!
                                                  .rows![i].adminDiscount ==
                                              ""
                                      ? Text("")
                                      : Text(
                                          "\u{20B9}${double.parse(restaurantListModell!.rows![i].adminDiscount.toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Net Bill",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "\u{20B9}${double.parse(restaurantListModell!.rows![i].netBill.toString()).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),*/
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Food GST (5%)",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${double.parse(item.totalGst.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Customer Paid Amount",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${((item.finalTotal ?? 0)+ (item.totalGst ?? 0)).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Tiffexx Fee",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${double.parse(item.finalAdminEarning.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Tax (18%)",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           " \u{20b9} ${double.parse(item.etozFee.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   /*Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TDS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "\u{20b9} ${double.parse(restaurantListModell!.rows![i].tds.toString()).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),*/
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Net Payable",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20b9} ${item.netPayble}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   /*Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "${restaurantListModell!.rows![i].dateAdded}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),*/
                                 ],
                               ),
                             ),
                           );
                         }),
                     ListView.builder(
                         shrinkWrap: true,
                         //reverse: true,
                         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                         physics: BouncingScrollPhysics(),
                         itemCount: tiffinReportList.length,
                         itemBuilder: (c, i) {
                           //DateTime parsedDate = DateFormat('dd-MM-yyyy HH:mm:ss').parse(restaurantListModell!.rows![i].orderDate!);
                           String parsedDate = tiffinReportList[i].orderDate!;
                           var item = tiffinReportList[i];

                           return Card(
                             elevation: 1,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Container(
                               padding: EdgeInsets.symmetric(
                                   horizontal: 10, vertical: 10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.white,
                               ),
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "${item.orderId?.split('#')[0]}",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${item.orderId?.split('#')[1]}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Order Date",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${parsedDate}",//DateFormat('dd MMM, yyyy hh:mma').format(parsedDate)
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   /*SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Restaurant Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "${restaurantListModell!.rows![i].resturantName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),*/
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Payment Mode",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "${item.paymentMethod}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Active Status",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "DELIVERED",//${item.activeStatus!.toUpperCase()}
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Order Amount",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${double.parse(item.total.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   /*SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Restaurant Discount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  restaurantListModell!.rows![i]
                                                  .restaurantDiscount ==
                                              null ||
                                          restaurantListModell!.rows![i]
                                                  .restaurantDiscount ==
                                              ""
                                      ? Text("")
                                      : Text(
                                          "\u{20B9}${double.parse(restaurantListModell!.rows![i].restaurantDiscount.toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Admin Discount",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  restaurantListModell!
                                                  .rows![i].adminDiscount ==
                                              null ||
                                          restaurantListModell!
                                                  .rows![i].adminDiscount ==
                                              ""
                                      ? Text("")
                                      : Text(
                                          "\u{20B9}${double.parse(restaurantListModell!.rows![i].adminDiscount.toString()).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Net Bill",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "\u{20B9}${double.parse(restaurantListModell!.rows![i].netBill.toString()).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),*/
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Food GST (5%)",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${double.parse(item.totalGst.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Customer Paid Amount",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${((item.finalTotal ?? 0)+ (item.totalGst ?? 0)).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Tiffexx Fee",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20B9}${double.parse(item.finalAdminEarning.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Tax (18%)",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           " \u{20b9} ${double.parse(item.etozFee.toString()).toStringAsFixed(2)}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   /*Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TDS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "\u{20b9} ${double.parse(restaurantListModell!.rows![i].tds.toString()).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),*/
                                   Row(
                                     mainAxisAlignment:
                                     MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(
                                         "Net Payable",
                                         style:
                                         TextStyle(fontWeight: FontWeight.w600),
                                       ),
                                       Text(
                                           "\u{20b9} ${item.netPayble}",
                                           style: TextStyle(
                                               fontWeight: FontWeight.w600)),
                                     ],
                                   ),
                                   SizedBox(
                                     height: 5,
                                   ),
                                   /*Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                      "${restaurantListModell!.rows![i].dateAdded}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),*/
                                 ],
                               ),
                             ),
                           );
                         }),
                   ],))


                        ],),
      ),
    );
  }
}
