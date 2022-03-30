import 'package:clockify/components/pass.dart';
import 'package:flutter/material.dart';

class password extends StatelessWidget {
  final String email;
  const password({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pass(
        email: email,
      ),
    );
  }
}