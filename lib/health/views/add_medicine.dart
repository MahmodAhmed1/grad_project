import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../main.dart';
import '../../shared/componenets/common_widgets/selectable_box.dart';
import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/componenets/common_widgets/text_fields.dart';
import '../../shared/styles/colors/colors.dart';
import '../../authentication/views/provider.dart';

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _medNameController = TextEditingController();
  final TextEditingController _notificationHourController =
      TextEditingController();
  final TextEditingController _howLongController = TextEditingController();
  String _pillsDuration = 'BeforeEating'; // Default value
  String _dose = '0.5';
  String _notificationHour = '12:00'; // Default value

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showAlert(context);
    });
  }

  Future<void> _showAlert(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('Emergency Note'),
            ],
          ),
          content: const Text(
              'You MUST do a sensitivity test before you take the medicine'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addMedicine() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response =
            await Provider.of<UserProvider>(context, listen: false).addMedicine(
          medName: _medNameController.text,
          dose: _dose,
          notificationHour: _notificationHour,
          howLong: int.tryParse(_howLongController.text) ?? 0,
          pillsDuration: _pillsDuration,
        );
        if (response) {
          print(
              'Scheduling notification for the specified hour: $_notificationHour');
          await _scheduleNotification(_notificationHour);
          Navigator.pop(context, true);
          setState(() {});
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding medicine: $e')),
        );
      }
    }
  }

  Future<void> _scheduleNotification(String notificationHour) async {
    print('Scheduling notification for $notificationHour'); // Debug statement

    final List<String> timeParts = notificationHour.split(':');
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);

    final DateTime now = DateTime.now();
    DateTime scheduledDate =
        DateTime(now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(
          days: 1)); // Schedule for the next day if the time has already passed
    }

    tz.initializeTimeZones();
    String timeZoneName = tz.local.name; // Use local timezone

    tz.TZDateTime scheduledDateTime = tz.TZDateTime(
      tz.getLocation(timeZoneName),
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
    );

    print(
        'Notification scheduled for $scheduledDateTime in timezone $timeZoneName'); // Debug statement

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'your_channel_id', // Replace with a unique channel ID
      'your_channel_name', // Replace with a channel name
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Medicine Reminder',
      'Time to take your medicine!',
      scheduledDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('Notification scheduled successfully'); // Debug statement
  }

  Widget buildTitle(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: const TextStyle(
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
        _notificationHour = formattedTime;
        _notificationHourController.text = _notificationHour;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Medicine',
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
                      buildTitle('Medicine Name'),
                      RoundedTextField(
                        controller: _medNameController,
                        hintText: 'Name',
                        prefixIconPath:
                            'assets/imgs/pills.png', // Adjust the path as needed
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid medicine name';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildTitle('Dose'),
                          const Text(
                            "Too much pills can cause death",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ],
                      ),
                      RoundedTextField(
                        hintText: 'Select Dose',
                        prefixIconPath: 'assets/imgs/2pills.png',
                        dropdownItems: List.generate(
                          10,
                          (index) => (0.5 * (index + 1)).toString(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dose = value!;
                          });
                        },
                      ),
                      buildTitle('How Long'),
                      RoundedTextField(
                        controller: _howLongController,
                        hintText: 'In Days',
                        keyboardType: TextInputType.number,
                        prefixIconPath:
                            'assets/imgs/calendar.png', // Adjust the path as needed
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Please enter a valid duration';
                          }
                          return null;
                        },
                      ),
                      buildTitle('Food & Pills'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SelectableBox(
                              text: 'Before',
                              iconPath: 'assets/imgs/beforeEating.png',
                              isSelected: _pillsDuration == 'BeforeEating',
                              onTap: () {
                                setState(() {
                                  _pillsDuration = 'BeforeEating';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Add some spacing between the boxes
                          Expanded(
                            child: SelectableBox(
                              text: 'In Middle',
                              iconPath: 'assets/imgs/inMiddle.png',
                              isSelected: _pillsDuration == 'InMiddle',
                              onTap: () {
                                setState(() {
                                  _pillsDuration = 'InMiddle';
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Add some spacing between the boxes
                          Expanded(
                            child: SelectableBox(
                              text: 'After',
                              iconPath: 'assets/imgs/afterEating.png',
                              isSelected: _pillsDuration == 'AfterEating',
                              onTap: () {
                                setState(() {
                                  _pillsDuration = 'AfterEating';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      buildTitle('Notification'),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: RoundedTextField(
                            controller: _notificationHourController,
                            hintText: 'Alarm Time',
                            prefixIconPath: 'assets/imgs/notification.png',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a notification time';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(1.0),
                  ],
                  stops: [0.0, 0.1], // Adjust stops as needed
                ),
              ),
              child: RoundedButton(
                onPressed: _addMedicine,
                width: double.maxFinite,
                backgroundColor: Ucolor.DarkGray,
                textColor: Ucolor.white,
                title: 'Save',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
