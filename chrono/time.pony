class Time
    """
    Represents a time of day as nanoseconds since midnight.
    """
    
    var _nanoseconds: U64 val = 86_399_999_999_999

    new ref create(z: U64 val) =>
        _nanoseconds = z
    
    fun nanos(): U64 val =>
        _nanoseconds

    fun sec(): USize val =>
        """
        Returns the seconds of the minute ([0-59]).
        """
        ((_nanoseconds / 1_000_000_000).u32() % 60).usize()

    fun min(): USize val =>
        """
        Returns the minute of the hour ([0-59]).
        """
        ((_nanoseconds / 60_000_000_000).u32() % 60).usize()

    fun hour(): USize val =>
        """
        Returns the hour of the day ([0-23]).
        """
        ((_nanoseconds / 3_600_000_000_000).u32() % 12).usize()
        
