import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/MyError.dart';
import 'package:flutter_application_1/Components/validator.dart';
import 'package:flutter_application_1/pages/TodoPage.dart';

import '../Components/Mybutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();

  final String originalEmail = "test@gmail.com";
  final String originalPassword = "Test@password";
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void signin() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 255, 51, 1),
          ),
        );
      },
    );

    Timer(Duration(seconds: 3), () {
      String enteredEmail = _email.text;
      String enteredPassword = _password.text;

      if (enteredEmail == originalEmail &&
          enteredPassword == originalPassword) {
        print("True");
        Navigator.of(context).pop();
        // Navigator.pushAndRemoveUntil<void>(
        //   context,
        //   MaterialPageRoute<void>(
        //       builder: (BuildContext context) => TodoPage()),
        //   ModalRoute.withName('/'),
        // );
        Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => TodoPage()),
        );
      } else {
        Navigator.of(context).pop();
        // print("false");
        if (enteredEmail != originalEmail) {
          MyError(context, "ok", "Enter Correct Email");
        }
        if (enteredPassword != originalPassword) {
          MyError(context, "ok", "Enter Correct Password");
        }
      }
    });
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    if (isValid) {
      // update();
      signin();
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/login.png",
                        scale: 10,
                      ),

                      const Text(
                        "Welcome Back, We Missed You!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        // maxLines: 5,
                        // validator: validator,
                        cursorColor: Colors.yellow[600],
                        controller: _email,
                        // autofocus: true,
                        obscureText: false,
                        enableSuggestions: true,
                        expands: false,
                        decoration: InputDecoration(
                            hintText: "Enter  the  Email",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusColor: Colors.yellow[600],
                            suffixIcon: Icon(Icons.person),
                            suffixIconColor: Colors.grey,
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.grey[500],
                            )),
                        // keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          //Validator
                        },
                        validator: (value) {
                          return vEmail(value);
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //password field
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        // maxLines: 5,
                        // validator: validator,
                        cursorColor: Colors.yellow[600],
                        controller: _password,
                        // autofocus: true,
                        obscureText: false,
                        enableSuggestions: true,
                        expands: false,
                        decoration: InputDecoration(
                            hintText: "Enter  the  Password",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            focusColor: Colors.yellow[600],
                            suffixIcon: Icon(Icons.lock),
                            suffixIconColor: Colors.grey,
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Colors.grey[500],
                            )),
                        // keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value) {
                          //Validator
                        },
                        validator: (value) {
                          return vPassword(value);
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      // Signin Button
                      MyButton(
                        onTap: _submit,
                        text: 'Sign In',
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
