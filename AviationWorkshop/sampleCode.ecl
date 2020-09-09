IMPORT std; //standard library

//to write the result in a logical file
result := CHOOSEN(getFlightsDS.flights2019_DS, 100);
OUTPUT(result,,   // your result 
         '~some::sample::output',  // logical file name you want it to save under, 
                                   // ~ makes the logical file avalible between all clusters
         THOR,  // file format
         EXPIRE(20), //File will be removed from cluster in 20 days
         OVERWRITE // Overwrite the result in logical file. 
         );

//**********************************************************************
//Simple COUNT
OUTPUT(
    COUNT(
        getFlightsDS.flights2019_DS(DepartStationCode = 'ATL') //Addming filter to just count depart from Atlanta
        ),
    NAMED('Depart_Atlanta'));

//**********************************************************************
//Simple filter and sort
simpleFilter := getFlightsDS.flights2019_DS(
                       Carrier IN ['DL', 'WN'] AND
                       (DepartStationCode = 'ATL' OR
                       ArriveCityCode = 'ATL')
                       );

sortIt := SORT(simpleFilter, -Carrier, FlightNumber);

OUTPUT(CHOOSEN(sortIT, 150), NAMED('filter_sort'));
//**********************************************************************
// Data Aggregation: TABLE and GROUP

// Find the average distance each carrier flies out of each airport by day of week
aveDistanceByCarrier := TABLE
    (
        getFlightsDS.flights2019_DS,
        {
            Carrier,
            FlightNumber,
            DepartCityCode,
            UNSIGNED2    dist_mon := AVE(GROUP, FlightDistance, IsOpMon = 1),
            UNSIGNED2    dist_tue := AVE(GROUP, FlightDistance, IsOpTue = 1),
            UNSIGNED2    dist_wed := AVE(GROUP, FlightDistance, IsOpWed = 1),
            UNSIGNED2    dist_thu := AVE(GROUP, FlightDistance, IsOpThu = 1),
            UNSIGNED2    dist_fri := AVE(GROUP, FlightDistance, IsOpFri = 1),
            UNSIGNED2    dist_sat := AVE(GROUP, FlightDistance, IsOpSat = 1),
            UNSIGNED2    dist_sun := AVE(GROUP, FlightDistance, IsOpSun = 1),
        },
        Carrier, FlightNumber, DepartCityCode
    );

//View the first 100
OUTPUT(CHOOSEN(aveDistanceByCarrier, 250), NAMED('aveDistanceByCarrier'));

//**********************************************************************
// Data Aggregation: TABLE and GROUP

// Only records for flights outbound from Atlanta starting in November 2019
dataSubset := getFlightsDS.flights2019_DS(DepartStationCode = 'ATL' AND EffectiveDate BETWEEN '20191101' AND '20191130');

// Count them by day of week
carrierCounts := TABLE
    (
        dataSubset,
        {
            Carrier,
            UNSIGNED2   num_monday    := SUM(GROUP, IsOpMon),
            UNSIGNED2   num_tuesday   := SUM(GROUP, IsOpTue),
            UNSIGNED2   num_wednesday := SUM(GROUP, IsOpWed),
            UNSIGNED2   num_thursday  := SUM(GROUP, IsOpThu),
            UNSIGNED2   num_friday    := SUM(GROUP, IsOpFri),
            UNSIGNED2   num_saturday  := SUM(GROUP, IsOpSat),
            UNSIGNED2   num_sunday    := SUM(GROUP, IsOpSun),
            UNSIGNED4   total         := SUM(GROUP, IsOpMon + IsOpTue + IsOpWed + IsOpThu + IsOpFri + IsOpSat + IsOpSun)
        },
        Carrier
    );

// Sort the results by total outbound count, descending
sortedResults := SORT(carrierCounts, -total);

OUTPUT(CHOOSEN(sortedResults, 200), NAMED('outbound_day_of_week'));

//*****************************************************************************************
//Append some fields to dataset and use of standard library
//Data Enrichment / Data Append: PROJECT and TRANSFORM

appnededRec := RECORD
     flightRecMod.flightRec;
     UNSIGNED4       schedule_duration_in_days;
     UNSIGNED4       depart_minutes_after_midnight;
     UNSIGNED4       arrive_minutes_after_midnight;
END;

//Transform will go over each row and applies rules defined in it.

//appanededRec: result layout out
//xform: transform name
//getFlightsDS.flights2019_DS: layout of input dataset
//Le: how the dataset will be called

appnededRec xform (flightRecMod.flightRec Le) := TRANSFORM
   
    //FromStringToDate returns date if it matches the given format and it's a valid date
    startedDate := Std.Date.FromStringToDate(Le.EffectiveDate, '%Y%m%d');
    stoppedDate := Std.Date.FromStringToDate(Le.DiscontinueDate, '%Y%m%d');

    //DaysBetween calculates the number of days between two dates
    SELF.schedule_duration_in_days := Std.Date.DaysBetween(startedDate, stoppedDate) + 1,
    
    // Note the substring operation, and casting of a string to an unsigned integer
    //Calculating time to total minutes 
    SELF.depart_minutes_after_midnight := ((UNSIGNED1)Le.DepartTimePassenger[1..2] * 60 + (UNSIGNED1)Le.DepartTimePassenger[3..4]),
    SELF.arrive_minutes_after_midnight := ((UNSIGNED1)Le.ArriveTimePassenger[1..2] * 60 + (UNSIGNED1)Le.ArriveTimePassenger[3..4]),
    SELF := Le

END; 

//Project is used with transform to probe the entire dataset.
appendData := PROJECT(
                 getFlightsDS.flights2019_DS, //original dataset 
                 xform(LEFT) //Calling transform and sending the dataset to it
);

OUTPUT(CHOOSEN(appendData, 200), NAMED('FlightsDuration'));

//*****************************************************************************************
//Append some fields to dataset and use of standard library
//Data Enrichment / Data Append: PROJECT and TRANSFORM

//Flights between Madrid and London
getFlights := getFlightsDS.flights2019_DS(
                                 DepartStationCode IN ['MAD', 'LTN'] AND
                                 ArriveStationCode IN ['MAD', 'LTN']);


flightRec := RECORD
     STRING       Carrier;
     INTEGER2     FlightNumber;
     STRING3      DepartStationCode;                      
     STRING3      ArriveStationCode;  
     BOOLEAN      isFlyingWeekend;
     STRING       FutureCalculation;
END;

captureWeekend := PROJECT(getFlights,       //Dataset to process
                    TRANSFORM(flightRec,    //Result dataset layout
                               SELF.isFlyingWeekend := LEFT.IsOpSat = 1 OR LEFT.IsOpSun = 1,
                               SELF := LEFT,
                               SELF := [] //Assings defult values to all undefined fields
                               ));
                               
OUTPUT(CHOOSEN(captureWeekend, 200), NAMED('captureWeekend'));

