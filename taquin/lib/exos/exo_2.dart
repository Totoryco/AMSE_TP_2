import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;


class Exo2 extends StatefulWidget {
  @override
  _Exo2State createState() => _Exo2State();
}

int toInt(bool val) => val ? 1 : 0;

class _Exo2State extends State<Exo2> {
  double _currentSliderValue1 = 0;
  double _currentSliderValue2 = 0;
  double _currentSliderValue3 = 1;
  bool mirrored = false;

  @override
  Widget build(BuildContext context) {
    var title = 'Image';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        FittedBox(
          fit: BoxFit.fill,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(color: Colors.white),
            child: Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.rotationY(math.radians(180) * toInt(mirrored)),
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(
                          math.radians(1) * _currentSliderValue1),
                      child: Transform.scale(
                          scale: _currentSliderValue3,
                          child: Transform.rotate(
                              angle: math.radians(1) * _currentSliderValue2,
                              child: Image.network(
                                  'https://picsum.photos/512'))))),)
        ),
        Row(
          children: <Widget>[
            Text(
              "RotateX :",
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: Slider(
              value: _currentSliderValue1,
              min: 0,
              max: 360,
              divisions: 36,
              label: _currentSliderValue1.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue1 = value;
                });
              },
            ))
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              "RotateZ :",
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: Slider(
              value: _currentSliderValue2,
              min: 0,
              max: 360,
              divisions: 36,
              label: _currentSliderValue2.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue2 = value;
                });
              },
            ))
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              "Mirror :",
              textAlign: TextAlign.left,
            ),
            Checkbox(
                value: mirrored,
                onChanged: (bool value) {
                  setState(() {
                    mirrored = value;
                  });
                })
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              "Scale :",
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: Slider(
              value: _currentSliderValue3,
              min: 0,
              max: 2,
              divisions: 20,
              label: _currentSliderValue3.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue3 = value;
                });
              },
            ))
          ],
        )
      ]),
    );
  }
}