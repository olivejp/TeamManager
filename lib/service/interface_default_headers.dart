abstract class InterfaceDefaultHeaders {
  Map<String, String> getHeaders();

  Map<String, String> getHeadersWoAuthorizationHeader();

  void setAuthorizationHeader(String? bearer);
}
