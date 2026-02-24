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

  void _changeFontSize(double newSize) {
    setState(() {
      _fontSize = newSize.clamp(12.0, 40.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santa Biblia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          primary: const Color(0xFF0288D1),
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F9FF), // Very light blue-grey
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE1F5FE),
          foregroundColor: Color(0xFF01579B),
          elevation: 0,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
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

  void _showFontSizeDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24.0),
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Tamaño de letra',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.text_fields, size: 16),
                      Expanded(
                        child: Slider(
                          value: widget.fontSize,
                          min: 12,
                          max: 40,
                          onChanged: (value) {
                            setModalState(() {
                              widget.onChangeFontSize(value);
                            });
                          },
                        ),
                      ),
                      const Icon(Icons.text_fields, size: 32),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedBook.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_size),
            onPressed: _showFontSizeDialog,
          ),
        ],
      ),
      drawer: BibleDrawer(
        onBookSelected: _selectBook,
        selectedBook: _selectedBook,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        itemCount: 20,
        itemBuilder: (context, index) {
          final verseNumber = index + 1;
          final verseKey = '${_selectedBook.name} $verseNumber';
          final isFavorite = widget.favorites.contains(verseKey);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1F5FE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Versículo $verseNumber',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                          onPressed: () => widget.onToggleFavorite(verseKey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Este es un versículo de ejemplo para el libro de ${_selectedBook.name}. El texto sagrado fluye aquí con elegancia y claridad, permitiendo una lectura amena y espiritual.',
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_stories, size: 40, color: Colors.lightBlue[800]),
                  const SizedBox(height: 8),
                  Text(
                    'Santa Biblia',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue[900],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildTestamentSection(
                  context,
                  title: 'Antiguo Testamento',
                  icon: Icons.history_edu,
                  books: oldTestamentBooks,
                  isAntiguo: true,
                ),
                const Divider(height: 1),
                _buildTestamentSection(
                  context,
                  title: 'Nuevo Testamento',
                  icon: Icons.menu_book,
                  books: newTestamentBooks,
                  isAntiguo: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestamentSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<BibleBook> books,
    required bool isAntiguo,
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: const Color(0xFF0288D1)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      initiallyExpanded: selectedBook.testament == (isAntiguo ? 'Antiguo' : 'Nuevo'),
      children: books.map((book) {
        final isSelected = selectedBook.name == book.name;
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 32),
          title: Text(
            book.name,
            style: TextStyle(
              color: isSelected ? const Color(0xFF0288D1) : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: isSelected ? const Icon(Icons.check_circle, size: 18, color: Color(0xFF0288D1)) : null,
          selected: isSelected,
          onTap: () => onBookSelected(book),
        );
      }).toList(),
    );
  }
}
