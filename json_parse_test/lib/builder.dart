

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/JsonDataGenerator.dart';

//
// PartBuilder
// LibraryBuilder
// SharedPartBuilder
// MultiplexingBuilder

//如果要编写可import使用的 独立Dart库LibraryBuilder。
// 只能将一个Generator用作LibraryBuilder

///
///这个是类似于 java Aop 的 resource/META-INF.services 配置 Processor，
///相当于生成器的入口
///

Builder  jsonDataBuilder(BuilderOptions options) =>
    LibraryBuilder(JsonDataGenerator(),generatedExtension: '.g.dart');


// Builder  filedDataBuilder(BuilderOptions options) =>
//     LibraryBuilder(FiledDataGenerator(),generatedExtension: '.table.dart');