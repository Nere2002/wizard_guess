import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Fly extends StatefulWidget {
  const Fly({Key? key}) : super(key: key);

  @override
  _FlyState createState() => _FlyState();
}

class _FlyState extends State<Fly> {
  int _puntuacion = 0;
  Timer? _temporizador;
  late List<Bola> _bolas;
  static const Duration _duracionJuego = Duration(seconds: 30);
  static const Duration _tiempoDesaparicion = Duration(seconds: 3);
  bool _juegoIniciado = false;

  @override
  void initState() {
    super.initState();
  }

  void _iniciarJuego() {
    _puntuacion = 0;
    _bolas = [];
    _temporizador = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      _generarBola();
    });

    Timer(_duracionJuego, () {
      _temporizador?.cancel();
      _mostrarDialogoResultado();
    });
  }

  void _generarBola() {
    final Random random = Random();
    final double anchoPantalla = MediaQuery.of(context).size.width;
    final double altoPantalla = MediaQuery.of(context).size.height;
    final double x = random.nextDouble() * (anchoPantalla - 50);
    final double y = random.nextDouble() * (altoPantalla - 50);
    final int tipoBola = random.nextInt(3); // Tipo aleatorio de bola
    int puntuacion = 0;

    // Asignar puntuación según el tipo de bola
    switch (tipoBola) {
      case 0:
        puntuacion = 10;
        break;
      case 1:
        puntuacion = 15;
        break;
      case 2:
        puntuacion = 5;
        break;
    }

    final nuevaBola = Bola(
      posicion: Offset(x, y),
      puntuacion: puntuacion,
      tipo: tipoBola,
    );

    _bolas.add(nuevaBola);
    setState(() {});

    // Iniciar temporizador de desaparición
    Timer(_tiempoDesaparicion, () {
      if (_bolas.contains(nuevaBola)) {
        _bolas.remove(nuevaBola);
        setState(() {});
      }
    });
  }

  void _tocarBola(Bola bola) {
  setState(() {
    if (bola.tipo == 2) {
      _puntuacion -= 5; // Restar 5 puntos si es tipo 2
    } else {
      _puntuacion += bola.puntuacion;
    }
    _bolas.remove(bola);
  });
}


  void _mostrarDialogoResultado() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fin del Juego'),
          content: Text('Puntuación: $_puntuacion'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _iniciarJuego();
              },
              child: Text('Jugar de Nuevo'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _juegoIniciado = true;
            _iniciarJuego();
          });
        },
        child: Icon(Icons.play_arrow),
      ),
      body: Stack(
        children: [
          if (_juegoIniciado) ...[
            Row(
              children: [
                // Sección lateral para mostrar las imágenes de las bolas y sus puntuaciones
                Container(
                  width: 150, // Ancho fijo para la sección lateral
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Puntuación: $_puntuacion',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Bolas Disponibles:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const BolaInfo(tipo: 0, puntuacion: 10), // Información de la bola 1
                      const SizedBox(height: 8),
                      const BolaInfo(tipo: 1, puntuacion: 15), // Información de la bola 2
                      const SizedBox(height: 8),
                      const BolaInfo(tipo: 2, puntuacion: -5), // Información de la bola 3
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('../assets/fondo.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      for (final bola in _bolas)
                        Positioned(
                          left: bola.posicion.dx,
                          top: bola.posicion.dy,
                          child: GestureDetector(
                            onTap: () => _tocarBola(bola),
                            child: Image.asset(
                              _obtenerImagenBola(bola.tipo),
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _obtenerImagenBola(int tipo) {
    switch (tipo) {
      case 0:
        return '../assets/pelota.png';
      case 1:
        return '../assets/snich.png';
      case 2:
        return '../assets/pelota2.png';
      default:
        return '../assets/pelota.png'; // Por defecto pelota 1
    }
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }
}

class Bola {
  final Offset posicion;
  final int puntuacion;
  final int tipo; // 0, 1 o 2 para diferentes tipos de bolas

  Bola({required this.posicion, required this.puntuacion, required this.tipo});
}

class BolaInfo extends StatelessWidget {
  final int tipo;
  final int puntuacion;

  const BolaInfo({Key? key, required this.tipo, required this.puntuacion});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          _obtenerImagenBola(tipo),
          width: 32,
          height: 32,
        ),
        const SizedBox(width: 8),
        Text(
          'P${tipo + 1}: $puntuacion pts',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  String _obtenerImagenBola(int tipo) {
    switch (tipo) {
      case 0:
        return '../assets/pelota.png';
      case 1:
        return '../assets/snich.png';
      case 2:
        return '../assets/pelota2.png';
      default:
        return '../assets/pelota.png'; // Por defecto pelota 1
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: Fly(),
  ));
}
