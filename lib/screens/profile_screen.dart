import 'package:flutter/material.dart';
import '../config/app_routes.dart';
import 'package:provider/provider.dart';
import '../models/profile_data.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

// Definición de colores
const Color _accentColor = Color(0xFF2196F3); // Azul vibrante de acento
const Color _expiredColor = Colors.redAccent;
const Color _activeColor = Colors.lightGreenAccent;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 0 = Watch History, 1 = Downloaded
  int _activeTabIndex = 0;

  // Carga estática de las listas de películas (Marvel data)
  final List<Movie> _watchHistory = MovieRepository.getWatchHistory();
  final List<Movie> _downloaded = MovieRepository.getDownloaded();

  @override
  Widget build(BuildContext context) {
    // Envuelto en Consumer para escuchar cambios en ProfileData
    return Consumer<ProfileData>(
      builder: (context, profile, child) {
        final Color subtitleColor =
            Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Mi perfil"),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.editProfile);
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            },
            child: const Icon(Icons.edit),
          ),

          body: Column(
            children: <Widget>[
              // Datos extraídos del Provider (se reconstruye con .name, .phone, etc.)
              _buildHeaderSection(profile, subtitleColor),
              _buildSubscriptionCard(context, profile),
              _buildTabs(),
              Divider(height: 1, color: Colors.white.withOpacity(0.1)),
              _buildMovieList(subtitleColor),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================
  // WIDGETS AUXILIARES
  // ===========================================================
  Widget _buildMovieList(Color subtitleColor) {
    List<Movie> currentList = _activeTabIndex == 0
        ? _watchHistory
        : _downloaded;

    String message = _activeTabIndex == 0
        ? 'Tu historial de visualización está vacío.'
        : 'No tienes películas descargadas.';

    if (currentList.isEmpty && _activeTabIndex == 1) {
      return Expanded(
        child: Center(
          child: Text(message, style: TextStyle(color: subtitleColor)),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: currentList.length,
        itemBuilder: (context, index) {
          final movie = currentList[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                movie.imageUrl,
                width: 50,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              movie.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${movie.description} (${movie.year})',
              style: TextStyle(color: subtitleColor),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.play_arrow, color: _accentColor, size: 30),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reproduciendo ${movie.title}')),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection(ProfileData profile, Color subtitleColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profile.imageUrl),
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 15),
          Text(
            profile.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone, color: subtitleColor, size: 18),
              const SizedBox(width: 5),
              Text(profile.phone, style: TextStyle(color: subtitleColor)),
              const SizedBox(width: 20),
              Icon(Icons.email, color: subtitleColor, size: 18),
              const SizedBox(width: 5),
              Text(profile.email, style: TextStyle(color: subtitleColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context, ProfileData profile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: _accentColor, width: 2),
      ),
      child: Column(
        children: <Widget>[
          const Icon(Icons.stars, color: Colors.amber, size: 40),
          const SizedBox(height: 10),
          Text(
            profile.subscriptionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            profile.subscriptionPrice,
            style: const TextStyle(color: _activeColor, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            "Expired on ${profile.subscriptionExpiry}",
            style: const TextStyle(color: _expiredColor, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          _TabButton(
            title: "Watch History",
            isActive: _activeTabIndex == 0,
            onTap: () => setState(() => _activeTabIndex = 0),
          ),
          const SizedBox(width: 10),
          _TabButton(
            title: "Downloaded",
            isActive: _activeTabIndex == 1,
            onTap: () => setState(() => _activeTabIndex = 1),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
