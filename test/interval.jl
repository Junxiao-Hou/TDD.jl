using TDD
using Test

@testset "interval.jl" begin
    
    iv1 = Interval(-5.34, 9.78) # A non-empty closed interval
    
    @testset "Q1" begin
        @test minimum(iv1) == -5.34
        @test maximum(iv1) == 9.78
    end

    @testset "Q2" begin
        @test 0 ∈ iv1
        @test -5.34 ∈ iv1
        @test 9.78 ∈ iv1
        @test ! (-5.35 ∈ iv1)
        @test ! (9.79 ∈ iv1)
    end

    iv2 = Interval(9.78,-5.34) # An empty closed interval

    @testset "Q3" begin
        @test !isempty(iv1)
        @test isempty(iv2)
    end
end