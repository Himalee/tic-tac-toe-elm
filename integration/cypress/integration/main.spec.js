describe("the app", () => {

  beforeEach(() => {
    cy.visit("http://localhost:8000/src/main.elm");
  });

  it("welcomes users", () => {
    cy.get('#humanvhuman').click()
    cy.contains('Welcome to Tic Tac Toe');
  });

  it("displays 9 buttons that represent the board", () => {
    cy.get('#humanvhuman').click()
    cy.get('button').should('have.length', 9)
  });

  it("clicks buttons, replaces text with 'X' and displays message that game is still in play", () => {
    cy.get('#humanvhuman').click()
    cy.get('#cell0').click()
    cy.contains('X')
    cy.contains('Play!');
  });

  it("player marks are switched when clicking board buttons", () => {
    cy.get('#humanvhuman').click()
    cy.get('#cell0').click()
    cy.get('#cell1').click()
    cy.get('#cell0').contains('X')
    cy.get('#cell1').contains('O')
  });

  it("players are not able to pick a cell that has already been marked", () => {
    cy.get('#humanvhuman').click()
    cy.get('#cell0').click()
    cy.get('#cell0').should('be.disabled')
  });

  it("plays game until X wins, displays winning message, and disables empty cells", () => {
    cy.get('#humanvhuman').click()
    cy.get('#cell0').click()
    cy.get('#cell8').click()
    cy.get('#cell1').click()
    cy.get('#cell7').click()
    cy.get('#cell2').click()
    cy.get('#cell3').should('be.disabled')
    cy.get('#cell4').should('be.disabled')
    cy.get('#cell5').should('be.disabled')
    cy.get('#cell6').should('be.disabled')
    cy.contains('Player X wins!');
  });

  it("plays game until it results in a draw and displays draw message", () => {
    cy.get('#humanvhuman').click()
    cy.get('#cell0').click()
    cy.get('#cell1').click()
    cy.get('#cell2').click()
    cy.get('#cell3').click()
    cy.get('#cell5').click()
    cy.get('#cell4').click()
    cy.get('#cell6').click()
    cy.get('#cell8').click()
    cy.get('#cell7').click()
    cy.contains('It\'s a draw!');
  });

  it("random computer player picks first available position", () => {
    cy.get('#humanvrandom').click()
    cy.get('#cell0').click()
    cy.get('#cell1').contains('O')
  });

  it("random computer player O picks first available position to win", () => {
    cy.get('#humanvrandom').click()
    cy.get('#cell6').click()
    cy.get('#cell7').click()
    cy.get('#cell8').click()
    cy.contains('Player O wins!');
  });

  it("hard computer player picks top left corner position as first move if not taken", () => {
    cy.get('#humanvhard').click()
    cy.get('#cell4').click()
    cy.get('#cell0').contains('O')
  });

  it("hard computer player block player X from winning", () => {
    cy.get('#humanvhard').click()
    cy.get('#cell2').click()
    cy.get('#cell5').click()
    cy.get('#cell8').contains('O')
  });

  it("hard computer player plays to win", () => {
    cy.get('#humanvhard').click()
    cy.get('#cell4').click()
    cy.get('#cell2').click()
    cy.get('#cell5').click()
    cy.contains('Player O wins!');
  });
});
