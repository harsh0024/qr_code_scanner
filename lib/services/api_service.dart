// TODO Implement this library.
// lib/services/api_service.dart
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/item.dart'; // Adjust the import based on your project structure
//
// class ApiService {
//   static const String apiUrl = 'https://api.example.com/items'; // Replace with your API URL
//
//   static Future<List<Item>> fetchItems(String qrCode) async {
//     final response = await http.get(Uri.parse('$apiUrl?code=$qrCode'));
//
//     if (response.statusCode == 200) {
//       List<dynamic> body = json.decode(response.body);
//       List<Item> items = body.map((dynamic item) => Item.fromJson(item)).toList();
//       return items;
//     } else {
//       throw Exception('Failed to load items');
//     }
//   }
// }
