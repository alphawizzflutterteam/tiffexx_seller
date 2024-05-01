import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tiffexx_seller/Helper/Color.dart';
import 'package:tiffexx_seller/Helper/Session.dart';
import 'package:tiffexx_seller/Model/SubsPlanModel.dart';
import 'package:tiffexx_seller/Model/SubsUsersModel.dart';
import 'package:tiffexx_seller/Provider/SubscriptionProvider.dart';

class UserPlanDetailScreen extends StatelessWidget {
  const UserPlanDetailScreen({Key? key, required this.data}) : super(key: key);
  final SubsUsersData data;
  String getStatus(DateTime dateTime) {
    int index = data.orders.indexWhere(
        (ele) => isSameDate(dateTime, DateTime.parse(ele.date.toString())));
    print("Index: $index");
    if (index != -1) {
      return data.orders[index].status.toString();
    } else
      // for(int i = 0; i < data.orders.length ; i++){
      //   if(isSameDate(dateTime,DateTime.parse(data.orders[i].date.toString()))){
      //     return data.orders[i].status.toString();
      //   }
      // }
      return "0";
  }

  bool isSameDate(DateTime dateTime1, DateTime dateTime2) {
    return "${dateTime1.day}-${dateTime1.month}-${dateTime2.year}" ==
        "${dateTime2.day}-${dateTime2.month}-${dateTime2.year}";
  }

  String getSubId(DateTime dateTime) {
    int index = data.orders.indexWhere(
        (ele) => isSameDate(dateTime, DateTime.parse(ele.date.toString())));
    if (index != -1) {
      return data.orders[index].subscriptionId.toString();
    } else {
      return '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Plan Details", context),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.grey.shade300,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                  data.userImage.toString(),
                                ),
                                onError: (exception, stackTrace) =>
                                    Image.asset("assets/logo/plashholder.png"),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.username.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                data.mobile.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                data.email.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                data.transactionId.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Start Date : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat('d MMM y').format(DateTime.parse(
                                        data.startDate.toString())),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Amount : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.amount.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "End Date : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat('d MMM y').format(DateTime.parse(
                                        data.expiryDate.toString())),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Status : ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data.status == 'delete'
                                        ? "STOPPED"
                                        : data.status.toString().toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.transparent),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        data.planTitle.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      Text(
                        data.planDescription!.replaceAll('\\', '').toString(),
                        style: TextStyle(fontSize: 14),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(color: Colors.transparent),
                      Row(
                        children: [
                          const Text(
                            "Price : ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "₹${data.amount}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          const Text(
                            "Time : ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "₹${data.remarks}",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.transparent),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TableCalendar(
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month'
                    },
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                    ),
                    firstDay: DateTime.parse(data.startDate.toString()),
                    focusedDay: DateTime.parse(data.expiryDate.toString()),
                    lastDay: DateTime.parse(data.expiryDate.toString()),
                    onDaySelected: (selectedDay, focusedDay) {
                      // if (getStatus(selectedDay) != '5' &&
                      //     getStatus(selectedDay) != '6' &&
                      //     getStatus(selectedDay) != '7' &&
                      //     getStatus(selectedDay) != '8' &&
                      //     selectedDay.isAfter(DateTime.now())) {
                      //   // showDialog(
                      //   //     context: context,
                      //   //     builder: (context) => Consumer<TiffinProvider>(
                      //   //             builder: (context, val, _) {
                      //   //           return AlertDialog(
                      //   //             title: val.isLoading
                      //   //                 ? null
                      //   //                 : Text("Cancel Order"),
                      //   //             content: val.isLoading
                      //   //                 ? Column(
                      //   //                     mainAxisSize: MainAxisSize.min,
                      //   //                     children: [
                      //   //                       Center(
                      //   //                         child:
                      //   //                             CircularProgressIndicator(),
                      //   //                       ),
                      //   //                       Text(
                      //   //                         "Please Wait.....",
                      //   //                         style: TextStyle(
                      //   //                             fontWeight: FontWeight.bold,
                      //   //                             fontSize: 16),
                      //   //                       ),
                      //   //                     ],
                      //   //                   )
                      //   //                 : Text(
                      //   //                     'Do you want to cancel today\'s tiffin?'),
                      //   //             actions: val.isLoading
                      //   //                 ? []
                      //   //                 : [
                      //   //                     TextButton(
                      //   //                         onPressed: () =>
                      //   //                             Navigator.pop(context),
                      //   //                         child: Text(
                      //   //                           "Discard",
                      //   //                           style: TextStyle(
                      //   //                               color: Colors.black),
                      //   //                         )),
                      //   //                     ElevatedButton(
                      //   //                         style: ElevatedButton.styleFrom(
                      //   //                           shape: RoundedRectangleBorder(
                      //   //                               borderRadius:
                      //   //                                   BorderRadius.circular(
                      //   //                                       7)),
                      //   //                           backgroundColor:
                      //   //                               colors.primary,
                      //   //                         ),
                      //   //                         onPressed: () {
                      //   //                           val
                      //   //                               .updateDayStatus(
                      //   //                                   date: selectedDay
                      //   //                                       .toString(),
                      //   //                                   subId: getSubId(
                      //   //                                       selectedDay))
                      //   //                               .then((value) {
                      //   //                             if (value) {
                      //   //                               Navigator.pop(context);
                      //   //                               Navigator.pop(context);
                      //   //                               val.getMyTiffinPlans();
                      //   //                             }
                      //   //                           });
                      //   //                         },
                      //   //                         child: Text(
                      //   //                           "Cancel",
                      //   //                           style: TextStyle(
                      //   //                               color: Colors.white),
                      //   //                         ))
                      //   //                   ],
                      //   //           );
                      //   //         }));
                      // }
                    },
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E().format(day);
                          return Center(
                            child: Text(
                              text,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                      },
                      defaultBuilder: (context, date, _) {
                        switch (getStatus(date)) {
                          case '1':
                            return OrderStatus(
                                date: date,
                                color: Colors.orange,
                                title: 'Pending');
                          case '2':
                            return OrderStatus(
                                date: date,
                                color: Colors.grey,
                                title: 'In Progress');
                          case '3':
                            return OrderStatus(
                                date: date,
                                color: Colors.blue,
                                title: 'Picked Up');
                          case '4':
                            return OrderStatus(
                                date: date,
                                color: Colors.purpleAccent,
                                title: 'On The Way');
                          case '5':
                            return OrderStatus(
                                date: date,
                                color: Colors.green,
                                title: 'Delivered');
                          case '6':
                            return OrderStatus(
                                date: date, color: Colors.red, title: 'Leave');
                          case '7':
                            return OrderStatus(
                                date: date,
                                color: Colors.black,
                                title: 'Cancel By User');
                          case '8':
                            return OrderStatus(
                                date: date,
                                color: Colors.pinkAccent,
                                title: 'Pause');
                          default:
                            return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.transparent),
              Consumer<SubsProvider>(builder: (context, val, _) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Weekly Menu",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                val.setVisiblity();
                              },
                              child: Text(
                                "View",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primary),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Visibility(
                          visible: val.visible,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.menus.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Container(
                              height: 80,
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: primary)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            data.menus[index].image.toString()),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.menus[index].title.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data.menus[index].description
                                                .toString(),
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            data.menus[index].items.toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(7),
                                          bottomRight: Radius.circular(7),
                                        ),
                                        color: primary,
                                        border: Border.all(color: primary)),
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                        data.menus[index].day!
                                            .substring(0, 3)
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Divider(color: Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  final Color color;
  final String title;
  final DateTime date;
  const OrderStatus(
      {Key? key, required this.color, required this.title, required this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      message: title,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
