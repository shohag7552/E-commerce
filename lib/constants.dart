import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color eBackgroundColor = Color(0xFFC4C4C4);
const Color eButtonColor = Color(0xFFF9A825);
const Color eWhiteColor = Color(0xFFFFFFFF);
const Color eBlackColor = Color(0xFF000000);

const eTextFieldDecoration = InputDecoration(
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: eWhiteColor),
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(color: eWhiteColor),
  ),
  prefixIcon: Icon(
    Icons.person_outline,
    color: eWhiteColor,
    size: 18,
  ),
  hintText: 'Username',
  hintStyle:
      TextStyle(color: eWhiteColor, fontSize: 18, fontWeight: FontWeight.w300),
);
