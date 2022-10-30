import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        alignment: Alignment.center,
        color: Colors.pink,
        // we can set width here with conditions
        width: 200,
        height: kToolbarHeight,
        child: Text("MY AppBar"),
      ),
    );
  }

  ///width doesnt matter
  @override
  Size get preferredSize => Size(200, kToolbarHeight);
}
