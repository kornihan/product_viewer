import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:product_view/exceptions/no_internet_exception.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({
    required this.baseUrl,
  });

  // GET method implementation with socket exception error handling
  Future<dynamic> get(String endpoint) async {
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final http.Response response = await http.get(url);
      return response;
    } on SocketException catch (_) {
      throw NoInternetException();
    }
  }
}
