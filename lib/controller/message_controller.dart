import 'package:device_id/device_id.dart';
import 'package:flutter/widgets.dart';
import 'package:send_message_by_mail/repository/message_dao.dart';
import 'package:send_message_by_mail/service/message_service.dart';

class MessageController extends ChangeNotifier {

  MessageDAO _messageDAO = MessageDAO();
  MessageService _messageService = MessageService();
  List<String> _messages;
  List<String> get messages => _messages ?? List<String>();
  bool get hasMessages => _messages != null && _messages.isNotEmpty;

  Future<void> sendMessage(String message) async {
    var deviceId = await DeviceId.getID;
    await _messageDAO.saveMessage(message, deviceId);
    await _messageService.sendMessage(message, deviceId);
  }

  Future<void> loadMessages() async {
    _messages = await _messageDAO.getSavedMessages();
    notifyListeners();
  }

}