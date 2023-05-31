import 'dart:math';

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
  var currentplayer = 'X';

  void drawxo(i) {
    if (grid[i] == '-' && winner == '') {
      setState(() {
        grid[i] = currentplayer;
        currentplayer = (currentplayer == 'X') ? '0' : 'X';

        if (currentplayer == '0') {
          makeAIMove();
        }

        findwinner(grid[i]);
      });
    }
  }

  void makeAIMove() {
    // Simulate AI thinking time (You can remove this delay for instant AI moves)
    {
      // Find available moves
      List<int> availableMoves = [];
      for (int i = 0; i < grid.length; i++) {
        if (grid[i] == '-') {
          availableMoves.add(i);
        }
      }

      if (availableMoves.isNotEmpty) {
        // Randomly select a move
        Random random = Random();
        int randomIndex = random.nextInt(availableMoves.length);
        int aiMove = availableMoves[randomIndex];

        // Make AI move
        setState(() {
          grid[aiMove] = currentplayer;
          currentplayer = (currentplayer == 'X') ? '0' : 'X';
          findwinner(grid[aiMove]);
        });
      }
    }
    ;
  }
  // void drawxo(i) {
  //   if (grid[i] == '-') {
  //     setState(() {
  //       grid[i] = currentplayer;

  //       currentplayer = currentplayer == 'X' ? '0' : 'X';
  //     });

  //     findwinnewer(grid[i]);
  //   }
  // }

  void reset() {
    winner = "";
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
    });
  }

  bool checkmove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findwinner(currentsign) {
    if (checkmove(0, 1, 2, currentsign) ||
        checkmove(3, 4, 5, currentsign) ||
        checkmove(6, 7, 8, currentsign) ||
        checkmove(0, 3, 6, currentsign) ||
        checkmove(1, 4, 7, currentsign) ||
        checkmove(2, 5, 8, currentsign) ||
        checkmove(0, 4, 8, currentsign) ||
        checkmove(2, 4, 6, currentsign)) {
      setState(() {
        winner = currentsign;
      });
    }
  }

  var winner = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text('TIC TAC TOE')),
      ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
            margin: EdgeInsets.all(20),
            color: Colors.black,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: grid.length,
              itemBuilder: (context, index) => Material(
                color: Colors.blue,
                child: InkWell(
                  splashColor: Colors.blue.shade100,
                  onTap: () => drawxo(index),
                  child: Center(
                    child: Text(
                      grid[index],
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: reset,
            icon: Icon(Icons.refresh),
            label: Text(
              "Play Again",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 40,
            width: 120,
            color: Colors.blue,
            child: Center(
                child: Text(
              '$winner Won Match',
              style: TextStyle(fontSize: 18),
            )),
          ),
        ],
      ),
    );
  }
}
