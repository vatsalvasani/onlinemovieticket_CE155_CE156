import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinemovieticket/pages/login_screen.dart';
import '../utils/mytheme.dart';

//here we create one statefulwidget
class Forgotpass extends StatefulWidget {
  const Forgotpass({Key? key}) : super(key: key);

  @override
  _ForgotpassState createState() => _ForgotpassState();
}
//whenever user click on forgotpassword link in login page then it will redirect to this page
class _ForgotpassState extends State<Forgotpass> {
  bool visible = false;
  //create firebase authentication instance
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  //create texteditingcontroller emailcontroller.
  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: MyTheme.splash,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          height: _size.height,
          width: _size.width,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Get Asset From assets/icons
                SvgPicture.asset("assets/icons/splash_icon.svg"),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "Welcome Buddies,",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Change Your Password !!!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: const EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: _size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Change your Password",
                        style: TextStyle(
                          fontSize: 16,
                          color: MyTheme.splash,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          //initialize emailController With This Text Field
                          controller: emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              //validation for Email Can Not Be Empty
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                              //Vaildate Email Vith Valid Expresion
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            //Initialize Value In EmailController
                            emailController.text = value!;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            visible = true;
                          });
                          //call Method ForgotPassword
                          Forgotpassword(emailController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: MyTheme.splash,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Change Password",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Login??",
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                            //link For Login page
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //forgotpassword Method
  void Forgotpassword(String email) async {
    //check That Form Is Valid Or Not
    if (_formkey.currentState!.validate()) {
      await _auth
      //Send Email In Given Email Address
          .sendPasswordResetEmail(email: email)
          .then((uid) => {
                Navigator.of(context).pushReplacement(
                  //after Sending Email Control Goes To LoginScreen
                    MaterialPageRoute(builder: (context) => LoginScreen()))
              })
          .catchError((e) {
        print(e);
      });
    }
  }
}
