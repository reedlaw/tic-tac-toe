function TicTacToe() {
  this.boards = [ ['', '', '', '', '' ,'' ,'' ,'', ''] ];
  this.player = 'O'; // defaults to O unless otherwise specified
  this.getMoveProxy = $.proxy( this.getMove, this )
  $('div.board').hide();
}
TicTacToe.prototype.play = function() {
  var that = this;
  $('div.choice').on( 'click', 'span', function() {
    that.pickSide( $(this).html() );
  });
};

TicTacToe.prototype.pickSide = function( side ) {
  $('div.choice').hide();
  $('div.board').show();
  this.player = side;
  if ( side === 'O' ) {
    this.getComputerMove();
  } else {
  }
  $('td').on( 'click', this.getMoveProxy );
};

TicTacToe.prototype.getMove = function(e) {
  this.makeMove( parseInt($(e.target).attr('id')) );
};

TicTacToe.prototype.getCurrentBoard = function() {
  var cells = [];
  $.each( $('td'), function() {
    cells.push( $.trim($(this).html()) );
  });
  return cells;
};

TicTacToe.prototype.makeMove = function( cell ) {
  var board = this.boards[this.boards.length - 1].slice(0);
  board[cell] = this.player;
  this.renderBoard( board );
  this.getComputerMove();
};

TicTacToe.prototype.getComputerMove = function() {
  var that = this;
  $.ajax({
    type: 'POST',
    url: '/move',
    data: { boards: that.boards },
    success: function( data ) {
      that.renderBoard( data.board );
    }
  });
};

TicTacToe.prototype.renderBoard = function( board ) {
  this.boards.push( board );
  $('td').each( function( index ) {
    $(this).html( board[index] );
  });
};

var game = new TicTacToe();
game.play();
