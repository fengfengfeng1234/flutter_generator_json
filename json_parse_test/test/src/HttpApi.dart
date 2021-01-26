import 'package:json_parse_annotion/json_parse_annotion.dart';
import 'MessageInfo.dart';
import 'MessageInfoRsp.dart';
import 'RequestSubscription.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(
  r'''
class _HttpApi implements HttpApi {
  String _baseUrl;

  @override
  RequestSubscription<MessageInfoRsp> getUserInfo() {
    return 1 + 2;
  }
}
''',
  configurations: ['default'],
)
@Request()
abstract class HttpApi {
  HttpApi();

  @Code(3111)
  RequestSubscription<MessageInfoRsp> getUserInfo1(MessageInfo userInfo);

  @Code(23)
  RequestSubscription<MessageInfoRsp> getUserInfo2(MessageInfo xxxxx);
}
