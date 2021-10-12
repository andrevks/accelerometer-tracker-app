import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'network.dart';
import 'accelerometer_model.dart';

import 'package:sensors_plus/sensors_plus.dart';

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
  double x = 0.1, y = 0.1, z = 0.0;
  String title = 'Acc Values';

  @override
  void initState() {
    //O sensor começa a enviar dados assim que o app começar
    super.initState();
    gyroscopeEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      }); // [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]
    }); //Get the sensor data and set then to the data types
  }

  @override
  Widget build(BuildContext context) {
    String x_str = x.toStringAsFixed(2);
    String y_str = y.toStringAsFixed(2);
    String z_str = z.toStringAsFixed(2);

    print(z);
    print(z_str);
    if (z < 180) {
      title = 'Direita';
    } else {
      title = 'Esquerda';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: GestureDetector(
        child: Text(
          'Z: $z_str -> $title',
          style: TextStyle(fontSize: 30),
        ),
        onTap: () async {
          // const String title = 'Acc Values';
          // String x_str = x.toStringAsFixed(2);
          // String y_str = y.toStringAsFixed(2);
          // String z_str = z.toStringAsFixed(2);
          print(z);
          print(z_str);

          final AccelerometerModel acc =
              await createCoord(title, x_str, y_str, z_str);
          print(acc.z);
        },
      )),
    );

    // return Container(
    //   child:
    //   Center(
    //       child: GestureDetector(
    //     child: Text('Contador: $count'),
    //     onTap: () {
    //       setState(() {
    //         count++;
    //       });
    //     },
    //   )),
    // );
  }
}
