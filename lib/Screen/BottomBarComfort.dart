import 'package:flutter/material.dart';

class BottomBarComfort extends StatefulWidget {
  const BottomBarComfort({Key? key}) : super(key: key);

  @override
  _BottomBarComfortState createState() => _BottomBarComfortState();
}

class _BottomBarComfortState extends State<BottomBarComfort> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      elevation: 15,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2 - 40.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.person_outlined),
                      color: Color(0xffDC180F),
                      onPressed: () {
                        Navigator.pushNamed(context, '/ProfileScreen');
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Color(0xffDC180F),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/order_screen1');
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width / 2 - 40.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.local_offer, color: Color(0xffDC180F)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/offers_screen');
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.contact_page_rounded, color: Color(0xffDC180F)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact_screen');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
