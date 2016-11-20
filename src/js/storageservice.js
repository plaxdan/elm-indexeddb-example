import localforage  from 'localforage';

localforage.config({
  name: 'elm-starter'
});

module.exports = {
  setItem: localforage.setItem
};
