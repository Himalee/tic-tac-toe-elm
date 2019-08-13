describe("the app", () => {

  it("welcomes users", () => {
    cy.visit("http://localhost:8000/src/main.elm");
    cy.contains('Welcome to Tic Tac Toe');
  });


  it("displays 9 buttons that represent the board", () => {
    cy.visit("http://localhost:8000/src/main.elm");
    cy.get('button').should('have.length', 9)
  });

  it("clicks buttons and replaces text with 'X'", () => {
    cy.visit("http://localhost:8000/src/main.elm");
    cy.get('button').first().click()
    cy.get('button').first()
    cy.contains('X')
  });

  it("player marks are switched when clicking board buttons", () => {
    cy.visit("http://localhost:8000/src/main.elm");
    cy.get('button').first().click()
    cy.get('button').eq(1).click()
    cy.get('button').first().contains('X')
    cy.get('button').eq(1).contains('O')
  });

  it("players are not able to pick a cell that has already been marked", () => {
    cy.visit("http://localhost:8000/src/main.elm");
    cy.get('button').first().click()
    cy.get('button').first().should('be.disabled')
  });
});



