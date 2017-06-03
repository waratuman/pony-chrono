class Time
    """
    Represents a time of day as nanoseconds since midnight. The current
    implementation does not handle leap seconds (23:59:60)
    """
    
    var _nanoseconds: U64 val = 86_399_999_999_999

    new ref create(z: U64 val) =>
        _nanoseconds = z

    new ref civil(hour': U8 val = 0, min': U8 val = 0, sec': U8 val = 0, nsec': U64 val = 0) =>
        _nanoseconds = (((((hour'.u64() * 60) + min'.u64()) * 60) + sec'.u64()) * 1_000_000_000) + nsec'

    fun hour(): USize val =>
        """
        Returns the hour of the day ([0-23]).
        """
        ((_nanoseconds / 3_600_000_000_000).u32() % 24).usize()
    
    fun min(): USize val =>
        """
        Returns the minute of the hour ([0-59]).
        """
        ((_nanoseconds / 60_000_000_000).u32() % 60).usize()
    
    fun sec(): USize val =>
        """
        Returns the seconds of the minute ([0-59]).
        """
        ((_nanoseconds / 1_000_000_000) % 60).usize()

    fun nsec(): U64 val =>
        _nanoseconds % 1_000_000_000
