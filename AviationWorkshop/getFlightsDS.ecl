//Modules can't be run.
//For how to use a module please check view2019Flights or view2020Flights


EXPORT getFlightsDS := MODULE

// Creating flights datasets

    EXPORT flights2019_DS := DATASET(
                               '~2019::international::flights::schedules',
                               flightRecMod.flightRec,
                               THOR);
    

    EXPORT flights2020_DS := DATASET(
                               '~2020::international::flights::schedules',
                               flightRecMod.flightRec,
                               THOR);
    


END;