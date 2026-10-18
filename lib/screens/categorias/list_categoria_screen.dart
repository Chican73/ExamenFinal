import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/categoria.dart';
import '../../services/service.dart';
import '../../themes/my_theme.dart';
import '../../widgets/widgets.dart';

class ListCategoriaScreen extends StatelessWidget {
  const ListCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<CategoriaService>(context);
    final categorias = service.categorias;

    Widget cuerpo;
    if (service.isLoading) {
      cuerpo = const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    } else if (service.errorMessage != null && categorias.isEmpty) {
      cuerpo = MensajeVacio(
        icono: Icons.wifi_off_rounded,
        texto: service.errorMessage!,
        onReintentar: service.cargarCategorias,
      );
    } else if (categorias.isEmpty) {
      cuerpo = MensajeVacio(
        icono: Icons.category_outlined,
        texto: 'Aún no hay categorías.\nPresiona + para agregar una.',
        onReintentar: service.cargarCategorias,
      );
    } else {
      cuerpo = RefreshIndicator(
        color: AppColors.primary,
        onRefresh: service.cargarCategorias,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10, bottom: 90),
          itemCount: categorias.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                child: Text(
                  '${categorias.length} categorías registradas',
                  style: const TextStyle(color: AppColors.textLight),
                ),
              );
            }
            final categoria = categorias[index - 1];
            return ItemCard(
              leading: const IconoCuadrado(icono: Icons.category_rounded),
              titulo: categoria.categoryName,
              subtitulo: 'Código #${categoria.categoryId}',
              estado: categoria.categoryState,
              onTap: () {
                service.seleccionada = categoria.copy();
                Navigator.pushNamed(context, 'ver_categoria');
              },
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        actions: [
          IconButton(
            tooltip: 'Recargar',
            onPressed: service.cargarCategorias,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: cuerpo,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar categoría',
        child: const Icon(Icons.add_rounded, size: 30),
        onPressed: () {
          service.seleccionada = Categoria(
            categoryId: 0,
            categoryName: '',
            categoryState: 'Activa',
          );
          Navigator.pushNamed(context, 'edit_categoria');
        },
      ),
    );
  }
}
