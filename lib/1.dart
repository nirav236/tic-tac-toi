import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];
  var currentPlayer = 'X';
  var aiPlayer = 'O';
  var winner = '';
  bool gameOver = false;

  void drawXO(int i) {
    if (!gameOver && grid[i] == '-') {
      setState(() {
        grid[i] = currentPlayer;

        if (checkWin(currentPlayer)) {
          winner = currentPlayer;
          gameOver = true;
        } else if (checkDraw()) {
          winner = 'Draw';
          gameOver = true;
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
          makeAIMove();
        }
      });
    }
  }

  void makeAIMove() {
    if (!gameOver) {
      int? aiMove;

      // Simple AI logic: Randomly select an available move
      while (aiMove == null) {
        var randomIndex = _getRandomIndex();
        if (grid[randomIndex] == '-') {
          aiMove = randomIndex;
        }
      }

      setState(() {
        grid[aiMove!] = aiPlayer;

        if (checkWin(aiPlayer)) {
          winner = aiPlayer;
          gameOver = true;
        } else if (checkDraw()) {
          winner = 'Draw';
          gameOver = true;
        } else {
          currentPlayer = 'X';
        }
      });
    }
  }

  bool checkWin(String sign) {
    return (
      (grid[0] == sign && grid[1] == sign && grid[2] == sign) ||
      (grid[3] == sign && grid[4] == sign && grid[5] == sign) ||
      (grid[6] == sign && grid[7] == sign && grid[8] == sign) ||
      (grid[0] == sign && grid[3] == sign && grid[6] == sign) ||
      (grid[1] == sign && grid[4] == sign && grid[7] == sign) ||
      (grid[2] == sign && grid[5] == sign && grid[8] == sign) ||
      (grid[0] == sign && grid[4] == sign && grid[8] == sign) ||
      (grid[2] == sign && grid[4] == sign && grid[6] == sign)
    );
  }

  bool checkDraw() {
    return !grid.contains('-');
  }

  int _getRandomIndex() {
    var random = Random();
    return random.nextInt(9);
  }

  void reset() {
    setState(() {
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
      currentPlayer = 'X';
      winner = '';
      gameOver = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('TIC TAC TOE')),
      ),
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
            margin: const EdgeInsets.all(20),
            color: Colors.black,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: grid.length,
              itemBuilder: (context, index) => Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.blue.shade100,
                  onTap: () => drawXO(index),
                  child: Center(
                    child: Text(
                      grid[index],
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: reset,
            icon: const Icon(Icons.refresh),
            label: const Text(
              "Play Again",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 40,
            width: 120,
            color: Colors.blue,
            child: Center(
              child: Text(
                winner.isEmpty ? '' : '$winner Won Match',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
