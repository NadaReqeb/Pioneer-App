import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pionner_app_admin/Screen/control_panel/update_recpie_screen.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_storage_controlle.dart';
import 'package:pionner_app_admin/firebase/firestore/fb_store_controller.dart';
import 'package:pionner_app_admin/responsive/size_config.dart';
import 'package:pionner_app_admin/utils/helpers.dart';

import '../BottomBar.dart';
import 'ModelRecipe.dart';
import 'RecipeDetailes.dart';

class NewRecipe extends StatefulWidget {
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> with Helpers{
  bool loved = false;
  bool saved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(

        centerTitle: true,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color:Color(0xffDC180F)),


        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_recpie_screen');
            },
            icon: Icon(
              Icons.add,
              size: 30,
            ),
          ),


        ],
        title: Text(
          'وصفات صعام',
          style: TextStyle(
            fontSize: SizeConfig().scaleTextFont(28),
            color: Colors.black,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FbStoreController().read(collectionName: 'recipe'),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height:SizeConfig().scaleHeight(20),
                  ),
                  ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: RecipeModel.demoRecipe.length,
                      itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetails(

                                    recipeModel: getRecipeModel(
                                      data.elementAt(index),
                                  ),
                                ),
                              ));
                            },
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Hero(
                                        tag: data[index].get('imgPath'),
                                        child: Image(
                                          height:SizeConfig().scaleHeight(320),
                                          width: SizeConfig().scaleWidth(320),
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data[index].get('imgPath'),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(

                                      children: [

                                        SizedBox(
                                          width: SizeConfig().scaleWidth(250),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                             await deleteRecipe(
                                                 path: data[index].id);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                             MaterialPageRoute(
                                                 builder: (context) =>
                                                     UpdateRecpieScreen(
                                                       recipeModel: getRecipeModel(
                                                         data.elementAt(index),
                                             ),
                                                     )
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.red,
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 20,
                                  //   right: 40,
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         saved = !saved;
                                  //       });
                                  //     },
                                  //     child: Icon(
                                  //       saved ? Icons.bookmark : Icons.bookmark_outline,
                                  //       color: Color(0xffDC180F),
                                  //       size: 38,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height:SizeConfig().scaleHeight(20),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].get('title'),
                                            style: Theme.of(context).textTheme.subtitle1,
                                          ),

                                          SizedBox(
                                            height:SizeConfig().scaleHeight(8),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Spacer(),
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width:SizeConfig().scaleWidth(20),
                                          ),
                                          Icon(
                                            Icons.timer,
                                          ),
                                          SizedBox(
                                            width:SizeConfig().scaleWidth(4),
                                          ),
                                          Text(
                                            data[index].get('cookingTime')+ '\'',
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                loved = !loved;
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: loved ? Color(0xffDC180F) : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                        ),
                          ),
                        );
                    },
                      itemCount: data.length),
                ],
              ),
            );
          }else {
            return Center(
              child: Column(
                children: [
                  Icon(
                    Icons.warning,
                    size: 85,
                  ),
                  Text(
                    'No Data',
                    style: TextStyle(
                        fontSize: SizeConfig().scaleTextFont(22),
                        color: Colors.grey),
                  ),
                ],
              ),
            );
          }

        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home_screen');
        },
        child: Icon(
          Icons.home,
          color: Color(0xffDC180F),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }

  RecipeModel getRecipeModel(QueryDocumentSnapshot snapshot) {
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
  Future<bool> deleteRecipe({required String path}) async {
    bool status = await FbStoreController()
        .delete(path: path, collectionName: 'recipe');
    deleteimage(path: path);
    showSnackBar(context: context, content: 'تم حذف الوصفة بنجاح');
    return status;

  }
  Future<bool> deleteimage({required String path}) async {

    bool status1 = await FbStorageControlle()
        .delete(path: path);

    return status1;
  }
}


class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.recipeModel,
  }) : super(key: key);

  final RecipeModel recipeModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: recipeModel.description.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                  ),
                  child: Text('⚫️ ' + recipeModel.description),
                );
              },
              // separatorBuilder: (BuildContext context, int index) {
              //   return Divider(color: Colors.black.withOpacity(0.3));
              // },
            ),
          ],
        ),
      ),
    );
  }

}
