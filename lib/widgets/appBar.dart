import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: Text("Global News"),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      
    );
  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}