import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:netflix_clone/provider/movie_provider.dart';
import 'package:netflix_clone/widgets/my_text_box.dart';
import 'package:netflix_clone/widgets/profile_slide.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> editField(String field) async {
    String newValue = "";

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            title: Text(
              "Edit $field",
              style: GoogleFonts.openSans(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            content: TextField(
              autocorrect: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  // border: const OutlineInputBorder(borderSide: BorderSide()),
                  hintText: "Enter new $field",
                  hintStyle: GoogleFonts.openSans(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 16))),
              onChanged: (value) {
                newValue = value;
              },
            ),
            actions: [
              // Save and Cancel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ))),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(newValue),
                        child: Text("Save",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ))),
                  ],
                ),
              )
            ],
          );
        });

    // Firestore
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            context.go('/homePage');
          },
        ),
        centerTitle: true,
        title: Text(
          "Profile Page",
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(fontSize: 25, color: Colors.white)),
        ),
      ),

      // Body
      body: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  // Profile Icon

                  const SizedBox(
                    height: 50,
                  ),

                  // User Icon
                  Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(
                        LucideIcons.user,
                        color: Colors.white,
                        size: 100,
                      )),

                  const SizedBox(
                    height: 15,
                  ),

                  // User Email
                  Text("${FirebaseAuth.instance.currentUser!.email}",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 20, color: Colors.white))),

                  const SizedBox(
                    height: 50,
                  ),

                  // Tiles
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final userData =
                              snapshot.data!.data() as Map<String, dynamic>;

                          return ExpansionTile(
                            leading: const Icon(
                              LucideIcons.user2,
                              size: 30,
                              color: Colors.white,
                            ),
                            title: Text("User Details",
                                style: GoogleFonts.openSans(
                                    textStyle: const TextStyle(
                                        fontSize: 16, color: Colors.white))),
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            children: [
                              // Name
                              MyTextBox(
                                  topText: 'Name',
                                  onPressed: () => editField('name'),
                                  mainText: userData['name']),

                              // Surname
                              MyTextBox(
                                  topText: 'Surname',
                                  onPressed: () => editField('surname'),
                                  mainText: userData['surname']),

                              // Bio
                              MyTextBox(
                                  topText: 'Bio',
                                  onPressed: () => editField('bio'),
                                  mainText: userData['bio']),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        }
                        return const CircularProgressIndicator();
                      }),

                  ExpansionTile(
                    leading: const Icon(
                      LucideIcons.list,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text("My List",
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    children: [
                      movieProvider.myList.isEmpty
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text("Your List is Empty D:",
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white))),
                              ),
                            )
                          : ProfileSlide(
                              list: movieProvider.myList,
                            )
                    ],
                  ),

                  ExpansionTile(
                    leading: const Icon(
                      LucideIcons.tv,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text("Continue Watching",
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    children: [
                      movieProvider.watchedList.isEmpty
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text("You Haven't Watched a Trailer D:",
                                    style: GoogleFonts.openSans(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white))),
                              ),
                            )
                          : ProfileSlide(
                              list: movieProvider.watchedList,
                            )
                    ],
                  ),

                  // Sign Out
                  ListTile(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        movieProvider.myList.clear();
                        movieProvider.watchedList.clear();
                        FirebaseAuth.instance.currentUser
                            ?.reload(); // Ensure the user state is refreshed
                        log('Signed out successfully.');
                        context.go('/authScreen'); // Navigate to login screen
                      } catch (e) {
                        log('Sign out failed: $e');
                      }
                    },
                    leading: const Icon(
                      LucideIcons.logOut,
                      size: 30,
                      color: Colors.white,
                    ),
                    title: Text("Sign Out",
                        style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
