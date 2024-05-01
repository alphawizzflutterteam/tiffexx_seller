import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiffexx_seller/Helper/Color.dart';
import 'package:tiffexx_seller/Helper/Session.dart';
import 'package:tiffexx_seller/Model/SubsPlanModel.dart';

class SubsDetailScreen extends StatelessWidget {
  const SubsDetailScreen({Key? key, required this.data}) : super(key: key);
  final PlanData data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Subscription Details", context),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .2,
                      width: double.maxFinite,
                      child: GridTile(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(
                                  data.image.toString(),
                                ),
                                onError: (exception, stackTrace) =>
                                    Image.asset("assets/logo/plashholder.png"),
                              ),
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        footer: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              )),
                          child: Text(
                            data.title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        data.description.toString(),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Divider(color: Colors.transparent),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primary),
                        child: Text(
                          "₹${data.amount ?? "0.0"}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ),
                    ),
                    Divider(color: Colors.transparent),
                  ],
                ),
              ),
              Divider(color: Colors.transparent),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Time Slots",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.deliveryTimeSlot.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade500),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  data.deliveryTimeSlot[index].time.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly Menu",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      ListView.builder(
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
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        data.menus[index].image.toString()),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            color: Colors.grey, fontSize: 12),
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
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.transparent),
            ],
          ),
        ),
      ),
    );
  }
}
