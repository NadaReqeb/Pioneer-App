import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/model/admin_order.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

class OrderDetails extends StatefulWidget {
  AdminOrder cart;

  OrderDetails(this.cart);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Color(0xffDC180F),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          margin: EdgeInsetsDirectional.only(top: SizeConfig().scaleHeight(10)),
          child: Text(
            'تفاصيل الطلبية',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold,
                fontSize: SizeConfig().scaleTextFont(20)),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig().scaleWidth(5),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10, left: 0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xff5A55CA),
                    backgroundImage: NetworkImage('http://arthamatra.com/wp-content/uploads/2016/02/user-male.png'),
                  ),
                ),
                SizedBox(
                  width: SizeConfig().scaleWidth(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    SizedBox(
                      height: SizeConfig().scaleHeight(10),
                    ),
                    Text(
                      widget.cart.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize:SizeConfig().scaleTextFont(18),
                          fontWeight: FontWeight.bold,
                          textBaseline: TextBaseline.ideographic),
                    ),
                    SizedBox(
                      height: SizeConfig().scaleHeight(5),
                    ),
                    Text(
                      widget.cart.created,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(16),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                          textBaseline: TextBaseline.ideographic),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            color: Colors.grey,
            thickness: 0,
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(5),
          ),
          Text(
            'معلومات المنتج',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: SizeConfig().scaleTextFont(22), color: Colors.black),
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Column(
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        height: SizeConfig().scaleHeight(250),
                        child: Image.network(
                          widget.cart.proImage,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                      ),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),


                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: SizeConfig().scaleHeight(40),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Column(
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      height: 50,
                      alignment: AlignmentDirectional.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          textBaseline: TextBaseline.ideographic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'اسم : ',
                              style: TextStyle(
                                  fontSize: SizeConfig().scaleTextFont(18),
                                  fontWeight: FontWeight.w700,
                                  textBaseline: TextBaseline.ideographic,color: Colors.white),
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              widget.cart.proName,
                              style: TextStyle(
                                  fontSize: SizeConfig().scaleTextFont(18),
                                  textBaseline: TextBaseline.ideographic,color: Colors.white),
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffDC180F),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig().scaleHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Column(
                  textBaseline: TextBaseline.ideographic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      height: 50,
                      alignment: AlignmentDirectional.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          textBaseline: TextBaseline.ideographic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'السعر : ',
                              style: TextStyle(
                                  fontSize: SizeConfig().scaleTextFont(18),
                                  fontWeight: FontWeight.w700,
                                  textBaseline: TextBaseline.ideographic,color: Colors.white),
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              widget.cart.price.toString() + '\$',
                              style: TextStyle(
                                  fontSize: SizeConfig().scaleTextFont(18),
                                  textBaseline: TextBaseline.ideographic,color: Colors.white),
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xffDC180F),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
