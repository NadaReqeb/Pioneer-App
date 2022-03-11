import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'ModelRecipe.dart';

class RecipeDetails extends StatefulWidget {
  final RecipeModel recipeModel;
  RecipeDetails({
    required this.recipeModel,
  });

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        minHeight: (size.height / 2),
        maxHeight: size.height / 1.2,
        panel: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(20),
              ),
              Text(
                widget.recipeModel.title,
                style: _textTheme.headline6,
              ),
              SizedBox(
                height:SizeConfig().scaleHeight(10),
              ),

              Row(
                children: [
                  // Icon(
                  //   Icons.tag_faces,
                  //   color: Color(0xffDC180F),
                  // ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // Text(
                  //   "198",
                  //   style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                  // ),
                  // SizedBox(
                  //   width:100,
                  // ),
                  Icon(
                    Icons.timer,
                  ),
                  SizedBox(
                    width:SizeConfig().scaleWidth(4),
                  ),
                  Text(
                    widget.recipeModel.cookingTime.toString() ,
                  ),

                  // Container(
                  //   width: 2,
                  //   height: 30,
                  //   color: Colors.black,
                  // ),
                  SizedBox(
                    width:SizeConfig().scaleWidth(10),
                  ),

                ],
              ),
              SizedBox(
                height: SizeConfig().scaleHeight(10),
              ),
              Divider(
                color: Colors.black.withOpacity(0.3),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        indicatorColor: Color(0xffDC180F),
                        tabs: [
                          Tab(
                            text: "مقادير".toUpperCase(),
                          ),
                          Tab(
                            text: "طريقة تحضير".toUpperCase(),
                          ),
                          Tab(
                            text: "مراجعات".toUpperCase(),
                          ),
                        ],
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black.withOpacity(0.3),
                        labelStyle: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(12),
                          fontWeight: FontWeight.w600,
                        ),
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              child: Text('⚫️ ' + widget.recipeModel.ingredients),

                              //   child: Padding(
                            //   padding: const EdgeInsets.only(bottom: 12.0),
                            //   child: Column(
                            //     children: [
                            //       ListView.separated(
                            //         shrinkWrap: true,
                            //         physics: ScrollPhysics(),
                            //         itemCount: widget.recipeModel.ingredients.length,
                            //         itemBuilder: (BuildContext context, int index) {
                            //           return Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //               vertical: 2.0,
                            //             ),
                            //             child: Text('⚫️ ' + widget.recipeModel.ingredients),
                            //           );
                            //         },
                            //         separatorBuilder: (BuildContext context, int index) {
                            //           return Divider(color: Colors.black.withOpacity(0.3));
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            ),
                            Container(
                              child: Text('⚫️ ' + widget.recipeModel.description),

                            ),
                            Container(
                              child: Text(
                                "لا يوجد ",
                                style: TextStyle(fontFamily: 'NotoNaskhArabic'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: widget.recipeModel.imgPath,
                    child: ClipRRect(
                      child: Image(
                        width: double.infinity,
                        height: (size.height / 2) + 50,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.recipeModel.imgPath),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                right: 20,
                child: Icon(
                  Icons.bookmark_outline,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    CupertinoIcons.forward,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  RecipeModel getProduct(QueryDocumentSnapshot snapshot) {
    RecipeModel recipeModel = RecipeModel();
    recipeModel.path = snapshot.id;
    recipeModel.title = snapshot.get('title');
    recipeModel.description = snapshot.get('description');
    recipeModel.cookingTime = snapshot.get('cookingTime');
    recipeModel.ingredients = snapshot.get('ingredients');
    // recipeModel.prepare = snapshot.get('prepare');
    recipeModel.imgPath = snapshot.get('imgPath');

    return recipeModel;
  }
}

