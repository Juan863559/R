import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ThemeMode _themeMode = ThemeMode.light;

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

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Santa Biblia',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          primary: const Color(0xFF0288D1),
          surface: Colors.white,
          background: const Color(0xFFF0F7FF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F7FF),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF01579B),
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.lightBlue.shade50, width: 1),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: Brightness.dark,
          primary: Colors.lightBlueAccent,
          background: const Color(0xFF121212),
        ),
        fontFamily: 'Arial',
      ),
      home: BibleHomePage(
        fontSize: _fontSize,
        favorites: _favorites,
        themeMode: _themeMode,
        onToggleFavorite: _toggleFavorite,
        onChangeFontSize: _changeFontSize,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class BibleHomePage extends StatefulWidget {
  final double fontSize;
  final Set<String> favorites;
  final ThemeMode themeMode;
  final Function(String) onToggleFavorite;
  final Function(double) onChangeFontSize;
  final VoidCallback onToggleTheme;

  const BibleHomePage({
    super.key,
    required this.fontSize,
    required this.favorites,
    required this.themeMode,
    required this.onToggleFavorite,
    required this.onChangeFontSize,
    required this.onToggleTheme,
  });

  @override
  State<BibleHomePage> createState() => _BibleHomePageState();
}

class _BibleHomePageState extends State<BibleHomePage> {
  BibleBook _selectedBook = oldTestamentBooks[0];
  int _selectedChapter = 1;
  Map<String, dynamic>? _bibleData;
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadBibleData();
  }

  Future<void> _loadBibleData() async {
    setState(() => _isLoading = true);
    try {
      // Intentamos cargar el archivo JSON del libro seleccionado
      final String response = await rootBundle.loadString('assets/biblia/${_selectedBook.name.toLowerCase().replaceAll(' ', '_')}.json');
      final data = await json.decode(response);
      setState(() {
        _bibleData = data;
        _isLoading = false;
      });
    } catch (e) {
      // Si falla (por ejemplo, el archivo no existe), mostramos datos de ejemplo
      setState(() {
        _bibleData = null;
        _isLoading = false;
      });
    }
  }

  void _selectBook(BibleBook book) {
    setState(() {
      _selectedBook = book;
      _selectedChapter = 1;
    });
    _loadBibleData();
    Navigator.pop(context);
  }

  void _showFontSizeDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Ajustes de Lectura',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const Icon(Icons.text_fields, size: 20),
                Expanded(
                  child: Slider(
                    value: widget.fontSize,
                    min: 12,
                    max: 40,
                    onChanged: widget.onChangeFontSize,
                  ),
                ),
                const Icon(Icons.text_fields, size: 36),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(widget.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
              title: const Text('Cambiar tema'),
              onTap: widget.onToggleTheme,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              tileColor: Colors.lightBlue.withOpacity(0.05),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar en la Biblia...',
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {}),
              )
            : Text(
                _selectedBook.name,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () => setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) _searchController.clear();
            }),
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _showFontSizeDialog,
          ),
        ],
      ),
      drawer: BibleDrawer(
        onBookSelected: _selectBook,
        selectedBook: _selectedBook,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 40),
            _buildChapterSelector(),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: _getVerseCount(),
                      itemBuilder: (context, index) {
                        final verseNumber = index + 1;
                        final verseKey = '${_selectedBook.name} $_selectedChapter:$verseNumber';
                        final isFavorite = widget.favorites.contains(verseKey);

                        return _buildVerseCard(verseNumber, verseKey, isFavorite, _getVerseText(verseNumber));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterSelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 50,
        itemBuilder: (context, index) {
          final chapter = index + 1;
          final isSelected = _selectedChapter == chapter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8),
            child: ChoiceChip(
              label: Text('Capítulo $chapter'),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _selectedChapter = chapter);
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              side: BorderSide.none,
              elevation: isSelected ? 4 : 0,
            ),
          );
        },
      ),
    );
  }

  int _getVerseCount() {
    if (_bibleData == null) return 20; // Mock count
    final chapters = _bibleData!['chapters'] as List;
    if (_selectedChapter > chapters.length) return 0;
    final chapterData = chapters[_selectedChapter - 1];
    return (chapterData['verses'] as List).length;
  }

  String _getVerseText(int verseNumber) {
    if (_bibleData == null) {
      return 'Este es un versículo de ejemplo para el libro de ${_selectedBook.name}. El texto sagrado fluye aquí con elegancia y claridad.';
    }
    final chapters = _bibleData!['chapters'] as List;
    final chapterData = chapters[_selectedChapter - 1];
    return chapterData['verses'][verseNumber - 1];
  }

  Widget _buildVerseCard(int verseNumber, String verseKey, bool isFavorite, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      verseNumber.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey.shade400,
                      size: 20,
                    ),
                    onPressed: () => widget.onToggleFavorite(verseKey),
                  ),
                  IconButton(
                    icon: Icon(Icons.share_outlined, color: Colors.grey.shade400, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                text,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  height: 1.6,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.85),
                ),
              ),
            ],
          ),
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
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildSectionHeader('ANTIGUO TESTAMENTO'),
                ...oldTestamentBooks.map((book) => _buildBookTile(context, book)),
                const SizedBox(height: 24),
                _buildSectionHeader('NUEVO TESTAMENTO'),
                ...newTestamentBooks.map((book) => _buildBookTile(context, book)),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
              child: const Icon(Icons.auto_stories, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Santa Biblia',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildBookTile(BuildContext context, BibleBook book) {
    final isSelected = selectedBook.name == book.name;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ListTile(
        onTap: () => onBookSelected(book),
        selected: isSelected,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Icon(
          book.testament == 'Antiguo' ? Icons.history_edu : Icons.menu_book,
          size: 20,
          color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        title: Text(
          book.name,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : null,
          ),
        ),
        selectedTileColor: Theme.of(context).colorScheme.primary,
        trailing: isSelected ? const Icon(Icons.chevron_right, color: Colors.white) : null,
      ),
    );
  }
}
