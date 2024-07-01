import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

Widget sizedBoxHeight(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sizedBoxWidth(double width) {
  return SizedBox(
    width: width,
  );
}

String formatDateTime(String time, String date) {
  DateTime now = DateTime.now();

  if (date.isNotEmpty) {
    // Check if the date string matches the "MMM d, yyyy" format
    RegExp regExp = RegExp(r'^[A-Za-z]{3}\s\d{1,2},\s\d{4}$');
    if (regExp.hasMatch(date)) {
      // Parse the date string using the "MMM d, yyyy" format
      DateTime taskDate = DateFormat('MMM d, yyyy').parse(date);

      if (now.year == taskDate.year && now.month == taskDate.month) {
        if (now.day == taskDate.day) {
          date = "Today";
        } else if (now.day == taskDate.day + 1) {
          date = "Tomorrow";
        } else {
          date = DateFormat('MMM d').format(taskDate); // Format the date
        }
      }
    }
  }

  if (time.isNotEmpty) {
    return date.isNotEmpty ? "$date At $time" : time;
  } else {
    return date.isNotEmpty ? date : "No Date or Time Set";
  }
}

Widget emptyTaskWidget() {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/imgs/Checklist-image.png'),
              width: 227,
              height: 227,
              fit: BoxFit.contain,
            ),
            sizedBoxHeight(35),
            const Text(
              "What do you want to do today?",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            sizedBoxHeight(10),
            const Text(
              "Tap + to add your tasks",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            sizedBoxHeight(35),
          ],
        ),
      ),
    ),
  );
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
