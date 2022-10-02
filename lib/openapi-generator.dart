import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  inputSpecFile: 'api-docs.json',
  generatorName: Generator.dart,
  outputDirectory: 'lib/generated/api',
  alwaysRun: true,
  overwriteExistingFiles: true,
  additionalProperties: AdditionalProperties(
    pubVersion: '34',
    pubAuthor: 'JP OLIVE',
    pubName: 'resource',
    prependFormOrBodyParameters: true,
    sortModelPropertiesByRequiredFlag: true,
  ),
)
class OpenApiGenerator extends OpenapiGeneratorConfig {}
