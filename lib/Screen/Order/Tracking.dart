import 'package:flutter/material.dart';
import 'package:pionner_app_admin/utils/helpers.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> with Helpers {
  Widget getTimeLine() {
    double heightCon = 80.0;
    return Container(
      color: Colors.grey[50],
      margin: EdgeInsets.only(top: 10.0, bottom: 80.0),
      child: Column(
        children: <Widget>[
          new Container(
              height: heightCon,
              child: TimelineTile(
                lineXY: 0.2,
                indicatorStyle: IndicatorStyle(height: 1.0),
                alignment: TimelineAlign.manual,
                endChild: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        "تأكيد الطلبية",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'NotoNaskhArabic'),
                      ),
                      new Icon(
                        Icons.restaurant,
                        color: Color(0xffDC180F),
                      )
                    ],
                  ),
                ),
              )),
          new Container(
              height: heightCon,
              child: TimelineTile(
                lineXY: 0.2,
                indicatorStyle: IndicatorStyle(height: 1.0),
                alignment: TimelineAlign.manual,
                endChild: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        "تجهيز الطلبية",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'NotoNaskhArabic'),
                      ),
                      new Icon(
                        Icons.restaurant,
                        color: Color(0xffDC180F),
                      )
                    ],
                  ),
                ),
              )),
          new Container(
              height: heightCon,
              child: TimelineTile(
                lineXY: 0.2,
                indicatorStyle: IndicatorStyle(height: 1.0),
                alignment: TimelineAlign.manual,
                endChild: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        "تم تجهيز الطلبية في المطعم",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: 20.0),
                      ),
                      new Icon(
                        Icons.restaurant,
                        color: Color(0xffDC180F),
                      )
                    ],
                  ),
                ),
              )),
          new Container(
              height: heightCon,
              child: TimelineTile(
                lineXY: 0.2,
                indicatorStyle: IndicatorStyle(height: 1.0),
                alignment: TimelineAlign.manual,
                endChild: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        "الدليفري استلم الطلبية",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: 20.0),
                      ),
                      new Icon(
                        Icons.restaurant,
                        color: Color(0xffDC180F),
                      )
                    ],
                  ),
                ),
              )),
          new Container(
              height: heightCon,
              child: TimelineTile(
                lineXY: 0.2,
                indicatorStyle: IndicatorStyle(height: 1.0),
                alignment: TimelineAlign.manual,
                endChild: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      new Text(
                        "الدليفري قريب من المكان",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'NotoNaskhArabic'),
                      ),
                      new Icon(
                        Icons.restaurant,
                        color: Color(0xffDC180F),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'تتبع الطلبية',
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontFamily: 'NotoNaskhArabic',
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Color(0xffDC180F)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Image.asset(
            "images/out_boarding_3.png",
            width: 200,
            height: 200,
          ),
          new Text(
            "مسار الطلبية",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoNaskhArabic'),
            textAlign: TextAlign.center,
          ),
          getTimeLine(),
        ],
      ),
    );
  }
}
