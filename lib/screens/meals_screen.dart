import 'package:flutter/material.dart';
import 'package:sampleproject/screens/recipe_screen.dart';

import '../model/meal_model.dart';
import '../model/meal_plan_model.dart';
import '../model/recipe_model.dart';
import '../services/api_services.dart';

class MealsScreen extends StatefulWidget {
  //It returns a final mealPlan variable
  final MealPlan mealPlan;
  const MealsScreen({super.key, required this.mealPlan});

  @override
  // ignore: library_private_types_in_public_api
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
/*
Returns aContainer with Curved edges and a BoxShadow. 
The child is a column widget that returns nutrient information in Rows
 */
  _buildTotalNutrientsCard() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left:0, bottom: 20, right: 0, top:0),
            child: Text(
              'Nutrition to take!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Calories: ${widget.mealPlan.calories.toString()} cal',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Protein: ${widget.mealPlan.protein.toString()} g',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Fat: ${widget.mealPlan.fat.toString()} g',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Carb: ${widget.mealPlan.carbs.toString()} cal',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

//This method below takes in parameters meal and index
  _buildMealCard(Meal meal, int index) {
    //We define a String variable mealType, that equals method called mealType
    String mealType = _mealType(index);
    //We return stack widget with center alignment
    return GestureDetector(
      //We wrap our stack with gesture detector to navigate to webview page

      /*
      The async onTap function will fetch the recipe by id using the 
      fetchRecipe method.
      It will then navigate to RecipeScreen, while parsing in our mealType and recipe
       */
      onTap: () async {
        Recipe recipe = Recipe(spoonacularSourceUrl: meal.imgURL);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeScreen(
                      mealType: mealType,
                      recipe: recipe,
                    )));
      },
      child: Stack(alignment: Alignment.center, children: <Widget>[
        //First widget is a container that loads decoration image
        Container(
          height: 220,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 45),
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: mealType == "Breakfast" ? const AssetImage("images/breakfast.png") :
                  mealType == "Lunch" ? const AssetImage("images/lunch.png") :
                  const AssetImage("images/dinner.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
              ]),
        ),
        //Second widget is a Container that has 2 text widgets
        Container(
          margin: const EdgeInsets.all(60),
          padding: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  mealType,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              ),
              Center(
                child: Text(
                  meal.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white,),
                )
              ),
            ],
          ),
        )
      ]),
    );
  }

/*
mealType returns Breakfast, Lunch or Dinner, depending on the index value
*/
  _mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //has an appBar
      appBar: AppBar(
        title: const Text('Your Meal Plan',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold
          ),
        ), 
        backgroundColor: Colors.black,
      ),
      //and body as a ListView builder
      body: ListView.builder(
          /*
        We set itemCount to 1 + no. of meals, which based on our API call,
        the no. of meals should always be 3
        */
          itemCount: 1 + widget.mealPlan.meals.length,
          itemBuilder: (BuildContext context, int index) {
            /*
            If index is 0, we return a method called _buildTotalNutrientsCard()
            */
            if (index == 0) {
              return _buildTotalNutrientsCard();
            }
            /*
            Otherwise, we return a buildMealCard method that takes in the meal,
            and index - 1
            */
            Meal meal = widget.mealPlan.meals[index - 1];
            return _buildMealCard(meal, index - 1);
          }),
    );
  }
}
