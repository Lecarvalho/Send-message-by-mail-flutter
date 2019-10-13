import 'package:send_message_by_mail/repository/dbcontext.dart';

class MessageDAO {
  DbContext _dbContext = DbContext();
  Future<void> saveMessage(String message, String userId) async {
    await _dbContext.messageDb.rawInsert("INSERT INTO Message (message, userId) VALUES ('$message', '$userId')");
  }

  Future<List<String>> getSavedMessages() async {
    var messages = await _dbContext.messageDb.rawQuery("SELECT message FROM Message");
    if (messages.isNotEmpty){
      return List<String>.from(messages.map((m) => m["message"]).toList());
    }
    return null;
  }
}