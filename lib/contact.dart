import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:communication_feedback_flutter/controller/message_controller.dart';
import 'package:communication_feedback_flutter/message_widget.dart';

import 'send_message_widget.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  MessageController _messageController;
  bool _isPageReady = false;

  @override
  void didChangeDependencies() async {
    _messageController = Provider.of<MessageController>(context, listen: false);
    await _messageController.loadMessages();
    setState(() {
    _isPageReady = true;      
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send us a message"),
      ),
      body: _isPageReady ? Consumer<MessageController>(
        builder: (context, messageController, child) {
          return Container(
            decoration: !messageController.hasMessages
                ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/contact_placeholder.png"),
                      fit: BoxFit.none,
                      alignment: Alignment.topCenter,
                    ),
                  )
                : BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: new ListMessagesWidget(
                      messages: _messageController.messages,
                    ),
                  ),
                ),
                SendMessageWidget(),
              ],
            ),
          );
        },
      ) : Container(),
    );
  }
}

class ListMessagesWidget extends StatelessWidget {
  final List<String> messages;
  const ListMessagesWidget({this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return MessageWidget(messages[index]);
      },
    );
  }
}
