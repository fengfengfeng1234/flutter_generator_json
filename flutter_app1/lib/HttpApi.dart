import 'package:json_parse_annotion/json_parse_annotion.dart';
import 'package:flutter_app1/MessageInfoRsp.dart';
import 'package:flutter_app1/RequestSubscription.dart';
import 'MessageInfo.dart';
part 'HttpApi.g.dart';

@Request()
abstract class HttpApi {

  @Code(3111)
  RequestSubscription<MessageInfoRsp> getUserInfo(@Body() MessageInfo userInfo);
}
