import 'package:flutter/material.dart';
import 'package:netflix_clone/pages/home_page.dart';

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset(
          'lib/assets/netflix-icon.png',
          width: 100,
        ),
        actions: const [

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: TextField(
              cursorColor: Colors.white,
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54)),
                filled: true,
                fillColor: Color.fromRGBO(64, 61, 61, 1),
                border: OutlineInputBorder(borderSide: BorderSide()),
                labelText: 'Password',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          // Sign In
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 48),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    borderRadius: BorderRadius.circular(4)),
                child: const Center(
                  child: Text("Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('OR',
                style: TextStyle(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(4)),
              child: const Center(
                child: Text("Use a Sign-In Code",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text:
                        "Sign in is protected by Google reCAPTCHA to ensure you're not a bot. ",
                    style: TextStyle(color: Colors.white54, fontSize: 15)),
                TextSpan(
                    text: "Learn more.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white54,
                        fontSize: 15))
              ]),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
