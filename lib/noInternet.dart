import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*.3,
              child: SvgPicture.asset('assets/logo/noData.svg')),
          SizedBox(height: 5,),
          Text("No Plans Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ],
      ),
    );
  }
}
