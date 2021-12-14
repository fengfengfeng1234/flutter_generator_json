import 'package:json_annotation/json_annotation.dart';

class MessageInfo {
  final String desc;
  final int age;
  final String project;

  MessageInfo({required this.project, required this.desc, required this.age});

}
