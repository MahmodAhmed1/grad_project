//lib/shared/components/common_widgets/cupertino_picker.dart
import 'package:flutter/cupertino.dart';
import 'package:pyramend/shared/componenets/constants/constants.dart';

import 'package:pyramend/shared/styles/colors/colors.dart';

class ItemPicker extends StatefulWidget {
  ItemPicker({
    required this.title,
    required this.step,
    required this.maxValue,
    required this.startingValue,
    required this.onChanged,
  });

  final String title;
  final int step;
  final int maxValue;
  final int startingValue;
  final void Function(int) onChanged;

  @override
  _ItemPickerState createState() => _ItemPickerState();
}

class _ItemPickerState extends State<ItemPicker> {
  late int selectedValueIndex;

  @override
  void initState() {
    super.initState();
    selectedValueIndex = (widget.startingValue / widget.step).round();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          widget.title,
          style: TextStyle(
            color: Ucolor.gray,
            fontSize: headerSmallFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return CupertinoPicker.builder(
                      itemExtent: 30,
                      scrollController: FixedExtentScrollController(
                          initialItem: selectedValueIndex),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedValueIndex = index;
                          int newValue = index * widget.step;
                          widget.onChanged(newValue);
                        });
                      },
                      itemBuilder: (context, index) {
                        final value = index * widget.step;
                        if (value < 0 || value > widget.maxValue) {
                          return null;
                        }
                        return Center(
                          child: Text(
                            '$value',
                            style: TextStyle(
                              fontSize: mediumFontSize,
                              color: Ucolor.DarkGray,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      childCount: (widget.maxValue / widget.step).ceil() + 1,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
