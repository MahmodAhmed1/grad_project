import 'package:flutter/material.dart';
import 'package:pyramend/fitness/data/models/exercise_model.dart';
import 'package:pyramend/fitness/views/exercise_details_view.dart';
import 'package:pyramend/shared/componenets/constants/enums.dart';

import 'package:pyramend/shared/styles/colors/colors.dart';

class ExerciseItem extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<bool?> onChecked;
  final bool isMarkDone;

  const ExerciseItem({
    Key? key,
    required this.exercise,
    required this.onChecked,
    this.isMarkDone = false,
  }) : super(key: key);

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  late bool isMarkDone;

  @override
  void initState() {
    super.initState();
    isMarkDone = widget.isMarkDone;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ExerciseDetailsView(exercise: widget.exercise),
            ),
          );
        },
        child: Container(
          height: media.width / 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: Ucolor.fitnessGradient.scale(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              // Exercise image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.network(
                    widget.exercise.gifUrl,
                    width: media.width / 9,
                    height: media.width / 9,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Icon(Icons.image_outlined, size: media.width / 9);
                    },
                  ),
                ),
              ),
              // Exercise name and checkbox
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          capitalize(widget.exercise.name),
                          style: TextStyle(
                            fontSize: media.width * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Ucolor.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMarkDone = !isMarkDone;
                          });
                          widget.onChecked(isMarkDone);
                        },
                        child: Image.asset(
                          isMarkDone
                              ? 'assets/imgs/checked.png'
                              : 'assets/imgs/unchecked.png',
                          width: 24,
                          height: 24,
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
    );
  }
}
