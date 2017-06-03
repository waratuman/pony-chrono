use stdlib_time = "time"

class Date
    """
    Represents a date using the Proleptic Gregorian calendar.

    Minimum Date: January 1st, -5368710
    Maximum Date: December 31st, 5368709

    Reference: http://howardhinnant.github.io/date_algorithms.html
    """

    // Internal variables
    var _era: I64 val   // The era (a 400 year peroid that is repeated in the Gregorian calendar)
    var _yoe: U16 val   // Year of era [0, 399] 
    var _doy: U16 val   // Day of year [0, 365] (0 is March 1st)
    var _doe: U32 val   // Day of era [0, 146096]
    var _dse: I64 val   // Number of days since internal epoch (March 1st, 0)

    new ref create(z': (I64 val | None val) = None) =>
        """
        Create a new Date given the number of days since epoch, an I64
        within the range [-784_353_015_833, 784_351_576_776]. If the value is outside
        the range the algorithms used may not work correctly.
        """
        let z = match z'
        | let v: I64 val => v
        | let v: None val =>
            (let seconds, let nanonseconds) = stdlib_time.Time.now()
            seconds / 86_400
        else 0
        end

        _dse = z + 719_468

        _era = if _dse >= 0 then
            _dse
        else
            _dse - 146_096
        end / 146_097

        _doe = (_dse - (_era * 146_097)).u32()
        _yoe = (
            (_doe - ((_doe / 1_460) + (_doe / 36_524)) - (_doe / 146_096))
        / 365).u16()

        _doy = (_doe.i32() - (((365 * _yoe.i32()) + (_yoe.i32() / 4)) - (_yoe.i32() / 100))).u16()


    new ref civil(year': I32 val = 1970, month': (U8 val | Month val) = January, day': U8 val = 1) =>
        """
        Create a new Date given the year, month and day.
        """
        // Internal calculations assume March 1st as the start of the year
        let month'' = match month'
        | let v: U8 val => _month_from_u8(v)
        | let v: Month val => v
        else January
        end

        let year'': I64 val = if (month'' < March) then
            year'.i64() - 1
        else
            year'.i64()
        end

        _era = if year'' >= 0 then
            year''
        else
            year'' - 399
        end / 400
    
        _yoe = (year'' - (_era.i64() * 400)).u16()
        _doy = _doy_from_month(month'') + (day'.u16() - 1)
    
        _doe = ((_yoe.u32() * 365) + (_yoe.u32() / 4) + _doy.u32()) - (_yoe.u32() / 100)

        _dse = ((_era * 146_097) + _doe.i64())


    fun box days_since_epoch(): I64 val =>
        _dse - 719468


    fun box weekday(): Weekday =>
        """
        Returns the day of the week.
        """
        match _dse % 7
        | 0 => Wednesday
        | 1 => Thursday
        | 2 => Friday
        | 3 => Saturday
        | 4 => Sunday
        | 5 => Monday
        | 6 => Tuesday
        else Monday
        end


    fun box timestamp(): I64 val =>
        """
        Returns Unix Time, the number of seconds since January 1st, 1970.
        """
        days_since_epoch() * 86_400


    fun box year(): I32 val =>
        """
        The year of the date.
        """
        (_yoe.i32() + (_era.i32() * 400)) + if month() < March then
            1
        else
            0 
        end
        

    fun box month(): Month val =>
        """
        The month of the year.
        """
        if _doy < 31 then  March
        elseif _doy < 61 then April
        elseif _doy < 92 then May
        elseif _doy < 122 then June
        elseif _doy < 153 then July
        elseif _doy < 184 then August
        elseif _doy < 214 then September
        elseif _doy < 245 then October
        elseif _doy < 275 then November
        elseif _doy < 306 then December
        elseif _doy < 337 then January
        else Febuaray end


    fun box day(): U8 val =>
        """
        The day of the month ([1..31]).
        """
        (_doy - _doy_from_month(month())).u8() + 1


    // TODO: Replace this
    fun box format(fmt: String val): String val =>
        stdlib_time.Date(timestamp(), 0).format(fmt)


    // fun day_of_year() =>
    //     """
    //     Returns the day of the year ([1..366]).
    //     """


    // fun iso_week(): (I32 val, U8 val) =>
    //     """
    //     Returns the week year and week of the year, with the first week being
    //     the week that contains the first Thursday of the year. The first week
    //     according to ISO8601
    //     """
    //     (_doy / 7)
    //     _dse


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