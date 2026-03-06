# Santa Biblia - App en Flutter

Esta es una aplicación de la Biblia desarrollada en Flutter con un diseño intuitivo y fácil de usar.

## Características

- **Diseño Limpio**: Tema en azul bajito con fondo blanco para una lectura cómoda.
- **Navegación Intuitiva**: Menú desplegable lateral (Drawer) dividido en Antiguo y Nuevo Testamento.
- **Lista de Libros**: Todos los libros de la Biblia organizados y accesibles rápidamente.
- **Favoritos**: Opción para marcar versículos como favoritos.
- **Ajuste de Texto**: Botones para aumentar o disminuir el tamaño de la letra para mejor legibilidad.
- **Tipografía**: Fuente tipo Arial para claridad.

## Cómo empezar

Si ya tienes Flutter instalado en tu computadora, sigue estos pasos para ejecutar el proyecto:

1. **Descarga y Extrae**: Si descargaste el proyecto como ZIP, extráelo en la carpeta donde guardas tus proyectos de Flutter.
2. **Navega a la carpeta**: Abre una terminal en la carpeta `bible_app`.
3. **Instala dependencias**:
   ```bash
   flutter pub get
   ```
4. **Ejecuta la app**:
   ```bash
   flutter run
   ```

## Estructura del Proyecto

- `lib/main.dart`: Contiene la lógica principal de la interfaz y el estado de la aplicación.
- `lib/bible_data.dart`: Contiene la lista de libros del Antiguo y Nuevo Testamento.
- `assets/biblia/`: Carpeta donde debes colocar los archivos JSON de la Biblia.

## Cómo agregar la Biblia completa

He preparado la aplicación para que sea escalable. Para agregar la Biblia completa:
1. Coloca tus archivos JSON en la carpeta `assets/biblia/`.
2. Asegúrate de que el formato coincida con el ejemplo en `assets/biblia/genesis.json`.
3. La aplicación detectará automáticamente los nuevos archivos si actualizas el cargador de datos en `main.dart`.
