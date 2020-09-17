_effectiveDate := '20200601':STORED('effectiveDate');
_discontinueDate := '20200630':STORED('discontinueDate');

// Get file path
filePath := '~2020::international::flights::schedules';

//create datasets
flights2020_DS := DATASET(filePath, 
                                RECORDOF(filePath, LOOKUP),
                                THOR);
// Filter dataset by input
dataSubset := flights2020_DS(DepartStationCode = 'ATL' AND
                             EffectiveDate >= _effectiveDate AND
                             DiscontinueDate <= _discontinueDate);
dataSubset;