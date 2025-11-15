import 'package:flutter/material.dart';

class ProfileData extends ChangeNotifier {
  String _name = "Cristopher Nolan";
  String _phone = "421345321";
  String _email = "Nolan@gmail.com";
  String _imageUrl = 'https://picsum.photos/seed/nolan/200/300';

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
    notifyListeners(); // Notifica a los widgets que dependen de estos datos
  }

  ProfileData();
}
