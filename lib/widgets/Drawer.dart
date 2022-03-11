import 'package:flutter/material.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: InkWell(
            onTap: () => Navigator.pushNamed(context, '/ProfileScreen'),
            child: CircleAvatar(
              backgroundColor: Color(0xffDC180F),
            ),
          ),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          accountName: Text('Flutter Course'),
          accountEmail: Text('flutter@dev.com'),
        ),
        ListTile(
          title: Text('اخبار'),
          leading: Icon(Icons.article, size: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/news_screen');
          },
        ),
        ListTile(
          title: Text('وصفات'),
          leading: Icon(Icons.fastfood, size: 15),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/recpie_screen');
          },
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text(
            'نبذه عنا',
            style: TextStyle(fontFamily: 'NotoNaskhArabic'),
          ),
          onTap: () => Navigator.pushNamed(context, '/about_screen'),
        ),
        Divider(
          indent: 0,
          endIndent: 50,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        ListTile(
          leading: Icon(Icons.contact_page),
          title: Text('تواصل معنا',
              style: TextStyle(fontFamily: 'NotoNaskhArabic')),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/contact_screen');
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('تسجيل خروج',
              style: TextStyle(fontFamily: 'NotoNaskhArabic')),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/login_screen');
          },
        ),
      ],
    ),
  );
}
