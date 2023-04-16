import 'package:flutter/material.dart';

AppBar appBar({required String title, required VoidCallback onPressed}) {
  return AppBar(
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back),
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.only(
          right: 10,
        ),
        child: Icon(Icons.sort_sharp),
      ),
    ],
    backgroundColor: Colors.teal,
    toolbarHeight: 100,
    title: Text(title),
    centerTitle: true,
  );
}
