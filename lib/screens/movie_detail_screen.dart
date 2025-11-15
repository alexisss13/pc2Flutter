import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con imagen de fondo
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(movie.imageUrl, fit: BoxFit.cover),
                  // Gradiente para mejorar legibilidad
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y año
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Año y descripción
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          movie.year,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          movie.description,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Rating
                  _buildRatingSection(),

                  const SizedBox(height: 30),

                  // Botones de acción
                  _buildActionButtons(context),

                  const SizedBox(height: 30),

                  // Sinopsis
                  const Text(
                    'Sinopsis',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getSynopsis(movie.title),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Cast
                  const Text(
                    'Reparto Principal',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  _buildCastSection(movie.title),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 28),
        const SizedBox(width: 8),
        const Text(
          '8.5',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text('/10', style: TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'PG-13',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reproduciendo ${movie.title}')),
              );
            },
            icon: const Icon(Icons.play_arrow, size: 28),
            label: const Text('Reproducir', style: TextStyle(fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Agregado a Mi Lista')),
            );
          },
          icon: const Icon(Icons.add, size: 28),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.3),
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Descargando...')));
          },
          icon: const Icon(Icons.download, size: 28),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.3),
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCastSection(String movieTitle) {
    final cast = _getCastWithImages(movieTitle);

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(cast[index]['image']!),
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 8),
                Text(
                  cast[index]['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getSynopsis(String title) {
    final synopses = {
      'Avengers: Endgame':
          'Después de los eventos devastadores de Avengers: Infinity War, el universo está en ruinas. Con la ayuda de los aliados que quedaron, los Vengadores se reúnen una vez más para deshacer las acciones de Thanos y restaurar el orden en el universo.',
      'Spider-Man: No Way Home':
          'Peter Parker es desenmascarado y ya no puede separar su vida normal de los enormes riesgos que conlleva ser un superhéroe. Cuando le pide ayuda a Doctor Strange, los riesgos se vuelven aún más peligrosos, obligándolo a descubrir lo que realmente significa ser Spider-Man.',
      'Black Panther':
          'Después de la muerte de su padre, T\'Challa regresa a Wakanda para tomar su lugar como rey. Sin embargo, su liderazgo es desafiado cuando un poderoso enemigo del pasado regresa para poner en peligro el destino de Wakanda y del mundo entero.',
      'Doctor Strange':
          'El famoso neurocirujano Stephen Strange sufre un accidente automovilístico que pone fin a su carrera. En su búsqueda de sanación, descubre el mundo oculto de la magia y las dimensiones alternativas, convirtiéndose en el Hechicero Supremo.',
      'Guardians of the Galaxy':
          'Un grupo de inadaptados intergalácticos debe unirse para evitar que un villano fanático obtenga un orbe que tiene el poder de destruir el universo. Esta aventura épica presenta héroes improbables que deben aprender a trabajar juntos.',
      'Iron Man':
          'Tony Stark, un industrial multimillonario y genio inventor, es secuestrado y obligado a construir un arma devastadora. En su lugar, usa su inteligencia para crear una armadura de alta tecnología y escapar, convirtiéndose en Iron Man.',
      'Captain Marvel':
          'Carol Danvers se convierte en una de las heroínas más poderosas del universo cuando la Tierra se ve atrapada en medio de una guerra galáctica entre dos razas alienígenas. Ambientada en los años 90, revela los orígenes de esta poderosa Avenger.',
      'Shang-Chi':
          'Shang-Chi debe enfrentarse al pasado que pensaba que había dejado atrás cuando se ve envuelto en la red de la misteriosa organización de los Diez Anillos. Una aventura llena de artes marciales y mitología china.',
      'Thor: Ragnarok':
          'Thor está prisionero en el otro lado del universo sin su poderoso martillo y se enfrenta a una carrera contra el tiempo para volver a Asgard y detener el Ragnarok, la destrucción de su mundo y el fin de la civilización Asgardiana.',
      'WandaVision':
          'Wanda Maximoff y Vision, dos seres superpoderosos que viven vidas suburbanas idealizadas, comienzan a sospechar que todo no es como parece. Una exploración única del dolor, el amor y la realidad misma.',
    };

    return synopses[title] ??
        'Una increíble aventura del Universo Cinematográfico de Marvel que te mantendrá al borde de tu asiento con acción espectacular, personajes memorables y giros inesperados.';
  }

  List<Map<String, String>> _getCastWithImages(String title) {
    final casts = {
      'Avengers: Endgame': [
        {
          'name': 'Robert Downey Jr.',
          'image':
              'https://image.tmdb.org/t/p/w200/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg',
        },
        {
          'name': 'Chris Evans',
          'image':
              'https://image.tmdb.org/t/p/w200/3bOGNsHlrswhyW79uvIHH1V43JI.jpg',
        },
        {
          'name': 'Scarlett Johansson',
          'image':
              'https://image.tmdb.org/t/p/w200/6NsMbJXRlDZuDzatN2akFdGuTvx.jpg',
        },
        {
          'name': 'Mark Ruffalo',
          'image':
              'https://m.media-amazon.com/images/M/MV5BM2JiYzA0ZGItNmFhYy00MjIyLWEwN2QtMzRmNDUyNjNiZjBiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
        },
      ],
      'Spider-Man: No Way Home': [
        {
          'name': 'Tom Holland',
          'image':
              'https://es.web.img2.acsta.net/pictures/23/05/30/13/16/0004762.jpg',
        },
        {
          'name': 'Zendaya',
          'image':
              'https://a.pinatafarm.com/1074x916/2bba2f129f/zendaya-euphoria.jpeg',
        },
        {
          'name': 'Benedict Cumberbatch',
          'image':
              'https://m.media-amazon.com/images/M/MV5BMjE0MDkzMDQwOF5BMl5BanBnXkFtZTgwOTE1Mjg1MzE@._V1_FMjpg_UX1000_.jpg',
        },
        {
          'name': 'Jacob Batalon',
          'image':
              'https://yt3.ggpht.com/LnPYK3tYTGCok5xUXF1r4-Sbf83xAmbzEtSvuHDCJllSzVdEUDrdLAXOQr3zH4HSbomBsVP6BEgtzg=s1024-nd-v1',
        },
      ],
      'Black Panther': [
        {
          'name': 'Chadwick Boseman',
          'image':
              'https://es.web.img2.acsta.net/c_310_420/pictures/16/10/21/17/23/376701.jpg',
        },
        {
          'name': 'Michael B. Jordan',
          'image':
              'https://m.media-amazon.com/images/M/MV5BMjExOTY3NzExM15BMl5BanBnXkFtZTgwOTg1OTAzMTE@._V1_FMjpg_UX1000_.jpg',
        },
        {
          'name': 'Lupita Nyong\'o',
          'image':
              'https://image.tmdb.org/t/p/w200/y40Wu1T742kynOqtwXASc5Qgm49.jpg',
        },
        {
          'name': 'Danai Gurira',
          'image':
              'https://es.web.img3.acsta.net/c_310_420/pictures/15/02/19/19/17/263774.jpg',
        },
      ],
      'Doctor Strange': [
        {
          'name': 'Benedict Cumberbatch',
          'image':
              'https://m.media-amazon.com/images/M/MV5BMjE0MDkzMDQwOF5BMl5BanBnXkFtZTgwOTE1Mjg1MzE@._V1_FMjpg_UX1000_.jpg',
        },
        {
          'name': 'Chiwetel Ejiofor',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/c/c2/Chiwetel_Ejiofor_at_the_2024_Toronto_International_Film_Festival_%28cropped%29.jpg',
        },
        {
          'name': 'Rachel McAdams',
          'image':
              'https://cdn.mos.cms.futurecdn.net/uSfStDhEXYJapQeRUfN7Vo.jpg',
        },
        {
          'name': 'Tilda Swinton',
          'image':
              'https://image.tmdb.org/t/p/w200/gWbX3a7V2MgRMRzekfITNcb27xV.jpg',
        },
      ],
      'Guardians of the Galaxy': [
        {
          'name': 'Chris Pratt',
          'image':
              'https://image.tmdb.org/t/p/w200/83o3koL82jt30EJ0rz4Bnzrt2dd.jpg',
        },
        {
          'name': 'Zoe Saldana',
          'image':
              'https://ntvb.tmsimg.com/assets/assets/194024_v9_bc.jpg?w=360&h=480',
        },
        {
          'name': 'Dave Bautista',
          'image':
              'https://media.vanityfair.com/photos/63b70e194373b00ff0436fac/master/w_2560%2Cc_limit/1433948913',
        },
        {
          'name': 'Bradley Cooper',
          'image':
              'https://parade.com/.image/w_3840,q_auto:good,c_limit/ODowMDAwMDAwMDAxMTgyNzgz/bradley-cooper-at-the-is-this-thing-on-premiere-during-the-63rd-new-york-film-festival-held-at-lincoln-center-on-october-10-2025-in-new-york-new-york-photo-by-john-nacionvariety-via-getty-images-stock.jpg',
        },
      ],
      'Iron Man': [
        {
          'name': 'Robert Downey Jr.',
          'image':
              'https://image.tmdb.org/t/p/w200/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg',
        },
        {
          'name': 'Gwyneth Paltrow',
          'image':
              'https://image.tmdb.org/t/p/w200/3bE5i9bNVxoqQYbx9Dr7gY2n1tG.jpg',
        },
        {
          'name': 'Jeff Bridges',
          'image':
              'https://image.tmdb.org/t/p/w200/xms1RAY6q7Lmu72SQKdONu4objN.jpg',
        },
        {
          'name': 'Terrence Howard',
          'image':
              'https://image.tmdb.org/t/p/w200/5KXD6CTWKxofC0vEVpqb1ObLrvJ.jpg',
        },
      ],
      'Captain Marvel': [
        {
          'name': 'Brie Larson',
          'image':
              'https://image.tmdb.org/t/p/w200/iqZ5uKJWbwSITCK4CqdlUHZTnXD.jpg',
        },
        {
          'name': 'Samuel L. Jackson',
          'image':
              'https://image.tmdb.org/t/p/w200/AiAYAqwpM5xmiFrAIeQvUXDCVvo.jpg',
        },
        {
          'name': 'Ben Mendelsohn',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/3/36/Ben_Mendelsohn_by_Gage_Skidmore.jpg',
        },
        {
          'name': 'Jude Law',
          'image':
              'https://image.tmdb.org/t/p/w200/9H577IoqFgCXonDzR3QEkF2xo5m.jpg',
        },
      ],
      'Shang-Chi': [
        {
          'name': 'Simu Liu',
          'image':
              'https://i.namu.wiki/i/-m72S5_ak-6cDJdUPcgb8lxdKgJx2ifejFuDcmn106fBmZYtb1pMnMYRAx8TGrpkEfeLsgcWhkIkilHs5tusnw.webp',
        },
        {
          'name': 'Awkwafina',
          'image':
              'https://image.tmdb.org/t/p/w200/l5AKkg3H1QhMuXmTTmq1EyjyiRb.jpg',
        },
        {
          'name': 'Tony Leung',
          'image':
              'https://ntvb.tmsimg.com/assets/assets/81012_v9_bb.jpg?w=360&h=480',
        },
        {
          'name': 'Michelle Yeoh',
          'image':
              'https://static.wikia.nocookie.net/doblaje/images/b/b8/Michelle_Yeoh.jpg/revision/latest?cb=20211120010504&path-prefix=es',
        },
      ],
      'Thor: Ragnarok': [
        {
          'name': 'Chris Hemsworth',
          'image':
              'https://image.tmdb.org/t/p/w200/jpurJ9jAcLCYjgHHfYF32m3zJYm.jpg',
        },
        {
          'name': 'Tom Hiddleston',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/5/5b/Tom_Hiddleston_at_the_2024_Toronto_International_Film_Festival_%28cropped%29.jpg',
        },
        {
          'name': 'Cate Blanchett',
          'image':
              'https://image.tmdb.org/t/p/w200/vq4vuAVhYngfzVNn8SbnG0JEy15.jpg',
        },
        {
          'name': 'Mark Ruffalo',
          'image':
              'https://m.media-amazon.com/images/M/MV5BM2JiYzA0ZGItNmFhYy00MjIyLWEwN2QtMzRmNDUyNjNiZjBiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
        },
      ],
      'WandaVision': [
        {
          'name': 'Elizabeth Olsen',
          'image':
              'https://m.media-amazon.com/images/M/MV5BMjEzMjA0ODk1OF5BMl5BanBnXkFtZTcwMTA4ODM3OQ@@._V1_.jpg',
        },
        {
          'name': 'Paul Bettany',
          'image':
              'https://image.tmdb.org/t/p/w500/oNrDowF5cRtK5lJJuCAh0KeFizy.jpg',
        },
        {
          'name': 'Kathryn Hahn',
          'image':
              'https://image.tmdb.org/t/p/w500/9sVllAKfEls3SJD3GoPm2JEZoa5.jpg',
        },
        {
          'name': 'Teyonah Parris',
          'image':
              'https://es.web.img3.acsta.net/pictures/16/07/14/21/31/325074.jpg',
        },
      ],
    };

    return casts[title] ??
        [
          {
            'name': 'Cast Principal',
            'image': 'https://image.tmdb.org/t/p/w200/placeholder.jpg',
          },
        ];
  }
}
