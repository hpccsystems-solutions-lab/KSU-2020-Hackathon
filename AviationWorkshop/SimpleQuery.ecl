IMPORT getFlightsDS;

// Read the data for query
ds := getFlightsDS.flights2019_DS;
OUTPUT( CHOOSEN(ds, 100), NAMED('Flights_2019'));

// Create the query
_countrycode := '' : STORED('countrycode');
result := ds(DepartCountryCode = _countrycode);
OUTPUT( CHOOSEN(result, 100), NAMED('result'));

// Once created the query, publish it via ECL Watch.
// The published query can be accessed via http://40.76.26.67:8002