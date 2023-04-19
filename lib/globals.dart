library my_project.globals;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const int user_id = 1;

bool isLight = true;
Color card_color = Color.fromRGBO(220, 208, 208, 1);

Border border_color = Border.all(
  color: isLight ? Colors.white30 : Colors.black,
  width: 1.0,
);

var which_function = 1;
