import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa flutter/services para utilizar SystemChrome
import 'package:wizard_guess/Screen/mainScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // Establecer la orientación de la pantalla como vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override   
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WIZARD GUESS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(), // Establece el widget de pantalla principal
    );
  }
}
