import 'package:http/http.dart' as http;

Future<http.Response> Html() async {
  return http.get(Uri.parse('localhost:7272/djangorestframeworkapi'));
}
