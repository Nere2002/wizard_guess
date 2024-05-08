import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wizard_guess/Widgets/fly.dart';
import 'package:wizard_guess/Widgets/personajes.dart';
import 'package:wizard_guess/preguntas.dart';
import 'package:wizard_guess/Widgets/second_game_page.dart'; // Importa la nueva página de juego

class QuienesQuien extends StatefulWidget {
  const QuienesQuien({Key? key}) : super(key: key);

  @override
  _QuienesQuienState createState() => _QuienesQuienState();
}

class _QuienesQuienState extends State<QuienesQuien> {
  int _colorIndex = 0;
  final List<Color> _appBarColors = [
    const Color.fromARGB(255, 110, 35, 42),
    const Color.fromARGB(255, 254, 184, 28),
    const Color.fromARGB(255, 15, 123, 71),
    const Color.fromARGB(255, 54, 83, 139),
  ];

  final List<String> _images = [
    '../assets/rojog.jpg',
    '../assets/amarilloh.jpg',
    '../assets/verdes.jpg',
    '../assets/azulr.jpg',
  ];

  final List<String> _appBarTitles = [
    'GRYFFINDOR',
    'HUFFELPUFF',
    'SLYTHERIN',
    'RAVENCLAW',
  ];

  void _changeAppBarColor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _appBarColors.length;
    });
  }

  late Map<String, dynamic> personajeSeleccionado;
  bool started = false;
  Set<int> cartasMarcadas = {};
  int _selectedIndex = 0;

  void empezarJuego() {
    final Random random = Random();
    final int randomNumber = random.nextInt(personajes.length);
    personajeSeleccionado = personajes[randomNumber];
    setState(() {
      started = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Encuentra el personaje'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void mostrarPreguntas() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Preguntas'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < preguntas.length; i++)
                  ListTile(
                    title: Text(preguntas[i]['pregunta']!),
                    onTap: () {
                      Navigator.pop(context);
                      final String clave = preguntas[i]['clave']!;
                      final String respuesta = preguntas[i]['respuesta']!;
                      dynamic atributoSeleccionado;

                      if (clave == 'pelo') {
                        atributoSeleccionado = personajeSeleccionado[clave]['color'];
                      } else {
                        atributoSeleccionado = personajeSeleccionado[clave]!;
                      }

                      final bool tieneCaracteristica = respuesta == atributoSeleccionado;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('¿El personaje ${preguntas[i]["pregunta"]}?'),
                            content: Text(tieneCaracteristica ? 'Sí' : 'No'),
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
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_colorIndex]),
        leading: ClipOval(
          child: Image.asset(
            _images[_colorIndex],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        backgroundColor: _appBarColors[_colorIndex],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _changeAppBarColor,
            icon: const Icon(
              Icons.color_lens,
              color: Colors.white,
            ),
          ),
        ],
        toolbarHeight: 80,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../assets/fondopreguntas.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: empezarJuego,
                    child: const Text('Empezar'),
                    style: ElevatedButton.styleFrom(
                 
                      backgroundColor: Colors.orange,
                      textStyle: TextStyle(color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: mostrarPreguntas,
                    child: const Text('Preguntas'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      textStyle: TextStyle(color: Colors.white),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: started,
              child: Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: personajes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final personaje = personajes[index];
                    final bool marcada = cartasMarcadas.contains(index);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (cartasMarcadas.contains(index)) {
                            cartasMarcadas.remove(index);
                          } else {
                            cartasMarcadas.add(index);
                          }
                        });
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: marcada ? Color.fromARGB(255, 74, 129, 232) : Colors.transparent,
                            width: 4,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: marcada ? Color.fromARGB(255, 74, 129, 232) : Colors.transparent,
                                    width: 4,
                                  ),
                                ),
                                child: Image.asset(
                                  personaje['imagen'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    personaje['nombre'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Características: ${personaje['caracteristicas']}',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Objeto: ${personaje['objeto']}',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Ojos: ${personaje['ojos']}',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Pelo: ${personaje['pelo']['color']}, ${personaje['pelo']['estilo']}, ${personaje['pelo']['tamaño']}',
                                    style: const TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (personajeSeleccionado == personaje) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('¡Correcto!'),
                                              content: const Text('Has acertado el personaje.'),
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
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Incorrecto'),
                                              content: const Text('Ese no es el personaje seleccionado.'),
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
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      textStyle: const TextStyle(color: Colors.white),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: const Text('Comprobar'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
