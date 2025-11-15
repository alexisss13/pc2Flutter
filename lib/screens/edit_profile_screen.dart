// ... imports ...
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/profile_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los datos actuales del Provider
    final profile = Provider.of<ProfileData>(context, listen: false);
    _nameController.text = profile.name;
    _phoneController.text = profile.phone;
    _emailController.text = profile.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final profile = Provider.of<ProfileData>(context, listen: false);

    profile.updateProfile(
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
    );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil actualizado con éxito!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usamos Selector para reconstruir solo si cambia la URL de la imagen (opcional)
    final imageUrl = Selector<ProfileData, String>(
      selector: (_, profile) => profile.imageUrl,
      builder: (context, url, child) {
        return CircleAvatar(radius: 60, backgroundImage: NetworkImage(url));
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  imageUrl, // Avatar
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildTextField(
              context,
              'Nombre Completo',
              _nameController,
              Icons.person,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              context,
              'Teléfono',
              _phoneController,
              Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),
            _buildTextField(
              context,
              'Email',
              _emailController,
              Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _saveChanges, // Llama a la función de guardado
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Guardar Cambios',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).cardColor,
        filled: true,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
