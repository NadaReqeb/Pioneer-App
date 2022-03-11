import 'package:flutter/material.dart';

class AboutAs extends StatefulWidget {
  const AboutAs({Key? key}) : super(key: key);

  @override
  _AboutAsState createState() => _AboutAsState();
}

class _AboutAsState extends State<AboutAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          centerTitle: true,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xffDC180F),
              )),
          title: Text(
            'حول شركة',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.right,
          ),

          //actions: [Icon(Icons.arrow_back)],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(
                        'لمحة تاريخية',
                        style: TextStyle(
                            color: Color(0xffDC180F),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'في عام 1999 انشأ السيد حمدان محمد حمادة لمنزلية .علامة (بيونير) التجارية لإلهام الأسرة للإستمتاع بالوجبات أما اليوم ومن خلال 13 عام من الخبرة ',
                          style: TextStyle(
                              color: Color(0xffDC180F),
                              fontWeight: FontWeight.bold)),
                      //Text('المنزلية .علامة (بيونير) التجارية لإلهام الأسرة للإستمتاع بالوجبات'),

                      Text(
                          'ومع اكثر من 80 نوع من المنتجات المختلفة أصبح بيونير جزءً رئيسياً من الأسرة الفلسطينة.',
                          style: TextStyle(
                              color: Color(0xffDC180F),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
