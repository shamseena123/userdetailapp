import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiServices {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((user) => UserModel.fromJson(user)).toList();
    }

    throw Exception("failed to Load users");
  }
}
