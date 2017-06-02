type Weekday is
    ( Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday
    )


primitive Monday is Equatable[Weekday]

    fun apply(): U8 val =>
        0

    fun string(): String iso^ =>
        "Monday".string()


primitive Tuesday is Equatable[Weekday]

    fun apply(): U8 val =>
        1

    fun string(): String iso^ =>
        "Tuesday".string()


primitive Wednesday is Equatable[Weekday]

    fun apply(): U8 val =>
        2

    fun string(): String iso^ =>
        "Wednesday".string()


primitive Thursday is Equatable[Weekday]

    fun apply(): U8 val =>
        3

    fun string(): String iso^ =>
        "Thursday".string()


primitive Friday is Equatable[Weekday]

    fun apply(): U8 val =>
        4

    fun string(): String iso^ =>
        "Friday".string()


primitive Saturday is Equatable[Weekday]

    fun apply(): U8 val =>
        5

    fun string(): String iso^ =>
        "Saturday".string()


primitive Sunday is Equatable[Weekday]

    fun apply(): U8 val =>
        6

    fun string(): String iso^ =>
        "Sunday".string()

