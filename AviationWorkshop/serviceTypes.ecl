EXPORT ServiceTypes := DATASET
    (
        [
            {'J', 'Scheduled', 'Passenger', 'Normal Service'},
            {'S', 'Scheduled', 'Passenger', 'Shuttle Mode'},
            {'U', 'Scheduled', 'Passenger', 'Service Operated by Surface Vehicle'},
            {'F', 'Scheduled', 'Cargo/Mail', 'Loose Loaded Cargo and/or Preloaded Devices'},
            {'V', 'Scheduled', 'Cargo/Mail', 'Service Operated by Surface Vehicle'},
            {'M', 'Scheduled', 'Cargo/Mail', 'Mail Only'},
            {'Q', 'Scheduled', 'Passenger/Cargo', 'Passenger/Cargo in Cabin'},
            {'G', 'Additional Flights', 'Passenger', 'Normal Service'},
            {'B', 'Additional Flights', 'Passenger', 'Shuttle Mode'},
            {'A', 'Additional Flights', 'Cargo/Mail', 'Cargo/Mail'},
            {'R', 'Additional Flights', 'Passenger/Cargo', 'Passenger/Cargo in Cabin'},
            {'C', 'Charter', 'Passenger', 'Passenger Only'},
            {'O', 'Charter', 'Special Handling', 'Charter Requiring Special Handling'},
            {'H', 'Charter', 'Cargo/Mail', 'Cargo and/or Mail'},
            {'L', 'Charter', 'Passenger/Cargo/Mail', 'Passenger and Cargo and/or Mail'},
            {'P', 'Others', 'Not specific', 'Non-revenue'},
            {'T', 'Others', 'Not specific', 'Technical Test'},
            {'K', 'Others', 'Not specific', 'Training'},
            {'D', 'Others', 'Not specific', 'General Aviation'},
            {'E', 'Others', 'Not specific', 'Special'},
            {'W', 'Others', 'Not specific', 'Military'},
            {'X', 'Others', 'Not specific', 'Technical Stop'},
            {'I', 'Others', 'Not specific', 'State/Diplomatic/Air Ambulance'},
            {'N', 'Others', 'Not specific', 'Business Aviation/Air Taxi'}
        ],
        {
            STRING1     code,
            STRING      application,
            STRING      operation_type,
            STRING      desc
        }
    );
	
	
	