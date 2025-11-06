

## Features
 - Minimal Accordion widget. Use with ```AccordionMnmlWrapper``` only

```dart
import 'package:accordion_mnml/accordion_mnml.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccordionMnmlWrapper(
              isOneAtATime: false,
              items: [
                AccordionMnmlItem(
                  title: "Test",
                  headerPrefixIcon: Icon(Icons.leaderboard, size: 12),
                  child: Text("data"),
                ),
                AccordionMnmlItem(title: "TesT 2",backgroundColor: Colors.amber, child: Text("data"),),
                AccordionMnmlItem(title: "Test 3",boxShadows: [
                  BoxShadow(
                      color: Colors.red.withAlpha(30),
                      blurRadius: 10,
                      offset: Offset(10, 10)
                  ),
                ], child: Text("data"),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

```

## 🎥 Demo

<p align="center">
    <img src="https://raw.githubusercontent.com/Najeer-k11/accordion_mnml/main/demos/demo_photo.png" width="400">
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Najeer-k11/accordion_mnml/main/demos/demo_video.mp4" width="300">
</p>

