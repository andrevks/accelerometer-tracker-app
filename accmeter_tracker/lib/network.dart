import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'Post.dart';
import 'album.dart';

Future<Post> fetchPost(String num) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/posts/${num}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load load album');
  }
}

Future<Album> createAlbum(String title) async {
  final response =
      await http.post(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{'title': title}));

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
