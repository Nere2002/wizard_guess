import 'package:flutter/material.dart';

class Casa {
  final String nombre;
  final String imagen;
  final String respuesta1;
  final String respuesta2;
  final String respuesta3;
  final String respuesta4;
  final String respuesta5;
  final String respuesta6;
  final String respuesta7; // Nueva respuesta

  Casa({
    required this.nombre,
    required this.imagen,
    required this.respuesta1,
    required this.respuesta2,
    required this.respuesta3,
    required this.respuesta4,
    required this.respuesta5,
    required this.respuesta6, // Nueva respuesta
    required this.respuesta7, // Nueva respuesta
  });
}

class Pregunta {
  final String pregunta;
  final String respuesta;

  Pregunta({
    required this.pregunta,
    required this.respuesta,
  });
}

class SecondGamePage extends StatefulWidget {
  const SecondGamePage({Key? key});

  @override
  _SecondGamePageState createState() => _SecondGamePageState();
}

class _SecondGamePageState extends State<SecondGamePage> {
  
  final Map<int, String?> _respuestasSeleccionadas = {};

  final List<Casa> casas = [
    Casa(
      nombre: 'RAVENCLAW',
      imagen: '../assets/azulr.jpg',
      respuesta1: 'fruta',
      respuesta2: 'alcón',
      respuesta3: 'azul',
      respuesta4: 'responsable',
      respuesta5: 'invierno',
      respuesta6: 'lectura', // Nueva respuesta
      respuesta7: 'templado', // Nueva respuesta
    ),
    Casa(
      nombre: 'SLYTHERIN',
      imagen: '../assets/verdes.jpg',
      respuesta1: 'pescado',
      respuesta2: 'escorpión',
      respuesta3: 'verde',
      respuesta4: 'atrevido',
      respuesta5: 'otoño',
      respuesta6: 'juegos', // Nueva respuesta
      respuesta7: 'frío', // Nueva respuesta
    ),
    Casa(
      nombre: 'HUFFLEPUFF',
      imagen: '../assets/amarilloh.jpg',
      respuesta1: 'verdura',
      respuesta2: 'perro',
      respuesta3: 'amarillo',
      respuesta4: 'amable',
      respuesta5: 'primavera',
      respuesta6: 'música', // Nueva respuesta
      respuesta7: 'cálido', // Nueva respuesta
    ),
    Casa(
      nombre: 'GRYFFINDOR',
      imagen: '../assets/rojog.jpg',
      respuesta1: 'carne',
      respuesta2: 'lobo',
      respuesta3: 'rojo',
      respuesta4: 'valiente',
      respuesta5: 'verano',
      respuesta6: 'deportes', // Nueva respuesta
      respuesta7: 'caluroso', // Nueva respuesta
    ),
  ];

  final List<Pregunta> preguntas = [
    Pregunta(
      pregunta: '¿Qué tipo de comida prefieres?',
      respuesta: 'respuesta1',
    ),
    Pregunta(
      pregunta: '¿Qué animal te gusta más?',
      respuesta: 'respuesta2',
    ),
    Pregunta(
      pregunta: '¿Cuál es tu color favorito?',
      respuesta: 'respuesta3',
    ),
    Pregunta(
      pregunta: '¿Cómo te describirías?',
      respuesta: 'respuesta4',
    ),
    Pregunta(
      pregunta: '¿Cuál es tu estación del año favorita?',
      respuesta: 'respuesta5',
    ),
    // Nuevas preguntas
    Pregunta(
      pregunta: '¿Cuál es tu pasatiempo favorito?',
      respuesta: 'respuesta6',
    ),
    Pregunta(
      pregunta: '¿Qué tipo de clima prefieres?',
      respuesta: 'respuesta7',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sombrero Selectionador'),
      ),
      body: Stack(
        children: [
          // Fondo de pantalla
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../assets/fondopreguntas.jpg'), // Ruta de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'A qué casa perteneces?:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Color del texto
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var casa in casas)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Bordes redondeados
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12), // Bordes redondeados para la imagen
                                  child: Image.asset(
                                    casa.imagen,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  casa.nombre,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: preguntas.length,
                  itemBuilder: (context, index) {
                    final pregunta = preguntas[index];
                    final numeroRespuestas = casas.length;

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Bordes redondeados
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pregunta.pregunta,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...List.generate(
                              numeroRespuestas,
                              (i) => RadioListTile<String>(
                                title: Text(
                                  _getRespuesta(i, pregunta.respuesta)!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                value: _getRespuesta(i, pregunta.respuesta)!,
                                groupValue: _respuestasSeleccionadas[index],
                                onChanged: (value) {
                                  setState(() {
                                    _respuestasSeleccionadas[index] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
              ],
              
            ),
            
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para reiniciar las respuestas
                      setState(() {
                        _respuestasSeleccionadas.clear();
                      });
                    },
                    child: Text('Reiniciar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para comprobar las respuestas
                      _comprobarRespuestas();
                    },
                    child: Text('Comprobar'),
                  ),
                ],
              ),
            ),
          ),
          
        ],
        
      ),
    );
  }

  String? _getRespuesta(int index, String respuesta) {
    switch (respuesta) {
      case 'respuesta1':
        return casas[index].respuesta1;
      case 'respuesta2':
        return casas[index].respuesta2;
      case 'respuesta3':
        return casas[index].respuesta3;
      case 'respuesta4':
        return casas[index].respuesta4;
      case 'respuesta5':
        return casas[index].respuesta5;
      case 'respuesta6': // Nueva respuesta
        return casas[index].respuesta6;
      case 'respuesta7': // Nueva respuesta
        return casas[index].respuesta7;
      default:
        return null;
    }
  }

  void _comprobarRespuestas() {
    if (_respuestasSeleccionadas.length < preguntas.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Atención'),
            content: const Text('Por favor, responde todas las preguntas antes de finalizar la prueba.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
      return;
    }

    Map<String, int> conteoCasa = {};

    for (var casa in casas) {
      conteoCasa[casa.nombre] = 0;
    }

    for (var respuesta in _respuestasSeleccionadas.values) {
      if (respuesta != null) {
        for (var casa in casas) {
          if (casa.respuesta1 == respuesta ||
              casa.respuesta2 == respuesta ||
              casa.respuesta3 == respuesta ||
              casa.respuesta4 == respuesta ||
              casa.respuesta5 == respuesta ||
              casa.respuesta6 == respuesta || // Nueva respuesta
              casa.respuesta7 == respuesta) { // Nueva respuesta
            conteoCasa[casa.nombre] = (conteoCasa[casa.nombre] ?? 0) + 1;
          }
        }
      }
    }

    String casaGanadora = '';
    int maxRespuestas = 0;
    for (var casa in conteoCasa.entries) {
      if (casa.value > maxRespuestas) {
        maxRespuestas = casa.value;
        casaGanadora = casa.key;
      }
    }

    // Buscar la imagen correspondiente a la casa ganadora
    String imagenCasaGanadora = '';
    for (var casa in casas) {
      if (casa.nombre == casaGanadora) {
        imagenCasaGanadora = casa.imagen;
        break;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('La casa en la que has sido seleccionado es: $casaGanadora'),
              const SizedBox(height: 8),
              Image.asset(imagenCasaGanadora),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
