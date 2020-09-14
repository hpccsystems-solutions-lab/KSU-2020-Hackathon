
DS := DATASET(
                               '~2019::international::flights::schedules',
                               flightRecMod.flightRec,
                               THOR);

dataSubset := DS(DepartStationCode = 'ATL' AND EffectiveDate BETWEEN '20191101' AND '20191130');

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

//output(sortedResults,,'test::bi::atl', thor);

res := ds(departStationCode = 'ATL' and carrier = 'DL');
OUTPUT(res,,'test::res::realBI', thor);