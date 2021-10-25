export direct_neighbors
export reachable_nodes

function direct_neighbors(graph::Union{Vector{Vector{Int64}},Vector{Vector{Any}}}, st_node::Int64)

    return filter(node -> node != st_node, graph[st_node])

end

function reachable_nodes(graph::Union{Vector{Vector{Int64}},Vector{Vector{Any}}}, st_node::Int64)

    graphcopy = copy(graph)
    if isempty(direct_neighbors(graph, st_node))
        return []
    else
        RNs = direct_neighbors(graphcopy, st_node)
        graphcopy[st_node] = []
        for node in eachindex(graphcopy)
            graphcopy[node] = filter(n -> n != st_node, graphcopy[node])
        end
        for RN in RNs
            RNs = [RNs; reachable_nodes(graphcopy, RN)]
        end
        return sort(collect(Set{Int64}(RNs)))
    end

end