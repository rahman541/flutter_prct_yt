import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'Message.g.dart';

@JsonSerializable(nullable: false)
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  static Future<List<Message>> browse({status = 'important'}) async {
    String url = status == 'important' ? 'http://www.mocky.io/v2/5dbd330f3300004d2f16a14f' : 'http://www.mocky.io/v2/5dbb06fe300000560e02940b';

    // String content = await rootBundle.loadString('data/message.json');
    http.Response response = await http.get(url);
    
    await Future.delayed(Duration(seconds: 1));
    
    String content = response.body;
    List collection = json.decode(content);
    List<Message> _messages = collection.map((json)=>Message.fromJson(json)).toList();

    return _messages;
  }
}