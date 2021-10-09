import 'package:flutter/material.dart';
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
  int count = 0;
  // AccelerometerModel? _acc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: GestureDetector(
        child: Text(
          'Post Accelerometer Values',
          style: TextStyle(fontSize: 30),
        ),
        onTap: () async {
          const String title = 'Acc Values';
          const String x = "65.44";
          const String y = "0.021234232";
          const String z = "9.8123432";

          final AccelerometerModel acc = await createCoord(title, x, y, z);
          // print(acc.x);
          // print(acc.y);
          // print(acc.z);

          // setState(() {
          //   _acc = acc;
          // });
          print(acc.x);
          print(acc.y);
          print(acc.z);
        }
        // () {
        //   setState(() {
        //     count++;
        //     // postData();
        //   });
        // }
        ,
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
