        STRING3             Carrier;                                // Two or three letter code assigned by IATA or ICAO for the Carrier
        INTEGER2            FlightNumber;                           // Flight number
        STRING1             CodeShareFlag;                          // Dervice type indicator is used to classify carriers according to the type of air service they provide
        STRING3             CodeShareCarrier;                       // Alternate flight designator or ticket selling airline
        STRING1             ServiceType;                            // Classify carriers according to the type of air service they provide
        STRING8             EffectiveDate;                          // Effective date represents the date that the carrier has scheduled this flight service to begin; YYYYMMDD
        STRING8             DiscontinueDate;                        // Discontinued date represents the last date that the carrier has scheduled this flight service to operate; YYYYMMDD
        UNSIGNED1           IsOpMon;                                // Indicates whether the flight has service on Monday
        UNSIGNED1           IsOpTue;                                // Indicates whether the flight has service on Tuesday
        UNSIGNED1           IsOpWed;                                // Indicates whether the flight has service on Wednesday
        UNSIGNED1           IsOpThu;                                // Indicates whether the flight has service on Thursday
        UNSIGNED1           IsOpFri;                                // Indicates whether the flight has service on Friday
        UNSIGNED1           IsOpSat;                                // Indicates whether the flight has service on Saturday
        UNSIGNED1           IsOpSun;                                // Indicates whether the flight has service on Sunday
        STRING3             DepartStationCode;                      // Standard IATA Airport code for the point of trip origin
        STRING2             DepartCountryCode;                      // Standard IATA Country code for the point of trip origin
        STRING2             DepartStateProvCode;                    // Innovata State Code
        STRING3             DepartCityCode;                         // Departure city code contains the city code for the point of trip origin
        STRING10            DepartTimePassenger;                    // Published flight departure time; HHMMSS
        STRING10            DepartTimeAircraft;                     // Agreed SLOT departure time; HHMMSS
        STRING5             DepartUTCVariance;                      // UTC Variant for the departure airport; [+-]HHMM
        STRING2             DepartTerminal;                         // Departure terminal
        STRING3             ArriveStationCode;                      // Standard IATA Airport code for the point of arrival
        STRING2             ArriveCountryCode;                      // Standard IATA Country code for the point of arrival
        STRING2             ArriveStateProvCode;                    // Innovata State Code
        STRING3             ArriveCityCode;                         // Arrival city code contains the city code for the point of trip origin
        STRING10            ArriveTimePassenger;                    // Published flight arrival time; HHMMSS
        STRING10            ArriveTimeAircraft;                     // Agreed SLOT arrival time; HHMMSS
        STRING5             ArriveUTCVariance;                      // UTC Variant for the arrival airport; [+-]HHMM
        STRING2             ArriveTerminal;                         // Arrival terminal
        STRING3             EquipmentSubCode;                       // Sub aircraft type on the first leg of the flight
        STRING3             EquipmentGroupCode;                     // Group aircraft type on the first leg of the flight
        VARSTRING4          CabinCategoryClasses;                   // Most commonly used service classes
        VARSTRING40         BookingClasses;                         // Full list of Service Class descriptions
        INTEGER1            ArriveDayIndicator;                     // Signifies which day the flight will arrive with respect to the origin depart day; <blank> = same day, -1 = day before, 1 = day after, 2 = two days after
        INTEGER1            NumberOfIntermediateStops;              // Set to zero (i.e. nonstop) if the flight does not land between the point of origin and final destination
        VARSTRING50         IntermediateStopStationCodes;           // IATA airport codes where stops occur, separated by “!”
        BOOLEAN             IsEquipmentChange;                      // Signifies whether there has been an aircraft change at a stopover point for the flight leg
        VARSTRING60         EquipmentCodesAcrossSector;             // Sub-aircraft type on each leg of the flight
        VARSTRING80         MealCodes;                              // Contains up to two meal codes per class of service
        INTEGER2            FlightDurationLessLayover;              // Refers to Actual Air time of flight; does not include layover time
        INTEGER2            FlightDistance;                         // Shortest distance (in miles) between the origin and destination points
        INTEGER2            FlightDistanceThroughIndividualLegs;
        INTEGER2            LayoverTime;                            // Minutes
        INTEGER2            IVI;                                    // Itinerary Variation Identifier.  
        INTEGER2            FirstLegNumber;
        VARSTRING50         InFlightServiceCodes;                   // Standard IATA In-Flight Service codes.
        BOOLEAN             IsCodeShare;                            // True if flight is operated by another carrier
        BOOLEAN             IsWetLease;                             // True if wet lease (owned by one carrier and operated by another)
        VARSTRING155        CodeShareInfo;                          // Information regarding operating and marketing carriers
        INTEGER             FirstClassSeats;
        INTEGER             BusinessClassSeats;
        INTEGER             PremiumEconomySeats;
        INTEGER             EconomyClassSeats;
        INTEGER             TotalSeats;
        UNSIGNED            SectorizedId;           