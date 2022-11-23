import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget with PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppBarWidgetState createState() => _AppBarWidgetState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("EaTØ",
       style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange
       ),
      ),
      backgroundColor: Colors.white,
    );
  }
}