import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> _board = List.filled(9, ''); // A 3x3 board represented as a list
  String _currentPlayer = 'X'; // Start with player 'X'
  bool _gameOver = false;
  String _winner = '';

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _gameOver = false;
      _winner = '';
    });
  }

  void _makeMove(int index) {
    if (_board[index] == '' && !_gameOver) {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner()) {
          _gameOver = true;
          _winner = _currentPlayer;
        } else if (!_board.contains('')) {
          _gameOver = true; // It's a draw
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X'; // Switch player
        }
      });
    }
  }

  bool _checkWinner() {
    // Define all possible winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      if (_board[combo[0]] != '' &&
          _board[combo[0]] == _board[combo[1]] &&
          _board[combo[1]] == _board[combo[2]]) {
        return true; // A winning combination is found
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
        backgroundColor: Color(0xff25125a),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.purple[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the game board
          _buildBoard(),
          SizedBox(height: 20),
          // Display the status
          _gameOver
              ? Text(
            _winner.isNotEmpty ? 'Winner: $_winner' : 'It\'s a Draw!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
              : Text(
            'Current Player: $_currentPlayer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Restart Game', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3x3 grid
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _makeMove(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
