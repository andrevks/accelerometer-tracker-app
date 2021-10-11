import 'package:http/http.dart' as http;
import 'dart:convert';

import 'accelerometer_model.dart';

Future<AccelerometerModel> createCoord(
    String title, String x, String y, String z) async {
  const String apiURL = 'http://localhost:8085/accmeter';

  final response = await http.post(apiURL,
      body: json.encode({"x": x, "y": y, "z": z, "title": title}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return accelerometerModelFromJson(responseString);
  } else {
    throw Exception('Failed to load Accelerometer values');
  }
}


// postData() async {
//   try {
//     // String URL = 'https://jsonplaceholder.typicode.com/posts';
//     String URL = 'http://192.168.1.4:5050/accmeters';
//     var response = await http.post(Uri.parse(URL), body: {
//       // "id": 1.toString(),
//       // "name": "Saheb",
//       // "email": "someemail@gmail.com"
//       "x": "131.2344",
//       "y": "0.021234232",
//       "z": "9.8123432",
//       "title": "accelerometer values"
//     });
//     print(response.body);
//   } catch (e) {
//     print(e);
//   }
// }
