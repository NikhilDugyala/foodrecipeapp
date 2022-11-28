//This file will handle all our API calls to the
//Spoonacular API

// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/meal_plan_model.dart';

class ApiService {
  //The API service will be a singleton, therefore create a private constructor
  //ApiService._instantiate(), and a static instance variable
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();

  //Add base URL for the spoonacular API, endpoint and API Key as a constant
  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY = "1f411eb9d8ec4573b679d25e583d8058";

  //We create async function to generate meal plan which takes in
  //timeFrame, targetCalories, diet and apiKey

  //If diet is none, we set the diet into an empty string

  //timeFrame parameter sets our meals into 3 meals, which are daily meals.
  //that's why it's set to day

  Future<MealPlan> generateMealPlan(
      {required int targetCalories, required String diet}) async {
    //check if diet is null
    if (diet == 'None') diet = '';
    Map<String, String> parameters = {
      'timeFrame': 'day', //to get 3 meals
      'targetCalories': targetCalories.toString(),
      'diet': diet,
      'apiKey': API_KEY,
    };

    //The Uri consists of the base url, the endpoint we are going to use. It has also
    //parameters
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/mealplans/generate',
      parameters,
    );
    print("The URI: ${uri}");
    //Our header specifies that we want the request to return a json object
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    /*
    Our try catch uses http.get to retrieve response.
    It then decodes the body of the response into a map,
    and converts the map into a mealPlan object
    by using the facory constructor MealPlan.fromMap
    */
    //http.get to retrieve the response
    var response = await http.get(uri, headers: headers);
    //decode the body of the response into a map
    Map<String, dynamic> data = json.decode(response.body);
    //convert the map into a MealPlan Object using the factory constructor,
    //MealPlan.fromMap
    debugPrint(data.toString());
    MealPlan mealPlan = MealPlan.fromMap(data);
    return mealPlan;
  }

  //the fetchRecipe takes in the id of the recipe we want to get the info for
  //We also specify in the parameters that we don't want to include the nutritional
  //information
  //We also parse in our API key
}
