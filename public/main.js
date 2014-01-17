Zepto(function($){
  var moves = [];
  $('.xo').on('click', 'span', function() {
    $.ajax({
      type: 'POST',
      url: '/choice',
      data: { side: $(this).html() },
      success: function(data) {
        $('.choice').hide();
        $('.board').show();
        if (data.human_player_move) {
          awaitMove();
        } else {
          renderBoard(data.board);
        }
      }
    });
  });

  function awaitMove() {
    $('.board').on('click', 'td', placeMark);
  }

  function placeMark() {
    $.ajax({
      type: 'POST',
      url: '/move',
      data: {
        moves: moves,
        cell: $(this).attr('id')
      },
      success: function(data) {
        $('.board').off('click', 'td', placeMark);
        renderBoard(data.board);
      }
    });
  }

  function renderBoard(board) {
    moves.push(board);
    $('td').each(function(index) {
      mark = '';
      if (board[index]==1) {
        mark = 'X';
      } else if (board[index]==2) {
        mark = 'O';
      }
      $(this).html(mark);
    });
    awaitMove();
  }
})
