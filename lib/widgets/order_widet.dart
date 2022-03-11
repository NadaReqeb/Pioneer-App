import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

Widget showItemOrder({
  required BuildContext context,
  required String title,
  required String subtitle,
  required String date,
  required String url,
  required int index,
  // Locale  = Locale('ar'),
  required List<DocumentSnapshot> documents,
}) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 0),
        child: Container(
          height: SizeConfig().scaleHeight(90),
          width: SizeConfig().scaleWidth(366),
          decoration: BoxDecoration(
            color: Color(0xffF1F2F3),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.16),
                spreadRadius: 5,
                blurRadius: 0,
                offset: Offset(3, -3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: SizeConfig().scaleWidth(15),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 16, left: 0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  width: SizeConfig().scaleWidth(60),
                  height: SizeConfig().scaleHeight(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                  ),
                  child: url == null
                      ? Icon(Icons.person)
                      : Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig().scaleWidth(15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                textBaseline: TextBaseline.alphabetic,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig().scaleTextFont(16),
                        textBaseline: TextBaseline.alphabetic),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    locale: Locale('ar'),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Tajwal',
                        fontSize: SizeConfig().scaleTextFont(16),
                        textBaseline: TextBaseline.alphabetic),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    locale: Locale('en'),
                  ),
                  SizedBox(height: 3,),
                  Container(
                    width: SizeConfig().scaleWidth(280),
                    alignment: AlignmentDirectional.centerEnd,
                    margin: EdgeInsetsDirectional.only(
                        bottom: SizeConfig().scaleHeight(5)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Spacer(),
                        Text(
                          date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig().scaleTextFont(14),
                              textBaseline: TextBaseline.alphabetic),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.end,
                          locale: Locale('en'),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
}