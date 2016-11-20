'use strict';

require('./index.html');
const subscribe = require('./js/subscriptions');
const Elm = require('./elm/Main');
const app = Elm.Main.embed(document.getElementById('main'));

const askQuestion = (question) => {
  const answer = prompt(question);
  app.ports.receivePrompt.send(answer);
}

app.ports.sendPrompt.subscribe(askQuestion);
subscribe(app.ports);
