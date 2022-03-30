import 'dart:developer';

import 'package:clockify/components/background.dart';
import 'package:clockify/components/homes.dart';
import 'package:clockify/constants.dart';
import 'package:clockify/provider/ActivityState.dart';
import 'package:clockify/screens/SignIn_screen.dart';
import 'package:clockify/screens/home_screen.dart';
import 'package:clockify/screens/password_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class pass extends StatefulWidget {
  final String email;
  pass({Key? key, required this.email}) : super(key: key);

  @override
  _passState createState() => _passState();
}


class _passState extends State<pass> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String password = '';

  String? validatePassword(String value) {
      if (value.isEmpty) {
        return "* Required";
      } else if (value.length < 8) {
        return "Password should be atleast 8 characters";
      } else if (value.length > 15) {
        return "Password should not be greater than 15 characters";
      } else
        return null;
  }

  bool _obscure = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (
                              BuildContext context
                              ) => signIn()
                            )
                        );
                      },
                      child: Image.asset(
                        'assets/icons/back.png',
                        width: 18,
                        height: 20,
                      ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 150),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        ),
                      ),
                    ),
                    
                    Container(
                      width: 320,
                      margin: EdgeInsets.only(top: 250, right: 7),
                      child : Form(
                        key: formkey,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          obscureText: _obscure,
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          style: TextStyle(
                            color: lineColor,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _obscure=!_obscure;
                                });
                              },
                              child: Icon(_obscure 
                              ? Icons.visibility 
                              : Icons.visibility_off,
                              color: lineColor,
                              ),
                            ),
                            labelText: "Input Your Password",
                            labelStyle: TextStyle(
                              color: lineColor,
                              fontSize: 14
                              ),
                            enabledBorder : UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lineColor
                              ),
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Required"),
                            MinLengthValidator(8,
                                errorText: "Password should be atleast 8 characters"
                                ),
                            MaxLengthValidator(15,
                                errorText:
                                "Password should not be greater than 15 characters"
                                )
                          ])
                        ),
                      ),
                    ),   
                
                  ],
                ),
          
                Container(
                  width: 328,
                  height: 48,
                  margin: EdgeInsets.only(top: 32, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        log('email: ${widget.email}');
                        log('pass: $password');
                        bool correct = await context.read<ActivityState>().login(widget.email, password);
                        if (!correct) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('Akun tidak ditemukan.')));
                          return;
                        }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => home()));
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                    },
                    child: Text('OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      primary: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Text("Forgot Password?",
                      style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: lineColor,
                      fontSize: 18,
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}