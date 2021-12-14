import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:json_parse_annotion/json_parse_annotion.dart';
import 'package:source_gen/source_gen.dart';

///
/// 1.只能拦截到 top-level 级别的元素，对于类内部属性、方法等无法拦截
/// 2.单独注解处理器  每一个注解都只可以处理一种注解
///
/// 参数解释:
///  1. Element element：被 annotation 所修饰的元素，通过它可以获取到元素的name、可见性等
///  2. 表示注解对象，通过它可以获取到注解相关信息以及参数值
///  3. 这一次构建的信息，通过它可以获取到一些输入输出信息，例如输入文件名
///
/// 参考: https://www.jianshu.com/p/76adcc3f5541
///
/// 路由模板 参考:  https://juejin.cn/post/6844903954044862471
///
class JsonDataGenerator extends GeneratorForAnnotation<JsonParse> {
  HashMap<String, dynamic> filedMap = new HashMap();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print(element.toString());

    if (element.kind == ElementKind.CLASS) {
      for (var e in (element as ClassElement).fields) {
        print("filed ====" +
            e.name +
            "   filed Type  == " +
            e.type.isDartCoreString.toString());

        filedMap[e.name] = e.name;
      }
    }


    String top = "part of '${element.name}.dart';\n\n\n";

    String one =
        " Map<String, dynamic>  _" +
        element.name! +
        "ToJson(" +
        element.name! +
        " obj) => <String, dynamic>{\n\n";

    String two = "";

    filedMap.forEach((key, value) {
      two = two + "\"$key\":obj." + value + ", \n";
    });

    String three = "};\n\n" ;

    return top + one + two + three;
  }
}
