import 'package:json_annotation/json_annotation.dart';


class MessageInfoRsp {
  final String desc;
  final int age;
  final String project;

  MessageInfoRsp({this.project, this.desc, this.age});

}
