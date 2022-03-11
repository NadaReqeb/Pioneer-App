import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@pioneerfoodco.com',
      queryParameters: {'Subject': 'Here is Subject', 'Body': 'Add Body Here'});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15)),
        ),
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xffDC180F),
            )),
        title: Text(
          ' تواصل معنا',
          style: TextStyle(
              color: Color(0xffDC180F), fontFamily: 'NotoNaskhArabic'),
          textAlign: TextAlign.right,
        ),

        //actions: [Icon(Icons.arrow_back)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage('images/logo.png'),
                ),
                Text(
                  'شركة بيونير',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'NotoNaskhArabic',
                      color: Colors.white),
                ),
                Text('لاستفسار يرجى التواصل معنا',
                    style: TextStyle(
                        fontFamily: 'NotoNaskhArabic',
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.white)),
                Card(
                  elevation: 12,
                  child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Color(0xffDC180F),
                      ),
                      title: Text(
                        'الاتصال برقم الهاتف',
                        style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () {
                          _showDialog(context);
                        },
                      )
                      // subtitle: Text('info@pioneerfoodco.com'),
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Color(0xffDC180F),
                      ),
                      title: Text(
                        'البريد الالكتروني',
                        style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () async {
                          launch(emailLaunchUri.toString());
                        },
                      )
                      // subtitle: Text('info@pioneerfoodco.com'),
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.whatsapp,
                        color: Color(0xffDC180F)),
                    title: Text(
                      'WhatsApp',
                      style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () async {
                          var url =
                              "https:wa.me/++970598994109?text=helloworld";
                          await launch(url);
                          //subtitle: Text('khalid@pioneerfoodco.com'),
                        }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xffDC180F),
                      ),
                      title: Text(
                        'Facebook',
                        style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () async {
                          var url = "https://www.facebook.com/pioneerfoodco";
                          await launch(url);
                        },
                      )
                      //  subtitle: Text('info@pioneerfoodco.com'),
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.instagram,
                        color: Color(0xffDC180F),
                      ),
                      title: Text(
                        'Instagram',
                        style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () async {
                          var url = "https://www.instagram.com/pfc.ps/";
                          await launch(url);
                        },
                      )
                      // subtitle: Text('info@pioneerfoodco.com'),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  final numberphone = '0097059940812';

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "اتصال",
            style: TextStyle(fontFamily: 'NotoNaskhArabic'),
          ),
          content: new Text(
            "هل تود الاتصال بشركة بيونير ؟",
            style: TextStyle(fontFamily: 'NotoNaskhArabic'),
          ),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text(
                "موافق",
                style: TextStyle(fontFamily: 'NotoNaskhArabic'),
              ),
              onPressed: () async {
                launch('Tell://$numberphone');
                await FlutterPhoneDirectCaller.callNumber(numberphone);
              },
              style: ElevatedButton.styleFrom(
              primary: Colors.red),

            ),
            new ElevatedButton(
              child: new Text(
                "الغاء",
                style: TextStyle(fontFamily: 'NotoNaskhArabic'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
              primary: Colors.red),
              ),

          ],
        );
      });
}
