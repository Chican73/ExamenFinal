import 'package:flutter/material.dart';

class TarjetaBlanca extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const TarjetaBlanca({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 6), blurRadius: 16),
        ],
      ),
      child: child,
    );
  }
}
