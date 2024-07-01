import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pyramend/meals/views/recommend_meals.dart';
import '../../authentication/views/provider.dart';
import '../../shared/componenets/common_widgets/buttons.dart'; // Assuming you have a RoundedButton widget
import '../../shared/styles/colors/colors.dart'; // Assuming you have a Ucolor class for colors
import 'add_meal.dart'; // Create this file for adding meals

class MealView extends StatefulWidget {
  const MealView({super.key});

  @override
  State<MealView> createState() => _MealViewState();
}

class _MealViewState extends State<MealView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchMeals();
    });
  }

  Future<void> _refreshMeals() async {
    await Provider.of<UserProvider>(context, listen: false).fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final meals = userProvider.meals;
    final totalMealsCalories = userProvider.totalMealsCalories;
    final totalNeedCalories = userProvider.totalNeedCalories;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meal Schedule',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      body: meals.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshMeals,
              child: Column(
                children: [
                  buildBanner(totalMealsCalories, totalNeedCalories),
                  Expanded(
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        buildMealSection('Breakfast'),
                        buildMealSection('Lunch'),
                        buildMealSection('Dinner'),
                        buildMealSection('Snack'),
                      ],
                    ),
                  ),
                  buildStaticPart(), // Add the static part here
                ],
              ),
            ),
    );
  }

  Widget buildBanner(int totalMealsCalories, int totalNeedCalories) {
    double percentage = totalMealsCalories / totalNeedCalories;

    return Container(
      margin: EdgeInsets.all(16.0),
      height: 230, // Adjust height as needed to make the image bigger
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/imgs/banner.png', // Replace with your image path
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50, // Adjust this value to move the content up or down
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center the content vertically
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the text vertically
                    children: [
                      Text(
                        'Suggested calories\nneeded: $totalNeedCalories',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Keep Going!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 10.0,
                    percent: percentage,
                    center: Text(
                      '  ${(totalNeedCalories - totalMealsCalories)}\nCal left',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                      ),
                    ),
                    progressColor: Colors.orange,
                    backgroundColor: Colors.white,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaticPart() {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
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
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecommendMealsPage(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: RoundedButton(
              width: double.maxFinite,
              height: 60,
              backgroundColor: Color(0xbefc8f10),
              textColor: Ucolor.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/imgs/add_white.png',
                      height: 25, width: 25),
                  Text(
                    'Add',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Ucolor.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                // Navigate to AddMeal and wait for result
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMeal(),
                  ),
                ).then((result) {
                  if (result == true) {
                    // Check the result
                    _refreshMeals();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMealSection(String mealType) {
    final meals = Provider.of<UserProvider>(context).meals;
    List<Map<String, dynamic>> mealTypeList =
        meals.where((meal) => meal['mealType'] == mealType).toList();

    // Calculate number of meals and sum of calories
    int mealCount = mealTypeList.length;
    int totalCalories = 0;
    for (var meal in mealTypeList) {
      totalCalories += meal['calories'] as int;
    }
    return mealTypeList.isEmpty
        ? SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$mealType',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      '$mealCount meals | $totalCalories calories',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.5,
                        color: Color(0xFFADA4A5),
                      ),
                    )
                  ], // |
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: mealTypeList.length,
                itemBuilder: (context, index) {
                  return buildMealCard(mealTypeList[index]);
                },
              ),
            ],
          );
  }

  Widget buildMealCard(Map<String, dynamic> meal) {
    String statusText = meal['taken'] ? 'Eaten' : 'Not Eaten';
    Color boxColor;
    String imagePath;

    String mealType = meal['mealType'];
    int calories = meal['calories'] as int;

    if (mealType == 'Breakfast') {
      boxColor = Colors.green;
      imagePath = 'assets/imgs/breakfast.png';
    } else if (mealType == 'Lunch') {
      boxColor = Colors.blue;
      imagePath = 'assets/imgs/lunch.jpg';
    } else if (mealType == 'Dinner') {
      boxColor = Colors.red;
      imagePath = 'assets/imgs/dinner.jpg';
    } else if (mealType == 'Snack') {
      boxColor = Colors.orange;
      imagePath = 'assets/imgs/snacks.jpg';
    } else {
      boxColor = Colors.grey;
      imagePath = 'assets/imgs/lunch.jpg';
    }

    bool taken = meal['taken'];

    return Padding(
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
                      color: boxColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          imagePath,
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
                        meal['mealName'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xFF1D1617),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${meal['NotificationHour']} | $statusText | $calories calories', // Display calories here
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5,
                          color: Color(0xFF7B6F72),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: taken
                    ? null
                    : () async {
                        try {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .updateMeal(context, meal['mealName']);
                          setState(() {
                            _refreshMeals();
                          });
                        } catch (e) {
                          // Handle the error, e.g. show an error message
                        }
                      },
                child: Opacity(
                  opacity: taken ? 0.5 : 1,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 3.5, 0),
                    width: 22.5,
                    height: 22.5,
                    child: Image.asset('assets/imgs/checked.png'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    await Provider.of<UserProvider>(context, listen: false)
                        .deleteMeal(context, meal['mealName']);
                    setState(() {
                      _refreshMeals();
                    });
                  } catch (e) {
                    // Handle the error, e.g. show an error message
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: 22.5,
                    height: 22.5,
                    child: Stack(
                      children: [
                        Image.asset('assets/imgs/delete.png'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
