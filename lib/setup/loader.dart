import 'package:flutter/material.dart';
import 'dart:math';
class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animationrotation;
  Animation<double> animationradiusin;
  Animation<double> animationradiusout;
  
  final double intitialRadius=30.0;
  double radius=0.0;
@override
void initState(){
  super.initState();

  controller = AnimationController(vsync:this, duration: Duration(seconds:3));
  animationrotation = Tween<double>(
    begin:0.0,
    end:1.0,
    ).animate(CurvedAnimation(parent:controller, curve:Interval(0.0, 1.0, curve: Curves.linear)));
  
  animationradiusin = Tween<double>(
    begin:1.0,
    end:0.0,
    ).animate(CurvedAnimation(parent:controller,curve:Interval(
      0.75, 1.0,curve: Curves.elasticIn)));
  animationradiusout = Tween<double>(
    begin:0.0,
    end:1.0,
    ).animate(CurvedAnimation(parent:controller,curve:Interval(
      0.0, 0.25,curve: Curves.elasticInOut)));

  controller.addListener((){
    setState(() {
       if(controller.value>=0.75 && controller.value<=1.0){
          radius = animationradiusin.value*intitialRadius;
        }else if(controller.value>=0.0 && controller.value<=0.25){
           radius = animationradiusout.value*intitialRadius;
        }
    });
  });
controller.repeat();

}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child:RotationTransition(
          turns: animationrotation,
            child: Stack(
            children: <Widget>[
              Dot(
                radius: 30.0,
                color: Colors.black12,
              ),
              Transform.translate(
                offset: Offset(radius*cos(pi/4), radius*sin(pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.redAccent,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(2*pi/4), radius*sin(2*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.greenAccent,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(3*pi/4), radius*sin(3*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.blue,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(4*pi/4), radius*sin(4*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.purple,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(5*pi/4), radius*sin(5*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.amberAccent,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(6*pi/4), radius*sin(6*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.cyan,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(7*pi/4), radius*sin(7*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.orangeAccent,
              ),
              ),
                Transform.translate(
                offset: Offset(radius*cos(8*pi/4), radius*sin(8*pi/4)),
                child:Dot(
                radius: 6.0,
                color: Colors.lightGreenAccent,
              ),
              ),
   
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  
  final double radius;
  final Color color;

  Dot({this.color,this.radius});
  
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}