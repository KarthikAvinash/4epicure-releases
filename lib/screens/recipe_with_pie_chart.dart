// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../widgets/recipe_list_view.dart';
// import 'package:shimmer/shimmer.dart';
// import '../globals.dart';
// import '../widgets/main_drawer.dart';
// // void main() {
// //   runApp(Recipes_with_pie_chart_screen());
// // }

// class Recipes_with_pie_chart_screen extends StatefulWidget {
//   Recipes_with_pie_chart_screen();
//   @override
//   _Recipes_with_pie_chart_screenState createState() =>
//       _Recipes_with_pie_chart_screenState();
// }

// class _Recipes_with_pie_chart_screenState
//     extends State<Recipes_with_pie_chart_screen> {
//   List<Map<String, dynamic>> recipes = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchRecipes();
//   }

//   void _fetchRecipes() async {
//     final response = await http
//         .get(Uri.parse('https://recipenutrition.pythonanywhere.com/recipes/'));
//     print(response);
//     final responseData = json.decode(response.body) as List<dynamic>;
//     print("@@@@@@@@@");
//     print(responseData);
//     final List<Map<String, dynamic>> newRecipes =
//         responseData.map((recipeData) {
//       return {
//         'title': recipeData['title'],
//         'short_description': recipeData['short_description'],
//         'image_url': recipeData['image_url'],
//         'description': recipeData['description'],
//         'ingredients': recipeData['ingredients'],
//         'steps_with_images': recipeData['steps_with_images'],
//         'nutrition': recipeData['nutrition'],
//         'cook_time': recipeData['cook_time'],
//         'rating': recipeData['rating'],
//       };
//     }).toList();

//     setState(() {
//       recipes = newRecipes;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Recipes With Nutrients'),
//           backgroundColor: Colors.pink,
//         ),
//         drawer: MainDrawer(),
//         body: isLoading
//             ? Shimmer.fromColors(
//                 baseColor: Colors.grey[300] ?? Colors.grey,
//                 highlightColor: Colors.grey[100] ?? Colors.white,
//                 child: ListView.builder(
//                   itemCount:
//                       10, // or any other number of items you want to display
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: double.infinity,
//                             height: 240,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 16),
//                           Container(
//                             width: double.infinity,
//                             height: 16,
//                             margin: EdgeInsets.symmetric(horizontal: 16),
//                             color: Colors.blue,
//                           ),
//                           SizedBox(height: 8),
//                           Container(
//                             width: double.infinity,
//                             height: 12,
//                             margin: EdgeInsets.symmetric(horizontal: 16),
//                             color: Colors.black,
//                           ),
//                           SizedBox(height: 16),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//             : RecipeListView(user_id: user_id, recipes: recipes),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:chatgpt_course/screens/recipe_detail_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../widgets/pie_graph.dart';

class MyFlipCard extends StatefulWidget {
  const MyFlipCard({context, Key? key}) : super(key: key);

  @override
  State<MyFlipCard> createState() => _MyFlipCardState();
}

class _MyFlipCardState extends State<MyFlipCard> {
  // sample data received from backend
  final List<String> sampleData = ['Card 1', 'Card 2', 'Card 3'];
  List<Map<String, dynamic>> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  void _fetchRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('https://recipenutrition.pythonanywhere.com/recipes/'),
        headers: <String, String>{
          'origin': '*',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final responseData = json.decode(response.body) as List<dynamic>;
      print("@@@@@@@@@");
      print(responseData);
      final List<Map<String, dynamic>> newRecipes =
          responseData.map((recipeData) {
        return {
          'title': recipeData['title'],
          'short_description': recipeData['short_description'],
          'image_url': recipeData['image_url'],
          'description': recipeData['description'],
          'ingredients': recipeData['ingredients'],
          'steps_with_images': recipeData['steps_with_images'],
          'nutrition': recipeData['nutrition'],
          'cook_time': recipeData['cook_time'],
          'rating': recipeData['rating'],
        };
      }).toList();

      setState(() {
        recipes = newRecipes;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching recipes: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Recipes"),
        ),
        // body has a center with ListView.builder child.
        body: isLoading
            ? Shimmer.fromColors(
                baseColor: Colors.grey[300] ?? Colors.grey,
                highlightColor: Colors.grey[100] ?? Colors.white,
                child: ListView.builder(
                  itemCount:
                      10, // or any other number of items you want to display
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 240,
                            color: Colors.white,
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 16,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            color: Colors.blue,
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 12,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            color: Colors.black,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Center(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return a FlipCard widget for each data item
                    return FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      // front of the card
                      front: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: sWidth * 0.9,
                          height: sHeight * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Recipe Image
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          recipes[index]['image_url']),
                                    ),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ),
                              // Recipe Title
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Text(
                                  recipes[index]['title'],
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              // Ratings and Cooktime
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // Ratings
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 20.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          recipes[index]['rating'].toString(),
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Cooktime
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: Colors.blue,
                                          size: 20.0,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          recipes[index]['cook_time'],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // back of the card
                      back: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: sWidth * 0.9,
                          height: sHeight * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Nutrition Info
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: getPieChart(
                                      context, recipes[index]['nutrition']),
                                ),
                              ),
                              // Recipe Description
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Text(
                                  recipes[index]['short_description'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                              // Button to navigate to another screen
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(recipes[index]['steps_with_images']
                                        .runtimeType);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        // fullscreenDialog: true,
                                        builder: (context) => RecipePage(
                                          
                                            recipeName: recipes[index]['title'],
                                            description: recipes[index]
                                                ['description'],
                                            ingredientsWithQty: recipes[index]
                                                ['ingredients'],
                                            recipeImage: recipes[index]
                                                ['image_url'],
                                            recipeSteps: recipes[index]
                                                ['steps_with_images']),
                                      ),
                                    );
                                  },
                                  child: Text('View Recipe'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
