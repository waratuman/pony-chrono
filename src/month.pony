type Month is 
    ( January
    | Febuaray
    | March
    | April
    | May
    | June
    | July
    | August
    | September
    | October
    | November
    | December
    )


primitive January is Comparable[Month]

    fun apply(): U8 val =>
        0

    fun string(): String iso^ =>
        "January".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive Febuaray is Comparable[Month]

    fun apply(): U8 val =>
        1
    
    fun string(): String iso^ =>
        "Febuaray".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive March is Comparable[Month]
    
    fun apply(): U8 val =>
        2

    fun string(): String iso^ =>
        "March".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive April is Comparable[Month]

    fun apply(): U8 val =>
        3

    fun string(): String iso^ =>
        "April".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive May is Comparable[Month]
    
    fun apply(): U8 val =>
        4

    fun string(): String iso^ =>
        "May".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive June is Comparable[Month]
    
    fun apply(): U8 val =>
        5

    fun string(): String iso^ =>
        "June".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive July is Comparable[Month]

    fun apply(): U8 val =>
        6

    fun string(): String iso^ =>
        "July".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive August is Comparable[Month]

    fun apply(): U8 val =>
        7

    fun string(): String iso^ =>
        "August".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive September is Comparable[Month]

    fun apply(): U8 val =>
        8

    fun string(): String iso^ =>
        "September".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive October is Comparable[Month]

    fun apply(): U8 val =>
        9

    fun string(): String iso^ =>
        "October".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()


primitive November is Comparable[Month]

    fun apply(): U8 val =>
        10

    fun string(): String iso^ =>
        "November".string()

    fun box lt(that: Month): Bool val=>
        apply() < that.apply()


primitive December is Comparable[Month]

    fun apply(): U8 val =>
        11

    fun string(): String iso^ =>
        "December".string()

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()
