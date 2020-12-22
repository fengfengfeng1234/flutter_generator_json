import 'package:json_parse_annotion/json_parse_annotion.dart';

part 'MessageInfo.g.dart';

@JsonParse()
class MessageInfo {
  final String desc;
  final int age;
  final String project;

  MessageInfo({this.project, this.desc, this.age});

  Map<String, dynamic> toJson() => _MessageInfoToJson(this);
}
