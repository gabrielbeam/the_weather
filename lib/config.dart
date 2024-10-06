import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get openApiKey => dotenv.get("OPEN_API_KEY");
  static String get meteomaticsUser => dotenv.get("METEOMATICS_USER");
  static String get meteomaticsPassword => dotenv.get("METEOMATICS_PASSWORD");
}