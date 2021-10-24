using TDD
using Test

@testset "graph.jl" begin

    #=
    Example graph1:
    Undirected
    Explicit representation of self-connectivity
    Number of connected components: 3
    Connected components: [[1, 2, 3, 4, 5, 6], [7, 8, 9], [10, 11, 12]]
    Written from the graph picture in <https://www.baeldung.com/wp-content/uploads/sites/4/2020/05/3-component.png>.
    =#
    graph1 = [
        [1, 2, 3, 4],
        [2, 1, 3],
        [3, 1, 2, 5, 6],
        [4, 1, 5],
        [5, 3, 4],
        [6, 3],
        [7, 8, 9],
        [8, 7],
        [9, 7],
        [10, 11, 12],
        [11, 10],
        [12, 10]
    ]

    #=
    Example graph2:
    The same graph as graph2, EXCEPT that self-connectivity is NOT explicitly represented.
    =#
    graph2 = [
        [2, 3, 4],
        [1, 3],
        [1, 2, 5, 6],
        [1, 5],
        [3, 4],
        [3],
        [8, 9],
        [7],
        [7],
        [11, 12],
        [10],
        [10]
    ]

    #=
    Example graph3:
    Modified from graph2.
    A few directed connections are removed to make the graph a DIRECTED graph.
    A directed connection is added which projects from node 9 to node 11, SO THAT connected components [7, 8, 9] and [10, 11, 12] are JOINTED.
    Thus, number of connected components == 2.
    =#
    graph3 = [
        [2, 4],
        [1],
        [1, 2, 6],
        [5],
        [3],
        [3],
        [8],
        [7],
        [7, 11],
        [11, 12],
        [],
        [10]
    ]

    @testset "Q1" begin
        
        @test direct_neighbors(graph1, 1) == [2, 3, 4]
        @test direct_neighbors(graph1, 2) == [1, 3]
        @test direct_neighbors(graph2, 3) == direct_neighbors(graph1, 3)
        @test direct_neighbors(graph2, 4) == direct_neighbors(graph1, 4)
        @test direct_neighbors(graph3, 3) == [1, 2, 6]
        @test direct_neighbors(graph3, 4) == [5]
        @test direct_neighbors(graph3, 5) == [3]

    end

    @testset "Q2" begin
        
        @test reachable_nodes(graph1, 1) == [2, 3, 4, 5, 6]
        @test reachable_nodes(graph1, 7) == [8, 9]
        @test reachable_nodes(graph1, 11) == [10, 12]
        @test reachable_nodes(graph2, 4) == @test reachable_nodes(graph1, 4)
        @test reachable_nodes(graph2, 8) == @test reachable_nodes(graph1, 8)
        @test reachable_nodes(graph2, 12) == @test reachable_nodes(graph1, 12)
        @test reachable_nodes(graph3, 2) == [1, 3, 4, 5, 6]
        @test reachable_nodes(graph3, 8) == [7]
        @test reachable_nodes(graph3, 9) == [7, 8, 11]
        @test reachable_nodes(graph3, 11) == []

    end
end