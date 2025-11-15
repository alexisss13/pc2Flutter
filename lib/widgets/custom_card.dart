import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double padding;

  const CustomCard({super.key, required this.child, this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      // Usa el color de Card definido en el tema (1E1E1E)
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
