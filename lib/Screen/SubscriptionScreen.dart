import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiffexx_seller/Helper/Color.dart';
import 'package:tiffexx_seller/Helper/Session.dart';
import 'package:tiffexx_seller/Provider/SubscriptionProvider.dart';
import 'package:tiffexx_seller/Screen/SubscriptionDetailScreen.dart';
import 'package:tiffexx_seller/noInternet.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<SubsProvider>(context, listen: false).getPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(getTranslated(context, "SUBSPLAN")!, context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<SubsProvider>(
          builder: (context, val, _) => val.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: primary,
                ))
              : val.plans.isEmpty
                  ? NoDataFound()
                  : ListView.builder(
                      itemCount: val.plans.length,
                      itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        elevation: 6,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SubsDetailScreen(data: val.plans[index]),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: CachedNetworkImageProvider(
                                          val.plans[index].image.toString(),
                                        ),
                                        onError: (exception, stackTrace) =>
                                            Image.asset(
                                                "assets/logo/plashholder.png"),
                                      ),
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                                SizedBox(width: 8),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .52,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        val.plans[index].title.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        val.plans[index].description.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "₹${val.plans[index].amount ?? ""}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primary,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 8,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}

// Card(
// margin: const EdgeInsets.only(bottom: 8),
// elevation: 6,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(7)),
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(7),
// border: Border.all(width: 2, color: primary)),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 16),
// child: Text(
// val.plans[index].title.toString(),
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 16),
// ),
// ),
// Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 16),
// child: Text(
// val.plans[index].description.toString(),
// maxLines: 3,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// fontSize: 14, color: Colors.grey),
// ),
// ),
// Divider(color: Colors.transparent),
// Container(
// height: 30,
// decoration: BoxDecoration(
// color: primary,
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(5),
// bottomRight: Radius.circular(5),
// ),
// ),
// alignment: Alignment.center,
// child: Text(
// "View Details",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// color: Colors.white,
// fontSize: 16),
// ),
// ),
// ],
// ),
// ),
// )
