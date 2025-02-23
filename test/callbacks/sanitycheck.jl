
include("../imports.jl")


@testset ExtendedTestSet "`SanityCheck`" begin


    @testset ExtendedTestSet "Checks pass" begin
        cb = SanityCheck()
        learner = testlearner(cb)
        @test_nowarn fit!(learner, 1)
    end



    @testset ExtendedTestSet "No training iterator" begin
        cb = SanityCheck([CHECKS[1]], usedefault = false)
        learner = testlearner(cb)
        @test_nowarn fit!(learner, 1)
        cb = SanityCheck([CHECKS[3]], usedefault = false)
        learner = testlearner(cb)
        learner.data.training = nothing
        @test_throws Exception (@suppress fit!(learner, 1))
    end

    @testset ExtendedTestSet "Iterators over tuples" begin
        cb = SanityCheck([CHECKS[3]], usedefault = false)
        learner = testlearner(cb)
        @test_nowarn fit!(learner, 1)

        cb = SanityCheck([CHECKS[3]], usedefault = false)
        learner = testlearner(cb)
        learner.data.training = 1:16
        @test_throws SanityCheckException (@suppress fit!(learner, 1))
    end
@testset ExtendedTestSet "Optimization step" begin
        cb = SanityCheck([CHECKS[4]], usedefault = false)
        learner = testlearner(cb)
        @test_nowarn fit!(learner, 1)

        cb = SanityCheck([CHECKS[4]], usedefault = false)
        learner = testlearner(cb)
        learner.model = x -> "hi"
        @test_throws SanityCheckException (@suppress fit!(learner, 1))

        cb = SanityCheck([CHECKS[4]], usedefault = false)
        learner = testlearner(cb)
        learner.model = x -> "hi"
        @test_throws SanityCheckException (@suppress fit!(learner, 1))

        cb = SanityCheck([CHECKS[4]], usedefault = false)
        learner = testlearner(cb)
        learner.lossfn = x -> true
        @test_throws SanityCheckException (@suppress fit!(learner, 1))
    end
end
