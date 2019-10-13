import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  const MessageWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.all(20),
      child: Text(
        message,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
