describe("TicTacToe", function() {
  var game;

  beforeEach(function() {
    setFixtures(sandbox({class: 'board'}));
    game = new TicTacToe();
  });

  it("begins with a hidden board", function() {
    expect($('div.board')).toBeHidden();
  });

  it("presents the Choose a side dialog", function() {
    setFixtures(sandbox({class: 'choice'}));
    expect($('div.choice')).toBeVisible();
  });

  describe("pickSide", function() {
    it("hides the Choose a side dialog", function() {
      setFixtures(sandbox({class: 'choice'}));
      game.pickSide("X");
      expect($('div.choice')).toBeHidden();
    });

    it("shows the game board", function() {
      game.pickSide("X");
      expect($('div.board')).toBeVisible();
    });

    it("assigns the player to chosen side", function() {
      game.pickSide("X");
      expect(game.getPlayer()).toEqual("X");
    });
  });

  describe("getCurrentBoard", function() {
    it("gets the state of the current board", function() {
      loadFixtures('board.html');
      expect(game.getCurrentBoard()).toEqual(['', '', 'X', 'X', 'O', '', 'X', '', 'O']);
    });
  });

  describe("makeMove", function() {
    beforeEach(function() {
      spyOn($, "ajax").and.callFake(function(options) {
        options.success({ board: ['O', '', '', '', 'X', '', '', '', ''] });
      });
      spyOn(TicTacToe.prototype, 'renderBoard');
    });

    it("adds the latest board state to the boards array", function() {
      game.makeMove(0);
      var boards = game.getBoards();
      var latest_board = boards[boards.length - 1]
      expect(latest_board).toEqual(['O', '', '', '', '', '', '', '', '']);
    });

    it("calls renderBoard with the next move of the AI", function() {
      game.makeMove(0);
      expect(TicTacToe.prototype.renderBoard).toHaveBeenCalled();
      expect(TicTacToe.prototype.renderBoard).toHaveBeenCalledWith(['O', '', '', '', 'X', '', '', '', '']);
    });
  });

  it("specifying response when you need it", function() {
    // var renderBoard = jasmine.createSpy("success");

    // expect(jasmine.Ajax.requests.mostRecent().url).toBe('/choice');
    // expect(renderBoard).not.toHaveBeenCalled();

    // jasmine.Ajax.requests.mostRecent().response({ "status": 200,
    //                                               "contentType": 'application/json;charset=utf-8',
    //                                               "responseText": { board: [0, 0, 0, 0, 1, 0, 0, 0, 0] }
    //                                             });


    // expect(renderBoard).toHaveBeenCalledWith([0, 0, 0, 0, 1, 0, 0, 0, 0]);
  });
  
  // it("keeps a record of every move", function() {
  //   var move1 = [0, 0, 0, 0, 1, 0, 0, 0, 0];
  //   game.makeMove(move1);
  //   expect(game.getBoards()).toEqual([move1]);
  //   var move2 = [0, 2, 0, 0, 1, 0, 0, 0, 0];
  //   game.makeMove(move2);
  //   expect(game.getBoards()).toEqual([move1, move2]);
  // });
});
