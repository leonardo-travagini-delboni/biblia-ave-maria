import 'package:flutter/material.dart';

// Parameters
String appName = 'Bíblia Sagrada';
String appVersion = 'v1.0.0';
int releaseVersion = 1;
String releaseDate = '2026.02.12';
bool showDebugBanner = false;
bool enableDebugPrint = true;
bool enableIA = false;
String aiWhatsapp = "https://api.whatsapp.com/send/?phone=18888186248";
bool enableCreditos = true;

// Functions
void dp(String statement) {
  if (enableDebugPrint) {
    debugPrint('DEBUG - $statement');
  }
}
