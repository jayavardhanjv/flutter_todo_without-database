import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyList extends StatefulWidget {
  final String desc;
  final String date;

  const MyList({Key? key, required this.date, required this.desc})
      : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  bool check = false;
  late Color dateColor;

  @override
  void initState() {
    super.initState();
    dateColor = _getDateColor();
  }

  Color _getDateColor() {
    DateTime currentDate = DateTime.now();

    // Extract year, month, and day from currentDate without time
    DateTime currentDateWithoutTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    List<String> dateParts = widget.date.split('-');
    int year = int.parse(dateParts[2]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[0]);

    // Create a DateTime object with date information and time set to midnight
    DateTime taskDate = DateTime(year, month, day);
    String formattedDate = DateFormat('dd-MM-yyyy').format(taskDate);
    print("formattedDate");
    print(formattedDate);

    // Compare the date parts of currentDate and taskDate
    if (taskDate == currentDateWithoutTime) {
      return Colors.yellow;
    } else if (taskDate.isBefore(currentDateWithoutTime)) {
      return Colors.red;
    } else if (taskDate.isAfter(currentDateWithoutTime)) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width - 20,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 3.0,
            offset: Offset(3.0, 3.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: Colors.white,
            focusColor: Color.fromRGBO(255, 255, 2, 1),
            value: check,
            onChanged: (bool? value) {
              setState(() {
                check = value ?? false;
              });
            },
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.desc,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                  decoration:
                      check ? TextDecoration.lineThrough : TextDecoration.none,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                widget.date,
                style: TextStyle(fontSize: 16, color: dateColor),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
