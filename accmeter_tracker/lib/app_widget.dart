import 'package:flutter/material.dart';
import 'home_page.dart';

// Stateless = Widget imutavel,n tem animação, n tem nada que o altera
//A n ser que o pai o reconstrua.
class AppWidget extends StatelessWidget {
  //Vai Criar no construtor (AppWidget) cada atributo que tiver
  //a keyword final
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black),
      home: HomePage(),
    );
  }
}
