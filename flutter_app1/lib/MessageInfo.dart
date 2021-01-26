import 'package:json_annotation/json_annotation.dart';
part 'MessageInfo.g.dart';

@JsonSerializable()
class MessageInfo {
  final String desc;
  final int age;
  final String project;

  MessageInfo({this.project, this.desc, this.age});

  factory MessageInfo.fromJson(Map<String, dynamic> json) => _$MessageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MessageInfoToJson(this);
}
