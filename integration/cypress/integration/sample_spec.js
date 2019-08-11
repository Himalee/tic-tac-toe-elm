describe("the app", () => {
  it("welcomes users", () => {
    cy.visit("http://localhost:8000/src/Main.elm");
    cy.contains('Welcome to Tic Tac Toe');
  });
});
