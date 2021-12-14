@TestOn('vm')
import 'package:json_parse_test/json_parse_test.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen_test/source_gen_test.dart';
import 'package:test/test.dart';

Future<void> main() async {
  initializeBuildLogTracking();
  final reader = await initializeLibraryReaderForDirectory(
      p.join('test', 'src'), 'http_api.dart');

  testAnnotatedElements(reader, HttpBuilderGenerator(),
      expectedAnnotatedTests: _expectedAnnotatedTests);
}

//
const _expectedAnnotatedTests = [
  'HttpApi',
  // 'getUserInfo',
];
