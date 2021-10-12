import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
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
    Map<String, String> orientationPt = {
      'NativeDeviceOrientation.portraitUp': 'Vertical Cima',
      'NativeDeviceOrientation.portraitDown': 'Vertical Baixo',
      'NativeDeviceOrientation.landscapeRight': 'Horizontal Direita',
      'NativeDeviceOrientation.landscapeLeft': 'Horizontal Esquerda',
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
          String oriStr = orientation.toString();

          oriStr = orientationPt[oriStr].toString();

          createCoord(oriStr, '0.0', '0.0', '0.0')
              .then(
                  (value) => print('Orientação Enviada (API): ${value.title}'))
              .catchError((err) => print('Caught error: $err'));

          print('Nova orientação: $oriStr ');

          return Center(
              child: Text(
            '$oriStr\n',
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
