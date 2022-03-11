import 'package:flutter/material.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: SizeConfig().scaleHeight(250),),
            Icon(
              Icons.warning_amber_outlined,
              color: Colors.grey,
              size: 50,
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(10),
            ),
            Text(
              'لا يوجد بيانات',
              style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig().scaleTextFont(18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
