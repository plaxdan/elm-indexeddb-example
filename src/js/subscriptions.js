
const storageService = require('./storageservice');

// Wire the Elm ports up to your JS services. Only a single value can be passed
// to an Elm port. Thus we must wrap values in Tuples, Lists, or Records etc.
module.exports = (ports) => {

  // Elm tuples are passed through ports as JS arrays.
  ports.saveTuple.subscribe(([key, val]) => {
    storageService.setItem(key, val);
  });

  // Elm records are passed through ports as JS objects
  ports.saveRecord.subscribe(({key, value} = record) => {
    storageService.setItem(key, value);
  });

  // Elm Lists are passed through ports as JS arrays
  ports.saveArray.subscribe(({key, value} = record) => {
    storageService.setItem(key, value);
  });
};
