import 'package:flutter/material.dart';

class bghome extends StatelessWidget {
  final Widget child;
  const bghome({
    Key? key,
    required this.child
    }) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sz = MediaQuery.of(context).size;
    return Container(
      height: sz.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment(0.0, - 0.85),
        children: <Widget>[
          Container(
            width: 200, //260
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/logo.png'
                ),
                  fit: BoxFit.fill
                ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}