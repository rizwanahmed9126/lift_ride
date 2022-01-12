import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'file:///E:/AndroidStudioProjects/lift_login/lib/splash_and_slider/Start_slider.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Future<bool> _mocker() async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    return true;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mocker().then((status){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>Start_slider(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: Container(
          child: Center(
            child: Image.asset("assets/splash.png", width: 200,),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                //begin: Alignment,
                  end: Alignment.bottomCenter,
                  colors: [

                    Color(0xFFFF5252),
                    Color(0xFFFF8D7E),





                  ]
              )
          ),
        )
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.redAccent,
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 30,
        )
    );
  }
}

