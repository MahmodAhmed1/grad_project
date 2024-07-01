import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/componenets/common_widgets/text_fields.dart';
import '../../shared/styles/colors/colors.dart';
import '../../authentication/views/provider.dart';

class AddMeal extends StatefulWidget {
  @override
  _AddMealState createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  String _mealType = 'Breakfast'; // Default value

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final String formattedTime = picked.hour.toString().padLeft(2, '0') +
          ':' +
          picked.minute.toString().padLeft(2, '0');
      setState(() {
        _timeController.text = formattedTime;
      });
    }
  }

  Future<void> _addMeal() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await Provider.of<UserProvider>(context, listen: false).addMeal(
          mealName: _mealNameController.text,
          mealType: _mealType,
          notificationHour: _timeController.text,
          calories: int.parse(_caloriesController.text),
        );
        if (response) {
          Navigator.pop(context, true);
          setState(() {});
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding meal: $e')),
        );
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Meal',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTitle('Meal Name'),
                      RoundedTextField(
                        controller: _mealNameController,
                        hintText: 'Name',
                        prefixIconPath: 'assets/icons/meals_icon.png', // Adjust the path as needed
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                      buildTitle('Meal Type'),
                      RoundedTextField(
                        hintText: 'Select Meal Type',
                        prefixIconPath: 'assets/icons/select_meal.png',
                        dropdownItems: ['Breakfast', 'Lunch', 'Dinner', 'Snack'],
                        onChanged: (value) {
                          setState(() {
                            _mealType = value!;
                          });
                        },
                      ),
                      buildTitle('Time'),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: RoundedTextField(
                            controller: _timeController,
                            hintText: 'Time',
                            prefixIconPath: 'assets/icons/notification_light.png',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a time';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      buildTitle('Calories'),
                      RoundedTextField(
                        controller: _caloriesController,
                        hintText: 'Calories',
                        keyboardType: TextInputType.number,
                        prefixIconPath: 'assets/icons/calories.png', // Adjust the path as needed
                        validator: (value) {
                          if (value == null || value.isEmpty || !RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Please enter a valid calorie count';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildStaticPart(context),
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
            Image.asset('assets/imgs/add_white.png',
                height: 20, width: 20),
            SizedBox(width: 8),
            Text(
              'Add',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Ucolor.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        onPressed: _addMeal,

      ),
    );
  }

}
