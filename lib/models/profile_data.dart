import 'package:flutter/material.dart';

class ProfileData extends ChangeNotifier {
  String _name = "Alexis Levano";
  String _phone = "421345321";
  String _email = "Nolan@gmail.com";
  String _imageUrl =
      'https://media.istockphoto.com/id/1171169099/es/foto/hombre-con-brazos-cruzados-aislados-sobre-fondo-gris.jpg?s=612x612&w=0&k=20&c=8qDLKdLMm2i8DHXY6crX6a5omVh2IxqrOxJV2QGzgFg=';

  // Datos de Suscripción
  final String subscriptionTitle = "1 Year of Unlimited Moviez";
  final String subscriptionPrice = "USD 50.00 / 1 Year";
  final String subscriptionExpiry = "05/08/2025";

  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get imageUrl => _imageUrl;

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  }) {
    _name = name;
    _phone = phone;
    _email = email;
    notifyListeners(); // ¡Crucial para que ProfileScreen se reconstruya!
  }

  ProfileData();
}
