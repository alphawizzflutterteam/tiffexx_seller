import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiffexx_seller/Helper/Color.dart';
import 'package:tiffexx_seller/Helper/Session.dart';
import 'package:tiffexx_seller/Provider/SubscriptionProvider.dart';
import 'package:tiffexx_seller/Screen/SubscriptionDetailScreen.dart';
import 'package:tiffexx_seller/Screen/UserPlanDetailScreen.dart';
import 'package:tiffexx_seller/noInternet.dart';

class SubscribedUsersScreen extends StatefulWidget {
  const SubscribedUsersScreen({Key? key}) : super(key: key);

  @override
  State<SubscribedUsersScreen> createState() => _SubscribedUsersScreenState();
}

class _SubscribedUsersScreenState extends State<SubscribedUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<SubsProvider>(context, listen: false).getSubsUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(getTranslated(context, "SUBSUSERS")!, context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<SubsProvider>(
          builder: (context, val, _) => val.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: primary,
                ))
              : val.users.isEmpty
                  ? NoDataFound()
                  : ListView.builder(
                      itemCount: val.users.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserPlanDetailScreen(
                                    data: val.users[index]),
                              ));
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          val.users[index].userImage.toString(),
                                      fit: BoxFit.fitHeight,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/logo/plashholder.png"),
                                    ),
                                  ),
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
                                        val.users[index].username.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        val.users[index].mobile.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        val.users[index].email.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text(
                                            "Expiry Date : ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${DateFormat('d MMM y').format(DateTime.parse(val.users[index].expiryDate.toString()))}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
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
