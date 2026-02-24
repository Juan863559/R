import 'package:flutter/material.dart';
import 'bible_data.dart';

void main() {
  runApp(const BibleApp());
}

class BibleApp extends StatefulWidget {
  const BibleApp({super.key});

  @override
  State<BibleApp> createState() => _BibleAppState();
}

class _BibleAppState extends State<BibleApp> {
  double _fontSize = 18.0;
  final Set<String> _favorites = {};

  void _toggleFavorite(String verseKey) {
    setState(() {
      if (_favorites.contains(verseKey)) {
        _favorites.remove(verseKey);
      } else {
        _favorites.add(verseKey);
      }
    });
  }

  void _changeFontSize(double delta) {
    setState(() {
      _fontSize = (_fontSize + delta).clamp(12.0, 40.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santa Biblia',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial', // Fallback to system sans-serif if not found
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB3E5FC), // Light Blue 100
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      home: BibleHomePage(
        fontSize: _fontSize,
        favorites: _favorites,
        onToggleFavorite: _toggleFavorite,
        onChangeFontSize: _changeFontSize,
      ),
    );
  }
}

class BibleHomePage extends StatefulWidget {
  final double fontSize;
  final Set<String> favorites;
  final Function(String) onToggleFavorite;
  final Function(double) onChangeFontSize;

  const BibleHomePage({
    super.key,
    required this.fontSize,
    required this.favorites,
    required this.onToggleFavorite,
    required this.onChangeFontSize,
  });

  @override
  State<BibleHomePage> createState() => _BibleHomePageState();
}

class _BibleHomePageState extends State<BibleHomePage> {
  BibleBook _selectedBook = oldTestamentBooks[0];

  void _selectBook(BibleBook book) {
    setState(() {
      _selectedBook = book;
    });
    Navigator.pop(context); // Close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedBook.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_decrease),
            onPressed: () => widget.onChangeFontSize(-2),
          ),
          IconButton(
            icon: const Icon(Icons.text_increase),
            onPressed: () => widget.onChangeFontSize(2),
          ),
        ],
      ),
      drawer: BibleDrawer(
        onBookSelected: _selectBook,
        selectedBook: _selectedBook,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: 20, // Mocking 20 verses per book for now
          itemBuilder: (context, index) {
            final verseNumber = index + 1;
            final verseKey = '${_selectedBook.name} $verseNumber';
            final isFavorite = widget.favorites.contains(verseKey);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$verseNumber ',
                    style: TextStyle(
                      fontSize: widget.fontSize * 0.8,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[700],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Este es un versículo de ejemplo para el libro de ${_selectedBook.name}. Aquí se mostraría el texto sagrado correspondiente.',
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => widget.onToggleFavorite(verseKey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BibleDrawer extends StatelessWidget {
  final Function(BibleBook) onBookSelected;
  final BibleBook selectedBook;

  const BibleDrawer({
    super.key,
    required this.onBookSelected,
    required this.selectedBook,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB3E5FC),
            ),
            child: Center(
              child: Text(
                'Santa Biblia',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  leading: const Icon(Icons.book, color: Colors.lightBlue),
                  title: const Text('Antiguo Testamento'),
                  initiallyExpanded: selectedBook.testament == 'Antiguo',
                  children: oldTestamentBooks.map((book) {
                    return ListTile(
                      title: Text(book.name),
                      selected: selectedBook.name == book.name,
                      onTap: () => onBookSelected(book),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  leading: const Icon(Icons.menu_book, color: Colors.lightBlue),
                  title: const Text('Nuevo Testamento'),
                  initiallyExpanded: selectedBook.testament == 'Nuevo',
                  children: newTestamentBooks.map((book) {
                    return ListTile(
                      title: Text(book.name),
                      selected: selectedBook.name == book.name,
                      onTap: () => onBookSelected(book),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
