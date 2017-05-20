class Date
    """
    Represents a date using the Proleptic Gregorian calendar.

    Minimum Date: January 1st, -5368710
    Maximum Date: December 31st, 5368709
    """

    var year: I32 val
    var month: U8 val
    var day: U8 val

    // Internal variables
    var era: I64 val   // The era (a 400 year peroid that is repeated in the Gregorian calendar)
    var yoe: U16 val   // Year of era [0, 399] 
    var doy: U16 val   // Day of year [0, 365]
    var doe: U32 val   // Day of era [0, 146096]
    var dse: I64 val   // Number of days since internal epoch (March 1st, 0)


    new ref create(z: I64 val) ? =>
        """
        Create a new Date given the number of days since epoch, an I64
        within the range [-784353015833, 784351576776]. If the value is outside
        the range an error is thrown.
        """
        if (z < -784353015833) or (z > 784351576776) then
            error
        end

        dse = z + 719468

        era = if dse >= 0 then
            dse
        else
            dse - 146096
        end / 146097

        doe = (dse - (era * 146097)).u32()
        yoe = (
            (doe - ((doe / 1460) + (doe / 36524)) - (doe / 146096))
        / 365).u16()

        year = (yoe.i32() + (era.i32() * 400))
        doy = (doe.i32() - (((365 * yoe.i32()) + (yoe.i32() / 4)) - (yoe.i32() / 100))).u16()

        let m': U8 val = _month_from_doy(doy)

        day = (doy - _doy_from_month(m')).u8() + 1

        month = m' + if (m' < 10) then
            3
        else
            - 9
        end

        // Move back into Gregorian
        year = year + if month < 3 then
            1
        else
            0 
        end

        
    new ref civil(year': I32 val = 1970, month': U8 val = 1, day': U8 val = 1) =>
        """
        Create a new Date given the year, month and day.
        """
        let year'': I64 val = if (month' <= 2) then
            year'.i64() - 1
        else
            year'.i64()
        end

        // Calculation assume March 1st as the start of the year
        let month'' = if (month' > 2) then
            month' - 3
        else
            month' + 9
        end

        let day'' = day'

        era = if year'' >= 0 then
            year''
        else
            year'' - 399
        end / 400
    
        yoe = (year'' - (era.i64() * 400)).u16()
        doy = _doy_from_month(month'') + (day''.u16() - 1)
    
        doe = ((yoe.u32() * 365) + (yoe.u32() / 4) + doy.u32()) - (yoe.u32() / 100)

        dse = ((era * 146097) + doe.i64())

        year = year'
        month = month'
        day = day'



    fun box days_since_epoch(): I64 val =>
        dse - 719468

    fun box weekday(): Weekday =>
        """
        Returns the day of the week.
        """
        match dse % 7
        | 0 => Wednesday
        | 1 => Thursday
        | 2 => Friday
        | 3 => Saturday
        | 4 => Sunday
        | 5 => Monday
        | 6 => Tuesday
        else Monday
        end
    


    fun tag _is_leap(year': I32 val) =>
        if (year' % 4) != 0 then
            false
        elseif (year' % 100) != 0 then
            true
        elseif (year' % 400) != 0 then
            false
        else
            true
        end


    fun tag _doy_from_month(month': U8 val): U16 val =>
        """
        Returns the day of the year on which the month starts. The 1st day of
        the year for this calculation is March 1st.
        """
        match month'
        | 1 => 31
        | 2 => 61
        | 3 => 92
        | 4 => 122
        | 5 => 153
        | 6 => 184
        | 7 => 214
        | 8 => 245
        | 9 => 275
        | 10 => 306
        | 11 => 337
        else 0
        end


    fun tag _month_from_doy(doy': U16 val): U8 val =>
        if doy' < 31 then  0
        elseif doy' < 61 then 1
        elseif doy' < 92 then 2
        elseif doy' < 122 then 3
        elseif doy' < 153 then 4
        elseif doy' < 184 then 5
        elseif doy' < 214 then 6
        elseif doy' < 245 then 7
        elseif doy' < 275 then 8
        elseif doy' < 306 then 9
        elseif doy' < 337 then 10
        else 11 end