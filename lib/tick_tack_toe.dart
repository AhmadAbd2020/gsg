import 'dart:io';

class TicTacToe {
  // List of String for sign - as empty field
  static List<String> board = List.filled(9, "-");
  // function to print the poard of game
  static void printBoard() {
    print('\n${board[0]} | ${board[1]} | ${board[2]}');
    print('${board[3]} | ${board[4]} | ${board[5]}');
    print('${board[6]} | ${board[7]} | ${board[8]}\n');
  }

  // reset the board after the game finised
  static void resetBoard() {
    board = List.filled(9, "-");
  }

  // method to handle the turn of the player
  static void takeTurn(String player) {
    print("$player's turn.");
    stdout.write('Choose a position from 1-9: ');
    int? position = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
    position -= 1;

    while (position! < 0 || position > 8 || board[position] != "-") {
      stdout.write('Invalid or taken position. Choose a different position: ');
      position = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
      position -= 1;
    }

    board[position] = player;
    printBoard();
  }

  // check the conditions when there is a case of 3 elemnts for same player in row
  static String checkGameOver() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      String a = board[condition[0]];
      String b = board[condition[1]];
      String c = board[condition[2]];
      if (a == b && b == c && a != "-") {
        return "win";
      }
    }
    // if the board filled and none of the conditions is acheived the game is tie
    if (!board.contains("-")) {
      return "tie";
    }

    return "play";
  }

  static void playGame() {
    // before new game the board is reset
    resetBoard();
    printBoard();
    String currentPlayer = "X";
    bool gameOver = false;

    while (!gameOver) {
      takeTurn(currentPlayer);
      String result = checkGameOver();
      if (result == "win") {
        print("$currentPlayer wins!");
        gameOver = true;
      } else if (result == "tie") {
        print("It's a tie!");
        gameOver = true;
      } else {
        currentPlayer = (currentPlayer == "X") ? "O" : "X";
      }
    }
  }

  // method to start the game
  static void start() {
    // boolean value to check if the user want to play again
    bool playAgain = true;
    while (playAgain) {
      playGame();
      stdout.write("\nDo you want to play again? (y/n): ");
      String? answer = stdin.readLineSync()?.trim().toLowerCase();
      playAgain = (answer == 'y');
    }
    print("Thanks for playing!");
  }
}
