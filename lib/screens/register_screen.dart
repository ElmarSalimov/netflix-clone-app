import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback? showLoginScreen;
  const RegisterScreen({super.key, this.showLoginScreen});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

Future<void> signUp() async {
  final movieProvider = Provider.of<MovieProvider>(context, listen: false);
  
  if (_passwordController.text == _confirmController.text) {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    String uid = userCredential.user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': _emailController.text,
      'name': "",
      'surname': "",
      'bio': "empty bio..."
    });

    log('User signed up and document created successfully');
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text("Passwords do not match"),
        );
      },
    );
  }

  movieProvider.fetchUserData();
}


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
        title: Image.asset(
          'lib/assets/netflix-icon.png',
          width: 100,
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 140,
            ),
        
            // Email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _emailController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  filled: true,
                  fillColor: Color.fromRGBO(64, 61, 61, 1),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ),
        
            // Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordController,
                cursorColor: Colors.white,
                obscureText: true,
                decoration: const InputDecoration(
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
        
            // Confirm Password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _confirmController,
                cursorColor: Colors.white,
                obscureText: true,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  filled: true,
                  fillColor: Color.fromRGBO(64, 61, 61, 1),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  labelText: 'Confirm Password',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ),
        
            // Sign Up
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: signUp,
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 48),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 17, 0),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text("Sign Up",
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
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
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
        
            // Toggle Pages
            GestureDetector(
              onTap: widget.showLoginScreen,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Already a member? Login now',
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
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
      ),
    );
  }
}
