import 'package:flutter/material.dart';
import '../config/app_routes.dart';
import '../widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bienvenido, Cristopher.",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildQuickAccessCard(context),
            const SizedBox(height: 30),
            const Text(
              "Recomendaciones para ti",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _buildMovieGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          Icon(
            Icons.stars,
            color: Theme.of(context).colorScheme.secondary,
            size: 40,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tu Suscripción Premium",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Acceso ilimitado hasta 05/08/2025",
                  style: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMovieGrid() {
    // Datos de películas simplificados para el dashboard
    final List<String> movieTitles = [
      'Tenet',
      'Inception',
      'Dunkirk',
      'Interstellar',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7, // Para que las portadas se vean verticales
      ),
      itemCount: movieTitles.length,
      itemBuilder: (context, index) {
        return CustomCard(
          padding: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/seed/${index + 100}/300/400',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  movieTitles[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
