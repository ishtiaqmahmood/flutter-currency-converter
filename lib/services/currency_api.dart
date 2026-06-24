import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyApi {
  static Future<double> getRate(String from, String to) async {
    final url = "https://api.exchangerate-api.com/v4/latest/$from";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data["rates"][to].toDouble();
    } else {
      throw Exception("Failed to load currency");
    }
  }
}
