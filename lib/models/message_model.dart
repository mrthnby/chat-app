import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String from;
  final String to;
  final String content;
  final bool isFromMe;
  final DateTime date;

  MessageModel({
    required this.from,
    required this.to,
    required this.content,
    required this.isFromMe,
    required this.date,
  });

  MessageModel.fromMap(Map<String, dynamic> data)
      : this(
          from: data["from"],
          to: data["to"],
          content: data["content"],
          isFromMe: data["isFromMe"],
          date: (data["date"] as Timestamp).toDate(),
        );

  Map<String, dynamic> toMap(MessageModel message) {
    return {
      "from": from,
      "to": to,
      "content": content,
      "isFromMe": isFromMe,
      "date": date,
    };
  }
}
