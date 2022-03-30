import 'package:clockify/components/background.dart';
import 'package:clockify/constants.dart';
import 'package:clockify/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:clockify/screens/password_screen.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = '';

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 8) {
      return "Password should be atleast 8 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 490, left: 50),
                child: Image.asset(
                  "assets/icons/email.png",
                  height: 18,
                  width: 24,
                ),
              ),
              Container(
                width: 290,
                margin: EdgeInsets.only(top: 460, left: 12, right: 16),
                child: Form(
                  key: formkey,
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    onChanged: (text) {
                      email = text;
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      EmailValidator(errorText: "Enter a Valid Email")
                    ]),
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
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => password(
                                email: email,
                              )));
                  print("Validated");
                } else {
                  print("Not Validated");
                }
              },
              child: Text(
                'SIGN IN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => register()));
                },
                child: Text(
                  "Create new account?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
