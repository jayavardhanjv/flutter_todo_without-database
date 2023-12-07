import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Mybutton.dart';
import 'package:flutter_application_1/Components/Mylist.dart';
// import 'package:flutter_application_1/Components/MylistBuilder.dart';
import 'package:flutter_application_1/Components/validator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/MyError.dart';

class TodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoPage();
  }
}

class _TodoPage extends State<TodoPage> {
  TextEditingController dateInput = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  final TextEditingController _task = TextEditingController();
  var todos = [];
  bool check = false;

  @override
  void initState() {
    super.initState();
    loadTodos(); // Load todos when the page initializes.
  }

  @override
  void dispose() {
    saveTodos(); // Save todos when the page is disposed.
    super.dispose();
  }

  Future<void> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedTodos = prefs.getStringList('todos');
    if (savedTodos != null) {
      setState(() {
        todos = savedTodos.map((todo) => jsonDecode(todo)).toList();
      });
    }
  }

  void saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'todos', todos.map((todo) => jsonEncode(todo)).toList());
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    if (isValid) {
      createTodo();
    }
    _formKey.currentState!.save();
  }

  void createTodo() {
    var data = {"date": dateInput.text, "desc": _task.text};
    setState(() {
      todos.add(data);
      _task.clear();
      dateInput.clear();
    });
    print(todos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TodoApp"),
          backgroundColor: Color.fromRGBO(255, 255, 2, 1),
        ),
        body: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(15),
            // height: MediaQuery.of(context).size.
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: dateInput,
                          cursorColor: Color.fromRGBO(255, 199, 39, 1),
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Enter Date",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(255, 255, 19, 1)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(255, 255, 19, 1)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              print("pickedDate");
                              print(pickedDate);
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              print("formattedDate");
                              print(formattedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            } else {
                              MyError(context, "", "Select the correct date");
                            }
                          },
                          validator: (value) {
                            return vDate(value);
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 120,
                          child: TextFormField(
                            cursorColor: Color.fromRGBO(255, 255, 19, 1),
                            expands: true,
                            controller: _task,
                            maxLines: null,
                            minLines: null,
                            decoration: InputDecoration(
                              labelText: "Write the task",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(255, 255, 19, 1)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(255, 255, 19, 1)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              return vDescription(value);
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        MyButton(onTap: _submit, text: "Submit"),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return MyList(
                        date: todos[index]['date'],
                        desc: todos[index]['desc'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
