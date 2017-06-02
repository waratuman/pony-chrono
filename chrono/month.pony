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

trait MonthTrait is Comparable[Month]

    fun apply(): U8 val

    fun box add(value: U8 val): Month val =>
        month_from_u8(apply() + value)

    fun box sub(value: U8 val): Month val =>
        month_from_u8(apply() - value)

    fun tag month_from_u8(value: U8 val): Month val =>
        match value % 12
        | 0 => January
        | 1 => Febuaray
        | 2 => March
        | 3 => April
        | 4 => May
        | 5 => June
        | 6 => July
        | 7 => August
        | 8 => September
        | 9 => October
        | 10 => November
        | 11 => December
        else January
        end

    fun box lt(that: Month): Bool val =>
        apply() < that.apply()
    
primitive January is MonthTrait

    fun apply(): U8 val =>
        0

    fun string(): String iso^ =>
        "January".string()


primitive Febuaray is MonthTrait

    fun apply(): U8 val =>
        1
    
    fun string(): String iso^ =>
        "Febuaray".string()


primitive March is MonthTrait
    
    fun apply(): U8 val =>
        2

    fun string(): String iso^ =>
        "March".string()


primitive April is MonthTrait

    fun apply(): U8 val =>
        3

    fun string(): String iso^ =>
        "April".string()

    
primitive May is MonthTrait
    
    fun apply(): U8 val =>
        4

    fun string(): String iso^ =>
        "May".string()

    

primitive June is MonthTrait
    
    fun apply(): U8 val =>
        5

    fun string(): String iso^ =>
        "June".string()

    
primitive July is MonthTrait

    fun apply(): U8 val =>
        6

    fun string(): String iso^ =>
        "July".string()

    
primitive August is MonthTrait

    fun apply(): U8 val =>
        7

    fun string(): String iso^ =>
        "August".string()

    
primitive September is MonthTrait

    fun apply(): U8 val =>
        8

    fun string(): String iso^ =>
        "September".string()

    
primitive October is MonthTrait

    fun apply(): U8 val =>
        9

    fun string(): String iso^ =>
        "October".string()

    
primitive November is MonthTrait

    fun apply(): U8 val =>
        10

    fun string(): String iso^ =>
        "November".string()

    fun box lt(that: Month): Bool val=>
        apply() < that.apply()


primitive December is MonthTrait

    fun apply(): U8 val =>
        11

    fun string(): String iso^ =>
        "December".string()
