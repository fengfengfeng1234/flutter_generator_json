import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:json_parse_annotion/json_parse_annotion.dart' as httpState;
import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

class HttpBuilderGenerator extends GeneratorForAnnotation<httpState.Request> {
  static const _baseUrlVar = "_baseUrl";

  const HttpBuilderGenerator();

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError('Generator cannot target `$name`.',
          todo: 'Remove the Request annotation from `$name`.',
          element: element);
    }

    return _implementClass(element, annotation);
  }

  String _implementClass(ClassElement element, ConstantReader annotation) {
    //获取类名称
    final className = element.name;

    /// 开始打造 类结构
    /// .. -> 级联 方便连续执行
    final classBuilder = Class((c) {
      c
        ..name = '_$className'
        ..types.addAll(element.typeParameters.map((e) => refer(e.name)))
        ..implements.add(TypeReference((b) => b.symbol = className))
        ..fields.addAll([_buildDioFiled()])
        ..docs.addAll(
          const [
            '/// 注释文档',
          ],
        )
        ..methods.addAll(_parseMethods(element));
    });

    final emitter = DartEmitter();
    String source = DartFormatter().format('${classBuilder.accept(emitter)}');
    print(source);
    return source;
  }

  Field _buildDioFiled() => Field((m) => m
    ..name = _baseUrlVar
    ..type = refer("String")
    ..modifier = FieldModifier.var$);

  Iterable<Method> _parseMethods(ClassElement element) {
    return element.methods.where((MethodElement m) {
      final methodAnnot = _getMethodAnnotation(m);
      return methodAnnot != null;
    }).map((MethodElement m) => _generateMethod(m));
  }

  /// 构造方法
  ///
  ///   _displayString(m.type.returnType)  => RequestSubscription<MessageInfoRsp>
  ///   m.displayName => getUserInfo
  ///
  ///
  Method _generateMethod(MethodElement m) {
    final httpMethod = _getMethodAnnotation(m);

    return Method((mm) {
      mm
        ..returns = refer(_displayString(m.type.returnType))
        ..name = m.displayName
        ..types.addAll(m.typeParameters.map((e) => refer(e.name)))
        ..annotations.add(CodeExpression(Code('override')));

      // m.parameters 可以获取形参
      mm.requiredParameters.addAll(m.parameters
          .where((it) => it.isRequiredPositional || it.isRequiredNamed)
          .map((it) => Parameter((p) => p
            ..name = it.name
            ..named = it.isNamed)));

      mm.body = _generateRequest(m, httpMethod!);
    });
  }

  /// 获取CODE
  /// 创建 变量  赋值 Code
  Code _generateRequest(MethodElement m, ConstantReader httpMethod) {
    final blocks = <Code>[];
    //获取到Code值
    int code = httpMethod.peek("code")!.intValue;

    blocks.add(
      refer("final int code = $code").statement,
    );

    // toJson
    ParameterElement parameterElement = m.parameters[0];

    //参数名称
    String parameterName = parameterElement.name;

    blocks.add(
      refer(" var info = $parameterName.toJson()").statement,
    );

    blocks.add(
      Code("return CommonRequest.request(code : code,args:info);"),
    );

    return Block.of(blocks);
  }

  String _displayString(dynamic e) {
    try {
      return e.getDisplayString(withNullability: false);
    } catch (error) {
      if (error is TypeError) {
        return e.getDisplayString();
      } else {
        rethrow;
      }
    }
  }

  final _methodsAnnotations = const [
    httpState.Code,
  ];

  ConstantReader? _getMethodAnnotation(MethodElement method) {
    for (final type in _methodsAnnotations) {
      final annot = _typeChecker(type)
          .firstAnnotationOf(method, throwOnUnresolved: false);
      if (annot != null) return ConstantReader(annot);
    }
    return null;
  }

  TypeChecker _typeChecker(Type type) => TypeChecker.fromRuntime(type);
}
