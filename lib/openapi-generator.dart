import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  inputSpecFile: 'api-docs.json',
  generatorName: Generator.dart,
  outputDirectory: 'lib/generated/api',
  additionalProperties: AdditionalProperties(pubVersion: '16', pubAuthor: 'JP OLIVE', pubName: 'resource'),
)
class OpenApiGenerator extends OpenapiGeneratorConfig {}
