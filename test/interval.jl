using TDD
using Test

@testset "interval.jl" begin
    
    @testset "Q1" begin
        iv1 = Interval(-5.34, 9.78)
        @test minimum(iv1) == -5.34
        @test maximum(iv1) == 9.78
    end
end