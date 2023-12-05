import 'package:flutter/material.dart';
import 'package:movieflix/screens/home_screen.dart';
import 'package:movieflix/services/api_service.dart';

void main() {
  ApiService.getMovieDetails(753342);
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
