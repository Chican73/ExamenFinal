import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_form_provider.dart';
import '../../services/service.dart';
import '../../themes/my_theme.dart';
import '../../widgets/widgets.dart';
import '../error_screen.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final selected = productService.selectedProduct;
    if (selected == null) return const ErrorScreen();
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(selected),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductService productService;
  const _ProductScreenBody({required this.productService});

  void _showMessage(ScaffoldMessengerState messenger, String text) {
    messenger.showSnackBar(SnackBar(content: Text(text)));
  }

  Future<bool> _confirmarEliminar(BuildContext context) async {
    final respuesta = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Eliminar producto'),
        content: const Text('¿Seguro que quieres eliminar este producto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    return respuesta ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final busy = productService.isSaving;
    final esNuevo = productForm.product.productId == 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ImageProduct(
                  url: productForm.product.productImage,
                  height: 320,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const FormProduct(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // un producto nuevo todavía no existe, así que no se muestra borrar
          if (!esNuevo) ...[
            FloatingActionButton(
              heroTag: null,
              tooltip: 'Eliminar',
              backgroundColor: AppColors.danger,
              onPressed: busy
                  ? null
                  : () async {
                      final navigator = Navigator.of(context);
                      final messenger = ScaffoldMessenger.of(context);
                      if (!await _confirmarEliminar(context)) return;
                      final ok = await productService.deleteProduct(
                        productForm.product,
                      );
                      if (ok) {
                        navigator.pop();
                        _showMessage(messenger, 'Producto eliminado');
                      } else {
                        _showMessage(
                          messenger,
                          'No se pudo eliminar el producto',
                        );
                      }
                    },
              child: const Icon(Icons.delete_outline_rounded),
            ),
            const SizedBox(width: 16),
          ],
          FloatingActionButton(
            heroTag: null,
            tooltip: 'Guardar',
            backgroundColor: AppColors.primary,
            onPressed: busy
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (!productForm.isValidForm()) return;
                    final navigator = Navigator.of(context);
                    final messenger = ScaffoldMessenger.of(context);
                    final ok = await productService.editOrCreateProduct(
                      productForm.product,
                    );
                    if (ok) {
                      navigator.pop();
                      _showMessage(
                        messenger,
                        esNuevo ? 'Producto creado' : 'Cambios guardados',
                      );
                    } else {
                      _showMessage(messenger, 'No se pudo guardar el producto');
                    }
                  },
            child: busy
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Icon(Icons.save_rounded),
          ),
        ],
      ),
    );
  }
}
