import 'dart:math';

import 'package:flutter/cupertino.dart';

class DesignPattern extends CustomPainter{
  Random random = Random();
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint1 = Paint()
      ..color = Color.fromRGBO(236,64,122, 0.05); //Colors.Purple[400];
    Paint paint2 = Paint()
      ..color = Color.fromRGBO(240,98,146, 0.05); //Colors.Purple[300];
    Paint paint3 = Paint()
      ..color = Color.fromRGBO(244,143,177, 0.05); //Colors.Purple[200];
    Paint paint4 = Paint()
      ..color = Color.fromRGBO(248,187,208, 0.05); //Colors.Purple[100];

    var list =[paint1,paint2,paint3,paint4];
    randomListItem(List lst) => lst[random.nextInt(lst.length)];


    for(double i=0;i<size.height;i=i+150){
      for(double j=0;j<=size.width;j+=90){
        canvas.drawCircle(Offset(j, i), 30, randomListItem(list));
        canvas.drawCircle(Offset(j, i), 20, randomListItem(list));
      }
    }

    for(double i=90;i<size.height;i=i+150){
      for(double j=45;j<=size.width;j+=90){
        canvas.drawCircle(Offset(j, i), 30, randomListItem(list));
        canvas.drawCircle(Offset(j, i), 20, randomListItem(list));
      }
    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>false;

}