import 'package:flutter/material.dart';
import '../../styles/colors/colors.dart';
import '../constants/constants.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onChanged;

  MultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.onChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showMultiSelectDialog(context),
          child: InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              hintText: 'Select Meal Type',
              hintStyle: TextStyle(color: Ucolor.gray, fontSize: smallFotSize),
              prefixIcon: Container(
                width: iconWidth,
                height: iconHeight,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/select_meal.png',
                  width: iconWidth,
                  height: iconHeight,
                  fit: BoxFit.contain,
                  color: Ucolor.gray,
                ),
              ),
              suffixIcon: Icon(Icons.arrow_forward_ios, color: Ucolor.gray), // Added suffixIcon here
              fillColor: Ucolor.lightGray, // Add this line to set the background color
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
            child: Text(
              _selectedItems.join(', '),
              style: TextStyle(color: Ucolor.gray, fontSize: smallFotSize),
            ),
          ),
        ),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: _selectedItems.map((item) {
            return Chip(
              label: Text(item),
              onDeleted: () {
                setState(() {
                  _selectedItems.remove(item);
                  widget.onChanged(_selectedItems);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showMultiSelectDialog(BuildContext context) async {
    final List<String>? results = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: widget.items,
          selectedItems: _selectedItems,
        );
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
        widget.onChanged(_selectedItems);
      });
    }
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;

  MultiSelectDialog({
    required this.items,
    required this.selectedItems,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _tempSelectedItems;

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Meal Types'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _tempSelectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? checked) {
                setState(() {
                  if (checked == true) {
                    _tempSelectedItems.add(item);
                  } else {
                    _tempSelectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            Navigator.pop(context, _tempSelectedItems);
          },
        ),
      ],
    );
  }
}
