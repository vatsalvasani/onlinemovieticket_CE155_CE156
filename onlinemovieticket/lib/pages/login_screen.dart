import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:onlinemovieticket/admin/admin_home.dart';
import 'package:onlinemovieticket/screens/home.dart';
import '../pages/signup_screen.dart';
import '../utils/mytheme.dart';
import 'forgot.dart';

//Here We Create One StatefulWidget For LoginScreen
//From SplashScreen Control Comes Here In LoginScreen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();

  //here We Create Two Controller For Two Field Of Login Page
  //For Email We Create emailController And For Password passwordController

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  //Create Firebase Authentication Instance
  final _auth = FirebaseAuth.instance;

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
                //Get Asset From icon/splash_icon.svg
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
                  "Login to book your seat, your seat !!!",
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
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 16,
                          color: MyTheme.splash,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          //define controller from email
                          controller: emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            //bydefault hint Email
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              //validation For Email Field Can Not Be Empty
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                              //validation For Correct Email Expression
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            //Save The Value of Email Field Into Controller
                            emailController.text = value!;
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          //define passwordcontroller for password field
                          controller: passwordController,
                          //ovscure Text Is True Means It Will Not Visible As Normal Text
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            //default hint text is password
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.black45),
                            fillColor: MyTheme.greyColor,
                            filled: true,
                          ),
                          validator: (value) {
                            //validation for password That It Should Not Be Less Then 6.
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              //validation for password should not be an empty field.
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            //assign value of password textfield into passwordcontroller
                            passwordController.text = value!;
                          },
                        ),
                      ),
                      ElevatedButton(
                        //create a button for Login
                        onPressed: () {
                          setState(() {
                            visible = true;
                          });
                          //Now It Will Call SignIn Method And Firbase Check For Authentication
                          signIn(emailController.text, passwordController.text);
                          //userLogin();
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
                              "LOGIN",
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
                        //link for forgotpassword
                        text: "Forgot Password??",
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          //whenever user click on this link control goes to Forgotpass
                            //Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Forgotpass()));
                          },
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Don’t have an account ? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      TextSpan(
                        //link for signup
                        text: "Sign up",
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            //whenever user click on this link control goes to SignUpScreen
                            //Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                            Get.to(const SignUpScreen());
                          },
                      ),
                      const TextSpan(
                        text: " here.",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
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

  //signIn Method
  void signIn(String email, String password) async {

    //Check That Form Is Valid Or Not if Form Is Valid Then Only Check For Authentication
    if (_formkey.currentState!.validate()) {
      try {
        //Now Firebase Check For Authentication If Username Or Password Is Not Valid Then It Will Give Error And Handle It In Catch
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        //if User Is Valid And It's Username Is vatsalextra0@gmail.com Then Control Goes To admin_home
        if (email == "vatsalextra0@gmail.com"  || email== "meetvirani310@gmail.com") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => admin_home(),
            ),
          );
        }
        else {
          //if User Is Valid And It's Username Is other then vatsalextra0@gmail.com Then Control Goes To HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //if There Is No User With provided Email Id
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("No User Registered With This Email!!")),
          );
        } else if (e.code == 'wrong-password') {
          //if User Is Registrated But Type Wrong Password
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Wrong Password Provided For This User!!")),
          );
        }
      }
    }
  }
}