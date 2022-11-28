import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  // double bmi;
  ProfilePage({super.key, /*required this.bmi*/});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userEmail = FirebaseAuth.instance.currentUser!.email ?? "No user email";
  String userDisplayName = "Hello, ${FirebaseAuth.instance.currentUser!.displayName}";
  String userPhoto = FirebaseAuth.instance.currentUser!.photoURL ?? 'https://i.stack.imgur.com/34AD2.jpg';
  String userPhoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber ?? '2023308198';

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  
  // void calculateBMI() {
  //   double height = double.parse(_heightController.text) / 100;
  //   double weight = double.parse(_weightController.text);

  //   double heightSquare = height * height;
  //   double result = weight / heightSquare;
  //   setState(() {
  //     bmi = result;
  //   });
  //   print(bmi);
  // }

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
          Padding(
            padding: const EdgeInsets.only(left:0, bottom: 10, right: 0, top:0),
            child: Text(userPhoneNumber,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'height in cm',
              icon: Icon(Icons.trending_up),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'weight in kg',
              icon: Icon(Icons.line_weight),
            ),
          ),
          // const SizedBox(height: 15),
          // ElevatedButton(
          //   onPressed: calculateBMI,
          //   child: const Text(
          //     "Calculate",
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
