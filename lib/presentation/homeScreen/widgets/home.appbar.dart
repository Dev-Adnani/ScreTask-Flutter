import 'package:flutter/material.dart';

AppBar homeAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      children: [
        Container(
          height: 45,
          width: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
                'https://avatars.githubusercontent.com/u/61565182?v=4'),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Hi, Dev!',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    actions: [
      Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 40,
      )
    ],
  );
}
