import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Confrimation extends StatefulWidget {
  const Confrimation({Key? key}) : super(key: key);

  @override
  _ConfrimationState createState() => _ConfrimationState();
}

class _ConfrimationState extends State<Confrimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'تأكيد',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'NotoNaskhArabic'),
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Card(
                child: Image.asset(
                  'images/Group8168.png',
                  width: 330,
                  height: 200,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'تمت العملية ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'NotoNaskhArabic',
                  fontWeight: FontWeight.normal,
                  color: Color(0xff36596A)),
            )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'تم تأكيد طلبك بنجاح أتمنى لك يوم سعيد ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff36596A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                          colors: [
                            Color(0XFF273246),
                            Color(0XFF181D29),
                          ])),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home_screen');
                    },
                    child: Text(
                      'تمت',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'NotoNaskhArabic',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        primary: Colors.transparent),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
