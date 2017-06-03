use "format"
use "ponytest"

actor TimeTestList is TestList

    new create(env: Env) =>
        PonyTest(env, this)

    new make() =>
        None
    
    fun tag tests(test: PonyTest) =>
        test(_TestTimeCreate)
        test(_TestTimeCivil)
        

class _TestTimeCreate is UnitTest

    fun name(): String =>
        "Time.create"
    
    fun tag apply(h: TestHelper) =>
        var time = Time.create(0)
        h.assert_eq[USize](time.hour(), 0)
        h.assert_eq[USize](time.min(), 0)
        h.assert_eq[USize](time.sec(), 0)
        h.assert_eq[U64](time.nsec(), 0)
        h.assert_eq[U64](time.u64(), 0)

        time = Time.create(43_200_000_000_000)
        h.assert_eq[USize](time.hour(), 12)
        h.assert_eq[USize](time.min(), 0)
        h.assert_eq[USize](time.sec(), 0)
        h.assert_eq[U64](time.nsec(), 0)
        h.assert_eq[U64](time.u64(), 43_200_000_000_000)

        time = Time.create(86_400_000_000_000)
        h.assert_eq[USize](time.hour(), 0)
        h.assert_eq[USize](time.min(), 0)
        h.assert_eq[USize](time.sec(), 0)
        h.assert_eq[U64](time.nsec(), 0)
        h.assert_eq[U64](time.u64(), 86_400_000_000_000)


class _TestTimeCivil is UnitTest

    fun name(): String =>
        "Time.civil"
    
    fun tag apply(h: TestHelper) =>
        var time = Time.civil()
        h.assert_eq[USize](time.hour(), 0)
        h.assert_eq[USize](time.min(), 0)
        h.assert_eq[USize](time.sec(), 0)
        h.assert_eq[U64](time.nsec(), 0)
        h.assert_eq[U64](time.u64(), 0)

        time = Time.civil(12)
        h.assert_eq[USize](time.hour(), 12)
        h.assert_eq[USize](time.min(), 0)
        h.assert_eq[USize](time.sec(), 0)
        h.assert_eq[U64](time.nsec(), 0)
        h.assert_eq[U64](time.u64(), 43_200_000_000_000)

        time = Time.civil(24, 0, 0)
        h.assert_eq[USize](time.hour(), 0)
        h.assert_eq[USize](time.min(), 0)
        h.assert_eq[USize](time.sec(), 0)
        h.assert_eq[U64](time.nsec(), 0)
        h.assert_eq[U64](time.u64(), 86_400_000_000_000)