describe("TicTacToe", function() {
  var game;

  beforeEach( function() {
    setFixtures(sandbox({ class: 'board' }));
    game = new TicTacToe();
  });

  it( "begins with a hidden board", function() {
    expect( $('div.board') ).toBeHidden();
  });

  it( "presents the Choose a side dialog", function() {
    setFixtures( sandbox({ class: 'choice' }) );
    expect( $('div.choice') ).toBeVisible();
  });

  describe("pickSide", function() {
    it( "hides the Choose a side dialog", function() {
      setFixtures( sandbox({ class: 'choice' }) );
      game.pickSide('X');
      expect( $('div.choice') ).toBeHidden();
    });

    it( "shows the game board", function() {
      game.pickSide('X');
      expect( $('div.board') ).toBeVisible();
    });

    it( "assigns the player to chosen side", function() {
      game.pickSide('X');
      expect( game.player ).toEqual("X");
    });

    it( "makes the first move if AI is X", function() {
      spyOn( TicTacToe.prototype, 'getComputerMove' );
      game.pickSide('O');
      expect( TicTacToe.prototype.getComputerMove ).toHaveBeenCalled();
    });

    it( "waits for the player's move if human player chooses X", function() {
      loadFixtures('board.html');
      game.pickSide('X');
      expect( $('td') ).toHandle('click');
    });
  });

  describe("getCurrentBoard", function() {
    it( "gets the state of the current board", function() {
      loadFixtures('board.html');
      expect(game.getCurrentBoard()).toEqual([ '', '', 'X', 'X', 'O', '', 'X', '', 'O' ]);
    });
  });

  describe("makeMove", function() {
    it( "gets the computer's move", function() {
      spyOn( TicTacToe.prototype, 'getComputerMove' );
      game.makeMove(0);
      expect( TicTacToe.prototype.getComputerMove ).toHaveBeenCalled();
    });
  });

  describe("getComputerMove", function() {
    beforeEach(function() {
      spyOn( $, "ajax" ).and.callFake(function(options) {
        options.success({  board: ['O', '', '', '', 'X', '', '', '', ''] });
      });
      spyOn( TicTacToe.prototype, 'renderBoard' );
    });

    it( "calls renderBoard with the next move of the AI", function() {
      game.makeMove(0);
      expect( TicTacToe.prototype.renderBoard ).toHaveBeenCalled();
      expect( TicTacToe.prototype.renderBoard ).toHaveBeenCalledWith([ 'O', '', '', '', 'X', '', '', '', ''] );
    });
  });

  describe("renderBoard", function() {
    it( "adds the board to be rendered to the boards array", function() {
      game.renderBoard(['', '', '', '', 'X', '', '', '', '']);
      var latest_board = game.boards[game.boards.length - 1]
      expect(latest_board).toEqual(['', '', '', '', 'X', '', '', '', '']);
    });

    it( "updates the DOM with the board state", function() {
      loadFixtures('board.html');
      game.renderBoard(['X', '', '', '', '', '', '', '', '']);
      expect($('td#0')).toContainHtml('X');
    });
  });
});
