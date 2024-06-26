import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false, 
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        'lib/assets/netflix-icon.png',
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white54
                    )
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(64, 61, 61, 1),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  labelText: 'Email or phone number',
                  //solve hinttext problem
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextFormField(
                cursorColor: Colors.white,
                obscureText: true,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white54
                    )
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(64, 61, 61, 1),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: (){
              }, 
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.red[500],
                fixedSize: const Size.fromWidth(320),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
              ),
              
              child: const Text(
              'Sign In', 
              style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  ),
                )
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'OR',
                  style: 
                  TextStyle(
                    color: Colors.white54,
                    fontSize: 20
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: OutlinedButton(
                onPressed: (){
                }, 
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white54,
                  fixedSize: const Size.fromWidth(320),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  ),
                ),
                
                child: const Text(
                'Use a Sign-In Code', 
                style: 
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    ),
                  )
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 48.0),
                child: Text(
                  'Sign in is protected by Google reCAPTCHA to ensure you are not a robot.',
                  style: TextStyle(color: Colors.white54),
                  textAlign: TextAlign.center,
                  ),
              )
              
          ],
          
        ),
        
        );
  }
}
