import 'package:flutter/material.dart';

class MylistBuilder extends StatefulWidget {
  const MylistBuilder({Key? key}) : super(key: key);

  @override
  State<MylistBuilder> createState() => _MylistBuilderState();
}

class _MylistBuilderState extends State<MylistBuilder> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              check = !check; // Toggle checkbox value on tap
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 9,
            decoration: BoxDecoration(
              border:
                  Border.all(color: Color.fromRGBO(255, 255, 2, 1), width: 4),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(255, 255, 2, 1),
                ),
              ],
            ),
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(4),
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
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "to complete the taskasdasffasfasfasffas",
                        overflow: TextOverflow
                            .ellipsis, // Handle overflow with ellipsis
                        maxLines: 1, // Limit to 1 line
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Date: 55-31-4122",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
