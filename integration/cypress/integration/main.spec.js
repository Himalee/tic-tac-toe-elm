describe("the app", () => {

  beforeEach(() => {
    cy.visit("http://localhost:8000/src/main.elm");
  });

  it("welcomes users", () => {
    cy.contains('Welcome to Tic Tac Toe');
  });

  it("displays 9 buttons that represent the board", () => {
    cy.get('button').should('have.length', 9)
  });

  it("clicks buttons and replaces text with 'X'", () => {
    cy.get('button').first().click()
    cy.get('button').first()
    cy.contains('X')
  });

  it("player marks are switched when clicking board buttons", () => {
    cy.get('button').first().click()
    cy.get('button').eq(1).click()
    cy.get('button').first().contains('X')
    cy.get('button').eq(1).contains('O')
  });

  it("players are not able to pick a cell that has already been marked", () => {
    cy.get('button').first().click()
    cy.get('button').first().should('be.disabled')
  });

  it("plays game until X wins and displays winning message", () => {
    cy.get('button').first().click()
    cy.get('button').eq(8).click()
    cy.get('button').eq(1).click()
    cy.get('button').eq(7).click()
    cy.get('button').eq(2).click()
    cy.contains('Player X wins!');
  });

  it("plays game until it results in a draw and displays winning message", () => {
    cy.get('button').first().click()
    cy.get('button').eq(1).click()
    cy.get('button').eq(2).click()
    cy.get('button').eq(3).click()
    cy.get('button').eq(5).click()
    cy.get('button').eq(4).click()
    cy.get('button').eq(6).click()
    cy.get('button').eq(8).click()
    cy.get('button').eq(7).click()
    cy.contains('It\'s a draw!');
  });
});
