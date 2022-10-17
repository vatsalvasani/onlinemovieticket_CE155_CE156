import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlinemovieticket/pages/login_screen.dart';
import '../utils/mytheme.dart';

//Here We Create StatefulWidget SplashScreen
//in main.dart file We Write That In Home Control Goes To SplashScreen Means Control Come Here Now.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      //Here We Declare Duration As 5000 milisecond So It Will Be There For 5 Second
        vsync: this, duration: const Duration(milliseconds: 5000));
    _animation = CurvedAnimation(
      //Here We Declare All The Property For Animation
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn);
    _animationController.forward();
    Timer(
      //Here After 5 Second Control Goes To It Will Execute () => Navigator.pushReplacement(
      //             context, MaterialPageRoute(builder: (_) => LoginScreen())));
      //So Now After 5 Second Control Goes To LoginScreen.
        const Duration(milliseconds: 5000),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen())));

    //Call initState() method Of Parent Class
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    //returning Scaffold Widget
    return Scaffold(
      //Specify All Properties.
      backgroundColor: MyTheme.splash,
      body: Container(
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: SvgPicture.asset(
              //get asset From assets icon folder
              "assets/icons/splash_icon.svg",
              height: 70,
            ),
          ),
        ),
      ),
    );
  }
}
