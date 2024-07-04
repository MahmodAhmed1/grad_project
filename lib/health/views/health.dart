import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../authentication/views/provider.dart';
import '../../shared/componenets/common_widgets/buttons.dart';
import '../../shared/styles/colors/colors.dart';
import 'add_medicine.dart';

class HealthView extends StatefulWidget {
  const HealthView({Key? key}) : super(key: key);

  @override
  _HealthViewState createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  late Future<Map<String, dynamic>> medicineFuture;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    medicineFuture =
        Provider.of<UserProvider>(context, listen: false).getMedicine();
  }

  Future<void> _refreshMedicine() async {
    final updatedMedicineFuture =
        Provider.of<UserProvider>(context, listen: false).getMedicine();
    setState(() {
      medicineFuture = updatedMedicineFuture;
    });
  }

  Future<void> _showMissedMedicines(BuildContext context) async {
    try {
      final missedMedicines =
          await Provider.of<UserProvider>(context, listen: false)
              .getMissedMedicines();
      int totalMissedMedicines = missedMedicines['totalMissedMedicines'];
      List<String> medNames = List<String>.from(missedMedicines['medNames']);

      String message;
      String message2 = '';
      String message3 = '';

      if (totalMissedMedicines == 0) {
        message =
            'There are no missed medicines. You are on the right track! Keep going!';
      } else {
        message = 'Here are the missed medicines for today:\n';
        message2 = '${medNames.join(", ")}.';
        message3 =
            '\nYou should contact your doctor urgently to recover these medicines.';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Missed Medicines',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  message2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Add more Text widgets for additional messages
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Color(0xFF1BD15D)),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error fetching missed medicines: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building HealthView widget');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Medicine Schedule',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 35, 16, 24),
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return RefreshIndicator(
                onRefresh: _refreshMedicine,
                child: FutureBuilder<Map<String, dynamic>>(
                  future: medicineFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('An error occurred: ${snapshot.error}');
                    } else {
                      String userName = userProvider.userName;

                      // Get the data array from the response
                      List<dynamic> data = snapshot.data?['data'] ?? [];
                      int medicineCount = data.length;
                      int takenCount =
                          data.where((item) => item['taken'] == true).length;

                      // Use ListView.builder to create a new rectangle for each item in the data array
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 35),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'Hello, \n',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28,
                                    height: 1.4,
                                    color: Color(0xFF0A0909),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '$userName',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 28,
                                        height: 1.3,
                                        color: Color(0xFF0A0909),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 39),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 28, 0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF3F6C8),
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(24, 53, 0, 53),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 2),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Your plan\nfor today',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 20,
                                                    decoration:
                                                        TextDecoration.none,
                                                    height: 1.3,
                                                    color: Color(0xFF0A0909),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Opacity(
                                                opacity: 0.6,
                                                child: Text(
                                                  '$takenCount of $medicineCount done',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    height: 2.2,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 35,
                                    right: -40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/imgs/medicine_cover.png',
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            width: 208,
                                            height: 126,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Daily Review',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  height: 2.2,
                                  color: Color(0xFF0A0909),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Scaffold(
                              body: snapshot.data?.containsKey('data') == true
                                  ? AnimatedList(
                                      key: _listKey,
                                      initialItemCount: data.length,
                                      itemBuilder: (context, index, animation) {
                                        // Get the medName for the current item
                                        String medName = data[index]['medName'];
                                        String hour =
                                            data[index]['NotificationHour'];
                                        dynamic dose = data[index]['Dose'];
                                        dynamic howLong =
                                            data[index]['howLong'];
                                        String pillsDuration =
                                            data[index]['pillsDuration'];
                                        bool taken = data[index]['taken'];

                                        // Determine the status text based on the 'taken' value
                                        String statusText =
                                            taken ? 'Completed' : pillsDuration;

                                        // Return a rectangle with the medName
                                        return SizeTransition(
                                          sizeFactor: animation,
                                          child: Material(
                                            // Ensure there is a Material widget ancestor
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF8F8F6),
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    // Shadow color
                                                    spreadRadius: 1,
                                                    // Spread radius
                                                    blurRadius: 7,
                                                    // Blur radius
                                                    offset: Offset(-2,
                                                        5), // Offset (horizontal, vertical)
                                                  ),
                                                ],
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    30, 14, 12.3, 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(0, 14,
                                                                  18, 13),
                                                          width: 20,
                                                          height: 20,
                                                          child: Image.asset(
                                                              'assets/imgs/pills.png'),
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                '$medName | Dose: $dose',
                                                                style:
                                                                    TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 15,
                                                                  color: Color(
                                                                      0xFF0A0909),
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '$hour | $statusText | $howLong days',
                                                                  style:
                                                                      TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        13,
                                                                    color: Color(
                                                                        0xFF9B9B9B),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(width: 10),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 12.8, 0, 7.7),
                                                      child: SizedBox(
                                                        width: 48,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: statusText !=
                                                                        'Completed'
                                                                    ? () async {
                                                                        try {
                                                                          await Provider.of<UserProvider>(context, listen: false).updateMedicine(
                                                                              context,
                                                                              medName);
                                                                          setState(
                                                                              () {
                                                                            medicineFuture =
                                                                                Provider.of<UserProvider>(context, listen: false).getMedicine();
                                                                          });
                                                                        } catch (e) {
                                                                          // Handle the error, e.g. show an error message
                                                                        }
                                                                      }
                                                                    : null,
                                                                child: Opacity(
                                                                  opacity:
                                                                      statusText ==
                                                                              'Completed'
                                                                          ? 0.3
                                                                          : 1,
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            3.5,
                                                                            0),
                                                                    width: 22.5,
                                                                    height:
                                                                        22.5,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/imgs/checked.png'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  try {
                                                                    _listKey
                                                                        .currentState
                                                                        ?.removeItem(
                                                                      index,
                                                                      (context,
                                                                              animation) =>
                                                                          SizeTransition(
                                                                        sizeFactor:
                                                                            animation,
                                                                        child:
                                                                            Container(
                                                                          margin: EdgeInsets.fromLTRB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              12),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFF8F8F6),
                                                                              borderRadius: BorderRadius.circular(24),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                    await Provider.of<UserProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .deleteMedicine(
                                                                            context,
                                                                            medName);
                                                                    setState(
                                                                        () {
                                                                      medicineFuture = Provider.of<UserProvider>(
                                                                              context,
                                                                              listen: false)
                                                                          .getMedicine();
                                                                    });
                                                                  } catch (e) {
                                                                    // Handle the error, e.g. show an error message
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 22.5,
                                                                    height:
                                                                        22.5,
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/imgs/delete.png'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : snapshot.data?['message'] ==
                                          'You have not added any medicines yet.'
                                      ? Center(
                                          child: Text(
                                              'You have not added any medicines yet.'))
                                      : Center(child: Text('Loading...')),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
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
                                    backgroundColor: Color(0xbeE42121),
                                    textColor: Ucolor.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            'assets/imgs/pills_white.png',
                                            height: 20,
                                            width: 19),
                                        // Adjust size as needed
                                        SizedBox(width: 8),
                                        // Adjust spacing as needed
                                        Text(
                                          'Missed',
                                          style: TextStyle(
                                            color: Ucolor.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      _showMissedMedicines(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RoundedButton(
                                    width: double.maxFinite,
                                    height: 60,
                                    backgroundColor: Ucolor.DarkGray,
                                    textColor: Ucolor.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/imgs/add_white.png',
                                            height: 30, width: 30),
                                        // Adjust size as needed
                                        // Adjust spacing as needed
                                        Text(
                                          'Add',
                                          style: TextStyle(
                                            color: Ucolor.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      // Navigate to AddMedicine and wait for result
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddMedicine(),
                                        ),
                                      ).then((result) {
                                        if (result == true) {
                                          // Check the result
                                          _refreshMedicine();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
