import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sampleproject/app_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userEmail = FirebaseAuth.instance.currentUser!.email ?? "No user email";
  String userDisplayName = "Hello, ${FirebaseAuth.instance.currentUser!.displayName}";
  String userPhoto = FirebaseAuth.instance.currentUser!.photoURL ?? 'https://i.stack.imgur.com/34AD2.jpg';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:0, bottom: 5, right: 0, top:0),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(userPhoto),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:0, bottom: 10, right: 0, top:0),
            child: Text(userDisplayName,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:0, bottom: 10, right: 0, top:0),
            child: Text(userEmail,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
