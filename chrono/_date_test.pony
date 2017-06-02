use "format"
use "ponytest"

actor DateTestList is TestList

    new create(env: Env) =>
        PonyTest(env, this)

    new make() =>
        None
    
    fun tag tests(test: PonyTest) =>
        test(_TestDateCivil)
        test(_TestDateCreate)
        test(_TestDateWeekday)
        

class _TestDateCivil is UnitTest

    fun name(): String =>
        "Date.civil"
    
    fun tag apply(h: TestHelper) =>
        var date = Date.civil(1970, 1, 1)
        h.assert_eq[I64](date.days_since_epoch(), 0)
        h.assert_eq[I32](date.year, 1970)
        h.assert_eq[Month](date.month, January)
        h.assert_eq[U8](date.day, 1)
        
        date = Date.civil(I32.min_value(), 1, 1)
        h.assert_eq[I64](date.days_since_epoch(), -784353015833)
        h.assert_eq[I32](date.year, I32.min_value())
        h.assert_eq[Month](date.month, January)
        h.assert_eq[U8](date.day, 1)

        date = Date.civil(I32.max_value(), 12, 31)
        h.assert_eq[I64](date.days_since_epoch(), 784351576776)
        h.assert_eq[I32](date.year, I32.max_value())
        h.assert_eq[Month](date.month, December)
        h.assert_eq[U8](date.day, 31)



class _TestDateCreate is UnitTest

    fun name(): String =>
        "Date.create"
    
    fun tag apply(h: TestHelper) ? =>
        var date = Date(0)
        h.assert_eq[I64](date.days_since_epoch(), 0)
        h.assert_eq[I32](date.year, 1970)
        h.assert_eq[Month](date.month, January)
        h.assert_eq[U8](date.day, 1)
        
        date = Date(-784353015833)
        h.assert_eq[I64](date.days_since_epoch(), -784353015833)
        h.assert_eq[I32](date.year, I32.min_value())
        h.assert_eq[Month](date.month, January)
        h.assert_eq[U8](date.day, 1)

        date = Date(784351576776)
        h.assert_eq[I64](date.days_since_epoch(), 784351576776)
        h.assert_eq[I32](date.year, I32.max_value())
        h.assert_eq[Month](date.month, December)
        h.assert_eq[U8](date.day, 31)

        // let r: String val = recover
        //     let result: String ref = String
        //     result.append(date.era.string())
        //     result.append("\n")
        //     result.append(date.yoe.string())
        //     result.append("\n")
        //     result.append(date.doy.string())
        //     result.append("\n")
        //     result.append(date.doe.string())
        //     result.append("\n")
        //     result.append(date.dse.string())
        //     result.append("\n")
        //     result.append("\n")
        //     result.append(date.year.string())
        //     result.append("-")
        //     result.append(date.month.string())
        //     result.append("-")
        //     result.append(date.day.string())
        //     result
        // end
        // h.env.out.print(r)


class _TestDateWeekday is UnitTest

    fun name(): String =>
        "Date.iso_weekday"
    
    fun tag apply(h: TestHelper) ? =>
        var date = Date(0)
        h.assert_eq[Weekday](date.weekday(), Thursday)

        date = Date(-784353015833)
        h.assert_eq[Weekday](date.weekday(), Monday)

        date = Date(784351576776)
        h.assert_eq[Weekday](date.weekday(), Tuesday)

        // let r: String val = recover
        //     let result: String ref = String
        //     result.append(date.era.string())
        //     result.append("\n")
        //     result.append(date.yoe.string())
        //     result.append("\n")
        //     result.append(date.doy.string())
        //     result.append("\n")
        //     result.append(date.doe.string())
        //     result.append("\n")
        //     result.append(date.dse.string())
        //     result.append("\n")
        //     result.append("\n")
        //     result.append(date.year.string())
        //     result.append("-")
        //     result.append(date.month.string())
        //     result.append("-")
        //     result.append(date.day.string())
        //     result
        // end
        // h.env.out.print(r)

