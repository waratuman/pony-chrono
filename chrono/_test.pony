use "logger"
use "ponytest"

actor Main is TestList
    
    new create(env: Env) =>
        PonyTest(env, this)

    fun tag tests(test: PonyTest) =>
        DateTestList.make().tests(test)
        TimeTestList.make().tests(test)
