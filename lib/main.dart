import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<Map<String, dynamic>> personajes = [
  {
    'nombre': 'Harry Potter',
    'caracteristicas': 'cicatriz',
    'objeto': 'gafas',
    'ojos': 'verde',
    'pelo': {
      'color': 'negro',
      'estilo': 'liso',
      'tamaño': 'corto',
    },
    'imagen': '../assets/harryPotter.jpg'
  },
  {
    'nombre': 'Hermione Granger',
    'caracteristicas': 'inteligencia',
    'objeto': 'libro',
    'ojos': 'marron',
    'pelo': {
      'color': 'castaño',
      'estilo': 'rizado',
      'tamaño': 'largo',
    },
    'imagen': '../assets/hermione.jpg'
  },
  {
    'nombre': 'Ron Weasley',
    'caracteristicas': 'ingenioso',
    'objeto': 'ajedrez',
    'ojos': 'azul',
    'pelo': {
      'color': 'pelirrojo',
      'estilo': 'liso',
      'tamaño': 'corto',
    },
    'imagen': '../assets/ron.jpg'
  },
   {
    'nombre': 'Draco Malfoy',
    'caracteristicas': 'rencoroso',
    'objeto': 'huron',
    'ojos': 'gris',
    'pelo': {
      'color': 'rubio',
      'estilo': 'liso',
      'tamaño': 'corto',
    },
    'imagen': '../assets/draco.jpg'
  },
  {
    'nombre': 'Fred Weasly',
    'caracteristicas': 'bromista',
    'objeto': 'grageas',
    'ojos': 'negro',
    'pelo': {
      'color': 'pelirrojo',
      'estilo': 'liso',
      'tamaño': 'corto',
    },
    'imagen': '../assets/fred.jpg'
  },
  {
    'nombre': 'George Weasly',
    'caracteristicas': 'bromista',
    'objeto': 'OrejasExtensibles',
    'ojos': 'negro',
    'pelo': {
      'color': 'pelirrojo',
      'estilo': 'liso',
      'tamaño': 'corto',
    },
    'imagen': '../assets/george.jpg'
  },
  {
    'nombre': 'Minerva McGonagall',
    'caracteristicas': 'animago',
    'objeto': 'sombrero',
    'ojos': 'azul',
    'pelo': {
      'color': 'negro',
      'estilo': 'liso',
      'tamaño': 'largo',
    },
    'imagen': '../assets/minerva.jpg'
  },
  {
    'nombre': 'Albus Dumbledore',
    'caracteristicas': 'director',
    'objeto': 'varitadeSauco',
    'ojos': 'azul',
    'pelo': {
      'color': 'blanco',
      'estilo': 'liso',
      'tamaño': 'largo',
    },
    'imagen': '../assets/albus.jpg'
  },
  {
    'nombre': 'Sirius Black',
    'caracteristicas': 'animago',
    'objeto': 'motovoladora',
    'ojos': 'azul',
    'pelo': {
      'color': 'negro',
      'estilo': 'rizado',
      'tamaño': 'largo',
    },
    'imagen': '../assets/sirius.jpg'
  },
  {
    'nombre': 'Lili Potter',
    'caracteristicas': 'inteligencia',
    'objeto': 'libro',
    'ojos': 'verde',
    'pelo': {
      'color': 'pelirrojo',
      'estilo': 'rizado',
      'tamaño': 'largo',
    },
    'imagen': '../assets/lily.jpg'
  },
   {
    'nombre': 'James Potter',
    'caracteristicas': 'animago',
    'objeto': 'mapa',
    'ojos': 'marron',
    'pelo': {
      'color': 'negro',
      'estilo': 'liso',
      'tamaño': 'corto',
    },
    'imagen': '../assets/james.jpg'
  },
  // Puedes agregar más personajes aquí con la misma estructura
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WIZARD GUESS',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                      // Si la clave es 'pelo', accedemos al subatributo correspondiente
                      atributoSeleccionado = personajeSeleccionado[clave]['color'];
                    } else {
                      // De lo contrario, accedemos al atributo directamente
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
        leading: Container(
            width: 80, // Ancho deseado para la imagen
            height: 80, // Alto deseado para la imagen
            child: Image.asset(
              _images[_colorIndex],
              fit: BoxFit.cover, // Ajustar la imagen para cubrir completamente el contenedor
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10), // Agregar margen debajo
                child: ElevatedButton(
                  onPressed: empezarJuego,
                  child: const Text('Empezar'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10), // Agregar margen debajo
                child: ElevatedButton(
                  onPressed: mostrarPreguntas,
                  child: const Text('Preguntas'),
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
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: marcada ? [
                        const BoxShadow(
                          color: Color.fromARGB(255, 244, 86, 54),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ] : null,
                    ),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                    //width: 150, // Ancho deseado de la imagen
                                    //height: 100, // Alto deseado de la imagen
                                    child: Image.asset(
                                      personaje['imagen'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      personaje['nombre'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text('Características: ${personaje['caracteristicas']}'),
                                    Text('Objeto: ${personaje['objeto']}'),
                                    Text('Ojos: ${personaje['ojos']}'),
                                    Text(
                                      'Pelo: ${personaje['pelo']['color']}, ${personaje['pelo']['estilo']}, ${personaje['pelo']['tamaño']}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10), // Agregar margen arriba y abajo
                                      child: ElevatedButton(
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
                                        child: const Text('Comprobar'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> preguntas = [
  
   // ------------- CARACTERISTICAS -------------
  {
    'pregunta': '¿Tiene una cicatriz?',
    'clave': 'caracteristicas',
    'respuesta': 'cicatriz',
  },
  {
    'pregunta': '¿Es inteligente?',
    'clave': 'caracteristicas',
    'respuesta': 'inteligencia',
  },
  {
    'pregunta': '¿Es ingenioso?',
    'clave': 'caracteristicas',
    'respuesta': 'ingenioso',
  },
  {
    'pregunta': '¿Es rencoroso?',
    'clave': 'caracteristicas',
    'respuesta': 'rencoroso',
  },
  {
    'pregunta': '¿Es bromista?',
    'clave': 'caracteristicas',
    'respuesta': 'bromista',
  },
  {
    'pregunta': '¿Es un animago?',
    'clave': 'caracteristicas',
    'respuesta': 'animago',
  },
  {
    'pregunta': '¿Es director?',
    'clave': 'caracteristicas',
    'respuesta': 'director',
  },
  // ------------- OBJETO -------------
  {
    'pregunta': '¿Usa gafas?',
    'clave': 'objeto',
    'respuesta': 'gafas',
  },
  {
    'pregunta': '¿Le gustan los libros?',
    'clave': 'objeto',
    'respuesta': 'libro',
  },
  {
    'pregunta': '¿Es bueno en el ajedrez?',
    'clave': 'objeto',
    'respuesta': 'ajedrez',
  },
   {
    'pregunta': '¿Es transformado en un huron?',
    'clave': 'objeto',
    'respuesta': 'huron',
  },
  {
    'pregunta': '¿le guistan las grageas?',
    'clave': 'objeto',
    'respuesta': 'grageas',
  },
  {
    'pregunta': '¿le gusta llebar sombrero?',
    'clave': 'objeto',
    'respuesta': 'sombrero',
  },
  {
    'pregunta': '¿el creeo las orejas extensibles?',
    'clave': 'objeto',
    'respuesta': 'OrejasExtensibles',
  },
  {
    'pregunta': '¿tiene o tubo una moto voladora?',
    'clave': 'objeto',
    'respuesta': 'motovoladora',
  },
  {
    'pregunta': '¿es dueño de la varita de sauco?',
    'clave': 'objeto',
    'respuesta': 'varitadesauco',
  },
   {
    'pregunta': '¿es o era dueño de un mapa?',
    'clave': 'objeto',
    'respuesta': 'mapa',
  },
  

  // ------------- OJOS -------------
  {
    'pregunta': '¿Tiene los ojos verdes?',
    'clave': 'ojos',
    'respuesta': 'verde',
  },
  {
    'pregunta': '¿Tiene los ojos marrones?',
    'clave': 'ojos',
    'respuesta': 'marron',
  },
  {
    'pregunta': '¿Tiene los ojos azules?',
    'clave': 'ojos',
    'respuesta': 'azul',
  },
   {
    'pregunta': '¿Tiene los ojos grises?',
    'clave': 'ojos',
    'respuesta': 'gris',
  },
     {
    'pregunta': '¿Tiene los ojos negros?',
    'clave': 'ojos',
    'respuesta': 'negro',
  },
  // ------------- PELO -------------
  {
    'pregunta': '¿Tiene el pelo negro y liso?',
    'clave': 'pelo',
    'respuesta': 'negro',
  },
  {
    'pregunta': '¿Tiene el pelo castaño y rizado?',
    'clave': 'pelo',
    'respuesta': 'castaño',
  },
  {
    'pregunta': '¿Tiene el pelo pelirrojo y corto?',
    'clave': 'pelo',
    'respuesta': 'pelirrojo',
  },
  {
    'pregunta': '¿Tiene el pelo rubio y corto?',
    'clave': 'pelo',
    'respuesta': 'rubio',
  },
];
