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

    iv3 = Interval(-5.34, 9.78) # The same interval as iv1
    iv4 = Interval(-5, 9) # Sub-interval of iv1
    iv5 = Interval(-6, 9) # Not a sub-interval of iv1
    iv6 = Interval(-7, 10) # Not a sub-interval of iv1
    iv7 = Interval(9,-10) # Another empty closed interval

    @testset "Q4" begin
        @test iv2 ⊆ iv1 # An empty interval should be the sub-interval of any interval
        @test iv2 ⊆ iv7 # An empty interval is also a sub-interval of any empty interval
        @test iv3 ⊆ iv1 # An interval is a sub-interval of itself
        @test iv4 ⊆ iv1
        @test !(iv5 ⊆ iv1)
        @test !(iv6 ⊆ iv1) 
    end

    iv8 = Interval(10, 100)

    @testset "Q5" begin
        @test isempty(iv2 ∩ iv1)
        @test isempty(iv2 ∩ iv7)
        @test iv1 ∩ iv3 == iv1
        @test iv4 ∩ iv1 == iv4
        @test iv5 ∩ iv1 == Interval(-5.34,9)
        @test iv6 ∩ iv1 == iv1
        @test isempty(iv1 ∩ iv8)
    end

    @testset "Q6" begin
        show(iv1)
        show(iv2)
    end

end