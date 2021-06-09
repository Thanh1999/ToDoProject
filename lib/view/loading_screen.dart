import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingScreen extends StatelessWidget {
  final String? title;

  LoadingScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(), Text(title ?? "")],
        ),
      ),
    );
  }
}
