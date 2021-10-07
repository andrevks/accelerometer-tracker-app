import 'package:http/http.dart' as http;
import 'dart:convert';

postData() async {
  try {
    // String URL = 'https://jsonplaceholder.typicode.com/posts';
    String URL = 'http://192.168.1.4:5050/accmeters';
    var response = await http.post(Uri.parse(URL), headers: <String, String>{
      "Access-Control-Allow-Origin": "*",
    }, body: {
      // "id": 1.toString(),
      // "name": "Saheb",
      // "email": "someemail@gmail.com"
      "x": 666.6.toString(),
      "y": 0.07777.toString(),
      "z": 9.888888.toString(),
      "title": "accelerometer values"
    });
    print(response.body);
  } catch (e) {
    print(e);
  }
}
