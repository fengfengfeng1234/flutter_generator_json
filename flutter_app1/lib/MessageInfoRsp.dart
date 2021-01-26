import 'package:json_annotation/json_annotation.dart';

part 'MessageInfoRsp.g.dart';

@JsonSerializable()
class MessageInfoRsp {
  final String desc;
  final int age;
  final String project;

  MessageInfoRsp({this.project, this.desc, this.age});

  factory MessageInfoRsp.fromJson(Map<String, dynamic> json) =>
      _$MessageInfoRspFromJson(json);

  Map<String, dynamic> toJson() => _$MessageInfoRspToJson(this);
}
