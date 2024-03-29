# Tic Tac Toe in Elm [![Build Status](https://travis-ci.com/Himalee/tic-tac-toe-elm.svg?token=vxGGdM4Eg5UMEFC3e1fz&branch=master)](https://travis-ci.com/Himalee/tic-tac-toe-elm)

Single page Tic Tac Toe app built using Elm.

Users have the ability to:

- Play on a 3x3 board
- Play a Human vs Human game
- Play a Human vs Random Computer Player game
- Play a Human vs Unbeatable Computer Player game

## Getting Started

#### Prerequisites

1. Install [NodeJS](https://nodejs.org/en/).
2. Install the latest version of [Elm](https://guide.elm-lang.org/install.html) (version 0.19).

#### Running instructions

1. Clone the repository
2. In your terminal, navigate into the repository
3. Install dependencies with `$ npm install`
4. Run unit tests by running `$ npm run test`
6. Run integration tests by opening a new terminal window and starting development server with `$ npm run start`. Then run `$ npm run cypress:run`
7. To start the app, first build it with the command `$ elm make src/Main.elm --output index.js`. Then `$ open index.html`.
8. Alternatively, run the app in development mode. Start the app by running `$ npm run start`. Open [http://localhost:8000/src/Main.elm](http://localhost:8000/src/Main.elm) to view it in the browser.


#### Roadmap

- [ ] Implement `RandomComputerPlayer` using an Elm random generator.
- [ ] Deploy app.
- [ ] Run Cypress integration tests through Travis CI.
