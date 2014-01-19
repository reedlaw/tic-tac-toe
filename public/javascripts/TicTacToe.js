function TicTacToe() {
  this.boards = [ ['', '', '', '', '' ,'' ,'' ,'', ''] ];
  this.player = 'O'; // defaults to O
  this.getMoveProxy = $.proxy( this.getMove, this )
  $('div.board').hide();
  $('div.message').hide();
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
    $('td').on( 'click', this.getMoveProxy );
  }
};

TicTacToe.prototype.getMove = function(e) {
  if ( $.trim($(e.target).html()) === '' ) {
    this.makeMove( parseInt($(e.target).attr('id')) );
  }
};

TicTacToe.prototype.getCurrentBoard = function() {
  var cells = [];
  $.each( $('td'), function() {
    cells.push( $.trim($(this).html()) );
  });
  return cells;
};

TicTacToe.prototype.makeMove = function( cell ) {
  $('td').off( 'click', this.getMoveProxy );
  var board = this.boards[this.boards.length - 1].slice(0);
  board[cell] = this.player;
  this.renderBoard( board );
  this.getComputerMove();
};

TicTacToe.prototype.getComputerMove = function() {
  var instance = this;
  $.ajax({
    type: 'POST',
    url: '/move',
    data: { boards: instance.boards },
    success: function( data ) {
      instance.renderBoard( data.board );
      if ( data.draw ) {
        instance.displayResult("It's a draw");
      } else if ( data.winner ) {
        instance.displayResult( "The winner is " + data.winner );
      } else {
        $('td').on( 'click', instance.getMoveProxy );
      }
    }
  });
};

TicTacToe.prototype.renderBoard = function( board ) {
  this.boards.push( board );
  $('td').each( function( index ) {
    $(this).html( board[index] );
  });
};

TicTacToe.prototype.displayResult = function( message ) {
  $('div.message').show().html( '<p>' + message + '</p>' );
  $('div.board').addClass('fade');
  var instance = this;
  $('body').on( 'click', function() {
    $('body').off('click');
    instance.boards = [ ['', '', '', '', '' ,'' ,'' ,'', ''] ];
    $('div.board').hide();
    $('div.board').removeClass('fade');
    $('div.message').hide();
    $('div.choice').show();
    $('td').each( function( index ) {
      $(this).html('');
    });
  });
};

var game = new TicTacToe();
game.play();
