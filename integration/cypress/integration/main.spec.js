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
});


