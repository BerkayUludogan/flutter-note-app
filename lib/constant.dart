// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constant {
  static String title = 'Not Defteri';
  static String detailTitle = 'Not Detay';
  static final TextStyle headerStyle = GoogleFonts.quicksand(
      fontSize: 30, fontWeight: FontWeight.w900, color: Colors.indigo);

  static final TextStyle buttonStyle =
      GoogleFonts.quicksand(fontSize: 30, fontWeight: FontWeight.w900);
  static TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  static Color color1 = Colors.blue;
  static Color color2 = Colors.cyan;
  static Color color3 = Colors.green;
  static Color color4 = Colors.yellow;
  static Color color5 = Colors.red;

  static SizedBox defaultHeight = const SizedBox(
    height: 30,
  );
}
