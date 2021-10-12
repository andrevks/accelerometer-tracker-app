import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
// import 'package:sensors_plus/sensors_plus.dart';
import 'network.dart';
import 'accelerometer_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    //O Stateful pede um estado (State).
    //Entao, a gente precisa criar uma outra classe
    //para que possa ser retornada aqui e
    //Funcionar como um estado que vai ser sempre
    //modificado.

    return HomePageState(); //Soh funciona para essa classe
  }
}

//No State (estado) precisa passar o nome da classe
//de StateFulWidget que eh a classe que vai nos
//referenciar
class HomePageState extends State<HomePage> {
  bool useSensor = false;

  @override
  Widget build(BuildContext context) {
    String orientationStr = 'Preparando...';

    Map<String, String> orientationPt = {
      'NativeDeviceOrientation.portraitUp': 'Vertical para Cima',
      'NativeDeviceOrientation.portraitDown': 'Vertical para Baixo',
      'NativeDeviceOrientation.landscapeRight': 'Horizontal para Direita',
      'NativeDeviceOrientation.landscapeLeft': 'Horizontal para Esquerda',
      'NativeDeviceOrientation.Unknown': 'Desconhecido'
    };

    return Scaffold(
      appBar: AppBar(title: Text('Smartphone Orientation'), actions: <Widget>[
        Center(child: Text('Sensor: ')),
        Switch(
          value: useSensor,
          onChanged: (val) => {setState(() => useSensor = val)},
          activeColor: Colors.green,
          activeTrackColor: Colors.deepOrange,
          inactiveTrackColor: Colors.red[100],
          inactiveThumbColor: Colors.red,
        )
      ]),
      body: NativeDeviceOrientationReader(
        builder: (content) {
          //Permite controlar quando o dispositivo começa a ouvir
          //por mudanças na orientação
          final orientation =
              NativeDeviceOrientationReader.orientation(content);

          //Tradução, abstração da biblioteca
          String orientationStr = orientation.toString();

          orientationStr = orientationPt[orientationStr].toString();

          createCoord(orientationStr, '0.0', '0.0', '0.0')
              .then(
                  (value) => print('Orientação Enviada (API): ${value.title}'))
              .catchError((err) => print('Caught error: $err'));

          print('Nova orientação: $orientationStr ');

          return Center(
              child: Text(
            '$orientationStr\n',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ));
        },
        useSensor: useSensor,
      ),
    );
  }
}
