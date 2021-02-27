import 'package:flutter/material.dart';


class SelectionScreen extends StatefulWidget {
  SelectionScreen({Key key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {

  @override
  Widget build(BuildContext context) {
    final List<String> routes = ['Exercice 1','Exercice 2','Exercice 3','Exercice 4','Exercice 5a','Exercice 5b','Exercice 5c','Exercice 6a', 'Exercice 6b','/home'];
    final List<int> colorCodes = <int>[800, 700, 600, 500, 400, 300, 200, 100, 200, 300, 400];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, 
        title: Center(child: Text("AMSE TP2")),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: routes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height/(routes.length+5),
            color: Colors.amber[colorCodes[index]],
            child: MaterialButton(
              onPressed: () { (index != 2) ? Navigator.pushNamed(context, routes[index]): print("already on Exo 3"); },
              child: Center(child: (index == 9) ? Text('Jeu de Taquin'): Text('${routes[index]}')),
            )
          );
        }, separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    );
  }
}