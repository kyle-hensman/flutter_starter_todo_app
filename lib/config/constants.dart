import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// environmental settings
const bool isProd = kReleaseMode;
const bool isDev = kDebugMode;
const bool isDebug = kDebugMode;

// application name
const String appName = 'Todo App';

// prefered device orientation [up and down]
const List<DeviceOrientation> preferredOrientations = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown
];
