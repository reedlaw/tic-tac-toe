function TicTacToe() {
  this.boards = [ ['', '', '', '', '' ,'' ,'' ,'', ''] ];
  this.player = 'O'; // defaults to O unless otherwise specified
  $('div.board').hide();
}
TicTacToe.prototype.play = function() {
  $('.xo').on('click', 'span', function() {
    TicTacToe.prototype.pickSide($(this).html());
  });
};

TicTacToe.prototype.pickSide = function(side) {
  $('div.choice').hide();
  $('div.board').show();
  this.player = side;
};

TicTacToe.prototype.getCurrentBoard = function() {
  var cells = [];
  $.each($('td'), function() {
    cells.push($.trim($(this).html()));
  });
  return cells;
};

TicTacToe.prototype.makeMove = function(cell) {
  var board = this.boards[this.boards.length - 1];
  board[cell] = this.player;
  this.boards.push(board);
  $.ajax({
    type: 'POST',
    url: '/move',
    data: { boards: this.boards },
    success: function(data) {
      TicTacToe.prototype.renderBoard(data.board);
    }
  });
};

TicTacToe.prototype.renderBoard = function(board) {
  $('td').each(function(index) {
    mark = '';
    if (board[index]==1) {
      mark = 'X';
    } else if (board[index]==2) {
      mark = 'O';
    }
    $(this).html(mark);
  });
};

TicTacToe.prototype.getBoards = function() {
  return this.boards;
};

TicTacToe.prototype.getPlayer = function() {
  return this.player;
};

var game = new TicTacToe();
game.play();
