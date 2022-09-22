port=8081

curl --insecure "http://localhost:${port}/v3/api-docs" > api-docs.json

flutter pub run build_runner build --delete-conflicting-outputs

cp -f -R -p ./lib/generated/api/lib/* ./lib/openapi
rm -f -R ./lib/generated