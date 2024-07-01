import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyramend/shared/styles/colors/colors.dart';
import '../../authentication/views/provider.dart';
import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/componenets/common_widgets/multi_select.dart';
import 'meal_details_screen.dart';

class RecommendMealsPage extends StatefulWidget {
  @override
  _RecommendMealsPageState createState() => _RecommendMealsPageState();
}

class _RecommendMealsPageState extends State<RecommendMealsPage> {
  List<String> _selectedPreferences = [];
  List<dynamic> _recommendedMeals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Recommend Meal',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTitle('Keywords'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MultiSelectDropdown(
                      items: [
                        'breakfast',
                        'lunch',
                        'dinner-party',
                        'egyptian',
                        'beef',
                        'chicken',
                        'meat',
                        'european',
                        'vegetarian',
                        'desserts',
                        'fruit',
                        'easy',
                        'inexpensive',
                        'healthy',
                        'seafood',
                        'low-calorie',
                        'spicy',
                        'snacks',
                        'salads',
                        'candy',
                        'asian',
                        'pasta',
                        'diabetic',
                        'vegan',
                        'middle-eastern',
                      ],
                      selectedItems: _selectedPreferences,
                      onChanged: (selectedItems) {
                        setState(() {
                          _selectedPreferences = selectedItems;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    if (_recommendedMeals.isNotEmpty) ...[
                      buildTitle('Recommended Meals'),
                      ..._recommendedMeals.map((meal) => buildMealCard(meal)),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildStaticPart(context),
    );
  }

  Widget buildTitle(String text) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 15,
            height: 2.5,
            color: Color(0xFF0A0909),
          ),
        ),
      ),
    );
  }

  Widget buildStaticPart(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 10,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: RoundedButton(
        height: 60,
        width: double.maxFinite,
        backgroundColor: Color(0xbefc8f10),
        textColor: Ucolor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imgs/recommend_icon.png',
                height: 20, width: 20),
            SizedBox(width: 8),
            Text(
              'Recommend',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Ucolor.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        onPressed: () async {
          if (_selectedPreferences.isEmpty) {
            // Show an alert or snackbar if no preferences are selected
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please select at least one preference.'),
              ),
            );
            return;
          }

          // Get instance of UserProvider
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);

          // Call recommendMeals function from UserProvider and get recommended meals
          final recommendedMeals =
              await userProvider.recommendMeals(_selectedPreferences);

          // Update the state to display the recommended meals
          setState(() {
            _recommendedMeals = recommendedMeals;
          });
        },
      ),
    );
  }

  Widget buildMealCard(Map<String, dynamic> meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailsScreen(meal: meal),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 21, 0),
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: LinearGradient(
                          colors: [Color(0xFFF4F696), Color(0xFFE6877A)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.asset(
                            'assets/imgs/all_food.png',
                            // Replace with your placeholder image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 9, 0, 9),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Text(
                          meal['name'] ?? '',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF1D1617),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Add an arrow icon for navigation
            Icon(Icons.arrow_circle_right_outlined, color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
