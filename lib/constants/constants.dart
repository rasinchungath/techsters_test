import 'package:flutter/material.dart';

const dateFieldDecoration = InputDecoration(
  prefixIcon: Icon(Icons.calendar_month),
  contentPadding: EdgeInsets.only(top: 13),
  hintText: 'Enter Date',
  hintStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  ),
  border: InputBorder.none,
);

const textFieldStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

const reasonFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(left: 15),
  hintText: 'Reason',
  hintStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  ),
  border: InputBorder.none,
);

const textStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
