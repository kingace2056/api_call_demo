import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:receipe_app/model/recipe_model.dart';

class RecipeService {
  final dio = Dio();

  Future<RecipeModel> getRecipes() async {
    try {
      Response apiResponse = await dio.get('https://dummyjson.com/recipes');
      return RecipeModel.fromJson(jsonDecode(jsonEncode(apiResponse.data)));
    } on DioException catch (e) {
      // return RecipeModel();
      log("Error While calling for recipe API: $e");
      throw 'SOME ERROR';
    }
  }
}
