import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  // Fungsi untuk mengirim permintaan HTTP GET ke URL yang diberikan
  static Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Mengonversi data JSON menjadi Map
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  static Future<List<dynamic>> getList(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Mengonversi data JSON menjadi Map
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  static Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(url),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to send PUT request');
    }
  }

  // Fungsi untuk mengirim permintaan HTTP POST ke URL yang diberikan
  static Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Mengonversi data JSON menjadi Map
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to post data to API');
    }
  }

  // Fungsi untuk mengirim permintaan HTTP DELETE ke URL yang diberikan
  static Future<Map<String, dynamic>> delete(String url) async {
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      // Mengonversi data JSON menjadi Map
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Failed to delete data from API');
    }
  }
}
