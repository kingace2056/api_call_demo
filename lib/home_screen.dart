import 'package:flutter/material.dart';
import 'package:receipe_app/model/recipe_model.dart';
import 'package:receipe_app/services/recipe_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecipeModel? recipeModel;
  @override
  void initState() {
    super.initState();
    getRecipeData();
  }

  Future<void> getRecipeData() async {
    try {
      recipeModel = await RecipeService().getRecipes();
      setState(() {});
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (recipeModel == null) Center(child: Text('Loading')),
            if (recipeModel != null)
              ListView.separated(
                itemCount: recipeModel?.recipes?.length ?? 1,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 4),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final Recipes recipes = recipeModel!.recipes![index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.tealAccent.withValues(alpha: 0.4),
                    ),
                    //                   String? name;
                    // List<String>? ingredients;
                    // List<String>? instructions;
                    // int? prepTimeMinutes;
                    // int? cookTimeMinutes;
                    // int? servings;
                    // String? difficulty;
                    // String? cuisine;
                    // int? caloriesPerServing;
                    // List<String>? tags;
                    // int? userId;
                    // String? image;
                    // num? rating;
                    // int? reviewCount;
                    // List<String>? mealType;
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                recipes.name ?? 'No Name',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),

                              Text(
                                'Ingredients: ${recipes.ingredients}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                'Prep Time: ${recipes.prepTimeMinutes} minutes',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                'Cook Time: ${recipes.cookTimeMinutes} minutes',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        recipes.image != null
                            ? Image.network(
                                recipes.image!,
                                height: 60,
                                width: 60,
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getRecipeData(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
