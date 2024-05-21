import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Change Svg Color',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Svg Color Change'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String loadStadium = '';
  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  Future<void> _loadSvg() async {
    String svgString = await rootBundle.loadString('assets/stadium.svg');

      loadStadium = svgString;

  }

  void _changeColor() {
    setState(() {
      loadStadium = loadStadium.replaceAll('#f15744', '#00401A');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loadStadium.isEmpty
                ? const CircularProgressIndicator()
                :
            SvgPicture.string(
              loadStadium,
              height: 300,
              width: 300,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              clipBehavior: Clip.antiAlias,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _changeColor,
        label: const Text('Change'),
        // shape: const Icon(Icons.change_circle_outlined),
      ),
    );
  }
}
