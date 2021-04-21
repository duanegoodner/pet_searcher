import 'package:flutter/material.dart';

class StandardLoadingScreen extends StatelessWidget {
  final String message;

  const StandardLoadingScreen({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
