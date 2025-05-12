import 'dart:collection';
import 'dart:io';

class TicTacToe {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));
  String currentPlayer = 'X';

  void printBoard() {
    print('\nCurrent Board:');
    for (var row in board) {
      print(row.map((cell) => cell.isEmpty ? ' ' : cell).join(' | '));
    }
  }

  bool makeMove(int row, int col) {
    if (row < 0 || row >= 3 || col < 0 || col >= 3 || board[row][col] != ' ') {
      print('Invalid move. Try again.');
      return false;
    }
    board[row][col] = currentPlayer;
    return true;
  }

  bool checkWin() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer)
        return true;
      if (board[0][i] == currentPlayer &&
          board[1][i] == currentPlayer &&
          board[2][i] == currentPlayer)
        return true;
    }
    if (board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer)
      return true;
    if (board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer)
      return true;
    return false;
  }

  bool checkDraw() {
    return board.every((row) => row.every((cell) => cell != ' '));
  }

  void switchPlayer() {
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }

  void start() {
    print('Tic Tac Toe Game');
    while (true) {
      printBoard();
      stdout.write('Player $currentPlayer, enter your move (row and column): ');
      final input = stdin.readLineSync();
      if (input == null) continue;
      final parts = input.split(' ');
      if (parts.length != 2) continue;
      final row = int.tryParse(parts[0]);
      final col = int.tryParse(parts[1]);
      if (row == null || col == null) continue;
      if (makeMove(row, col)) {
        if (checkWin()) {
          printBoard();
          print('Player $currentPlayer wins!');
          break;
        } else if (checkDraw()) {
          printBoard();
          print('It\'s a draw!');
          break;
        }
        switchPlayer();
      }
    }
  }
}

void main() {
  TicTacToe game = TicTacToe();

  game.start();
}
