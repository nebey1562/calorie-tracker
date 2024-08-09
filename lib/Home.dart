import 'package:flutter/material.dart';
import 'user.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double totalCalorieIntake = user.bmr;
    final String bf = '${(user.bmr*0.2).toStringAsFixed(0)}';
    final String lunch = '${(user.bmr*0.3).toStringAsFixed(0)}';
    final String dinner = '${(user.bmr*0.35).toStringAsFixed(0)}';
    final String snacks = '${(user.bmr*0.1).toStringAsFixed(0)}';
    final double carbs = user.weight * 5;
    final String carbsString = '${carbs.toStringAsFixed(0)}g';
    final double protein=user.weight*2*0.8;
    final String proteinString = '${protein.toStringAsFixed(0)}g';
    final double fats=user.weight*0.6;
    final String fatsString = '${fats.toStringAsFixed(0)}g';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '\nCalorie Tracker',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Your Daily Calorie Intake:',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${totalCalorieIntake.toStringAsFixed(0)} kcal',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NutrientColumn(nutrient: 'Carbs', amount: carbsString, color: const Color.fromRGBO(255, 111, 97, 1)),
                NutrientColumn(nutrient: 'Protein', amount: proteinString, color: Color.fromRGBO(116, 120, 128, 1)),
                NutrientColumn(nutrient: 'Fat', amount: fatsString, color: Color.fromRGBO(30, 86, 81, 1)),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Meals',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            MealTile(mealName: 'Breakfast', recommendedCalories: bf +'Cal'),
            const SizedBox(height: 10),
            MealTile(mealName: 'Lunch', recommendedCalories: lunch+'Cal'),
            const SizedBox(height: 10),
            MealTile(mealName: 'Dinner', recommendedCalories: dinner+'Cal'),
            const SizedBox(height: 10),
            MealTile(mealName: 'Snacks', recommendedCalories: snacks+'Cal'),
          ],
        ),
      ),
    );
  }
}

// NutrientColumn widget for displaying nutrient data with color
class NutrientColumn extends StatelessWidget {
  final String nutrient;
  final String amount;
  final Color color;

  const NutrientColumn({
    Key? key,
    required this.nutrient,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            nutrient,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// MealTile widget for reusability
class MealTile extends StatelessWidget {
  final String mealName;
  final String recommendedCalories;

  const MealTile({
    Key? key,
    required this.mealName,
    required this.recommendedCalories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          '$mealName\n',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(recommendedCalories),
        trailing: const Icon(Icons.add),
        onTap: () {
          // Add functionality to add the meal
        },
      ),
    );
  }
}
