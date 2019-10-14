import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:communication_feedback_flutter/controller/message_controller.dart';
import 'package:communication_feedback_flutter/repository/dbcontext.dart';

import 'contact.dart';

void main() {
  DbContext().initDB("messages0.db").then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Communication feedback flutter',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: ChangeNotifierProvider(
        builder: (context) => MessageController(),
        child: Contact(),
      ),
    );
  }
}
