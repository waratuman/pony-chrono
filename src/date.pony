class Date
    """
    Represents a date using the Proleptic Gregorian calendar.

    Minimum Date: January 1st, -5368710
    Maximum Date: December 31st, 5368709
    """

    var year: I32 val
    var month: Month val
    var day: U8 val

    // Internal variables
    var era: I64 val   // The era (a 400 year peroid that is repeated in the Gregorian calendar)
    var yoe: U16 val   // Year of era [0, 399] 
    var doy: U16 val   // Day of year [0, 365] (0 is March 1st)
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

        month = _month_from_doy(doy)

        day = (doy - _doy_from_month(month)).u8() + 1

        // Move back into Gregorian
        year = year + if month < March then
            1
        else
            0 
        end

        
    new ref civil(year': I32 val = 1970, month': U8 val = 1, day': U8 val = 1) =>
        """
        Create a new Date given the year, month and day.
        """
        // Calculation assume March 1st as the start of the year
        month = _month_from_u8(month')

        let year'': I64 val = if (month < March) then
            year'.i64() - 1
        else
            year'.i64()
        end


        let day'' = day'

        era = if year'' >= 0 then
            year''
        else
            year'' - 399
        end / 400
    
        yoe = (year'' - (era.i64() * 400)).u16()
        doy = _doy_from_month(month) + (day''.u16() - 1)
    
        doe = ((yoe.u32() * 365) + (yoe.u32() / 4) + doy.u32()) - (yoe.u32() / 100)

        dse = ((era * 146097) + doe.i64())

        year = year'
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
    


    fun tag _is_leap(year': I32 val): Bool val =>
        if (year' % 4) != 0 then
            false
        elseif (year' % 100) != 0 then
            true
        elseif (year' % 400) != 0 then
            false
        else
            true
        end


    fun tag _doy_from_month(month': Month val): U16 val =>
        """
        Returns the day of the year on which the month starts. The 1st day of
        the year for this calculation is March 1st.
        """
        match month'
        | March => 0
        | April => 31
        | May => 61
        | June => 92
        | July => 122
        | August => 153
        | September => 184
        | October => 214
        | November => 245
        | December => 275
        | January => 306
        | Febuaray => 337
        else 0
        end


    fun tag _month_from_doy(doy': U16 val): Month val =>
        if doy' < 31 then  March
        elseif doy' < 61 then April
        elseif doy' < 92 then May
        elseif doy' < 122 then June
        elseif doy' < 153 then July
        elseif doy' < 184 then August
        elseif doy' < 214 then September
        elseif doy' < 245 then October
        elseif doy' < 275 then November
        elseif doy' < 306 then December
        elseif doy' < 337 then January
        else Febuaray end
    
    fun tag _month_from_u8(value: U8 val): Month val =>
        match value
        | 1 => January
        | 2 => Febuaray
        | 3 => March
        | 4 => April
        | 5 => May
        | 6 => June
        | 7 => July
        | 8 => August
        | 9 => September
        | 10 => October
        | 11 => November
        | 12 => December
        else January
        end