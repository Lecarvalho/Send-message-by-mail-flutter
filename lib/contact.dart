import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:send_message_by_mail/controller/message_controller.dart';
import 'package:send_message_by_mail/message_widget.dart';

import 'send_message_widget.dart';

class Contact extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send us a message"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Consumer<MessageController>(
                builder: (context, messageController, child) {
                  return FutureBuilder<List<String>>(
                    future: messageController.getMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount:
                              snapshot.data != null ? snapshot.data.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return MessageWidget(snapshot.data[index]);
                          },
                        );
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
          ),
          Divider(height: 1.0),
          SendMessageWidget(),
        ],
      ),
    );
  }
}
