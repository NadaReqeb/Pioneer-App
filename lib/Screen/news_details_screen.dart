import 'package:flutter/material.dart';
import 'package:pionner_app_admin/model/news_model.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';

class NewsDetailsScreen extends StatefulWidget {
  late News news;
  NewsDetailsScreen({required this.news});
  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        elevation: 0,
        title: Text('widget.news.name'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20, color: Color(0xffDC180F)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(' widget.news.imagePath'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' widget.news.time',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'NotoNaskhArabic',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      ' widget.news.title',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig().scaleTextFont(20),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'NotoNaskhArabic'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'widget.news.description',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
//                      fontWeight: FontWeight.w700,
                          fontFamily: 'NotoNaskhArabic'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
