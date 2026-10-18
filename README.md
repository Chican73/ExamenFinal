# ExamenFinal

Aplicación móvil hecha en Flutter.

Permite iniciar sesión / registrarse con Firebase Authentication y administrar **Productos, Categorías y Proveedores** (listar, ver, crear, editar y eliminar) consumiendo una API REST.

## Funcionalidades

- Login y registro de usuarios (Firebase Auth REST API).
- Menú de inicio con acceso a Productos, Categorías y Proveedores.
- **Categorías:** listar, ver detalle, crear, editar (nombre y estado Activa/Inactiva) y eliminar.
- **Proveedores:** listar, ver detalle, crear, editar (nombre, apellido, correo y estado Activo/Inactivo) y eliminar.
- Listado de productos en tarjetas, con recarga al deslizar hacia abajo.
- Crear, editar y eliminar productos (con confirmación antes de eliminar).
- Vista previa de la imagen al escribir la URL.
- Validación de formularios y mensajes de error en español.

## Tecnologías

| | |
|---|---|
| Framework | Flutter (Dart 3.10+) |
| Estado | `provider` |
| HTTP | `http` |
| Fuente | Poppins (Google Fonts, licencia OFL) |

## Estructura

```
lib/
├── assets/        imágenes y fuentes
├── helpers/       funciones de apoyo (formato de precio, conversiones)
├── models/        modelos Listado (producto), Categoria y Proveedor
├── providers/     estado de los formularios
├── routes/        rutas de la app
├── screens/       pantallas (login, home, productos, categorias, proveedores)
├── services/      conexión con Firebase y la API (api.dart + un servicio por módulo)
├── themes/        colores y tema
├── ui/            estilos de los inputs
└── widgets/       componentes reutilizables
```

## API utilizada

Servidor `http://143.198.118.203:8100/` con autenticación Basic.
| Módulo | Listar (GET) | Agregar (POST) | Editar (POST) | Eliminar (POST) |
|---|---|---|---|---|
| Productos | `ejemplos/product_list_rest/` | `ejemplos/product_add_rest/` | `ejemplos/product_edit_rest/` | `ejemplos/product_del_rest/` |
| Categorías | `ejemplos/category_list_rest/` | `ejemplos/category_add_rest/` | `ejemplos/category_edit_rest/` | `ejemplos/category_del_rest/` |
| Proveedores | `ejemplos/provider_list_rest/` | `ejemplos/provider_add_rest/` | `ejemplos/provider_edit_rest/` | `ejemplos/provider_del_rest/` |


## Autor

Christian Carmona Mendoza — Ingeniería en Informática, Universidad Mayor.
