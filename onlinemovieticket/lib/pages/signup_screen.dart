import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:onlinemovieticket/pages/login_screen.dart';
import 'package:onlinemovieticket/utils/mytheme.dart';
import 'dart:io';

//create StatefulWidget For SignUpScreen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  _SignUpScreenState();

  bool showProgress = false;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  //create Controller For All TextFields.
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;

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
          height: _size.height,
          width: _size.width,
          child: Form(
            //Validating The Form
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/splash_icon.svg"),
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
                        "Create your account",
                        style: TextStyle(
                          fontSize: 16,
                          color: MyTheme.splash,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          //initialize controller With Name Controller
                          controller: name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Name",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          //initialize controller With Email Controller
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Email Address",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              //Validation For Email Can Not Be Empty
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                              //Validation For Email Expression
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          //initialize mobile Controller With This Text Field
                          controller: mobile,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Phone No.",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          //initialize password Controller With This Text Field
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              //validate password with minimum 6 character
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          controller: confirmpassController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Confirm Password",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              //validate password with confirmpassword Both Should Be Same
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showProgress = true;
                          });
                          //Call SignUp Metod
                          signUp(
                            emailController.text,
                            passwordController.text,
                          );
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
                              "SIGNUP",
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
                      const TextSpan(
                        text: "Already have an account ? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      TextSpan(
                        text: "Login",
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back();
                          },
                      ),
                      const TextSpan(
                        text: " here.",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //signup method
  signUp(String email, String password) async {
    //Check That Form Is Valid Or Not
    if (_formkey.currentState!.validate()) {
      try {
        //create User With Given Email And Password Argument
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .whenComplete(() => {
              //Control Goes To Login Screen.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  )
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //Check For Password Validation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Password Is Too Week!!")),
          );
        } else if (e.code == 'email-already-in-use') {
          //Check For Password Validation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Email Is Already Exist!")),
          );
        }
      } catch (e) {
        print(e);
      }
    }
    //circular progress Indicator
    CircularProgressIndicator();
  }
}
