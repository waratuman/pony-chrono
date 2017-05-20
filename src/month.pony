type Month is 
    ( January
    | Febuaray
    | March
    | April
    | June
    | July
    | August
    | September
    | October
    | November
    | December
    )

primitive January

    fun apply(): U8 val =>
        0

    fun string(): String iso^ =>
        "January".string()


primitive Febuaray

    fun apply(): U8 val =>
        1
    
    fun string(): String iso^ =>
        "Febuaray".string()


primitive March
    
    fun apply(): U8 val =>
        2

    fun string(): String iso^ =>
        "March".string()


primitive April

    fun apply(): U8 val =>
        3

    fun string(): String iso^ =>
        "April".string()


primitive May
    
    fun apply(): U8 val =>
        4

    fun string(): String iso^ =>
        "May".string()


primitive June
    
    fun apply(): U8 val =>
        5

    fun string(): String iso^ =>
        "June".string()


primitive July

    fun apply(): U8 val =>
        6

    fun string(): String iso^ =>
        "July".string()


primitive August

    fun apply(): U8 val =>
        7

    fun string(): String iso^ =>
        "August".string()


primitive September

    fun apply(): U8 val =>
        8

    fun string(): String iso^ =>
        "September".string()


primitive October

    fun apply(): U8 val =>
        9

    fun string(): String iso^ =>
        "October".string()


primitive November

    fun apply(): U8 val =>
        10

    fun string(): String iso^ =>
        "November".string()


primitive December

    fun apply(): U8 val =>
        11

    fun string(): String iso^ =>
        "December".string()
