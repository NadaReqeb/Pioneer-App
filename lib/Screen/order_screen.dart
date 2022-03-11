import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'اضافة تفاصيل',
          style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoNaskhArabic'),
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
      body: Center(
        child: Card(
          elevation: 15,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            shrinkWrap: true,
            children: [
              Text(
                "اضافة موقعك",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoNaskhArabic'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/map_screen');
                },
                child: Text(
                  'اضافة موقعك',
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Color(0xffDC180F)),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tracking_screen');
                },
                child: Text(
                  'تأكيد طلب',
                  style: TextStyle(
                    fontFamily: 'NotoNaskhArabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: Color(0xffDC180F)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
