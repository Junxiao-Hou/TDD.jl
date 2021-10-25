export direct_neighbors
export reachable_nodes
export connected_components

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
            RNs = union(RNs, reachable_nodes(graphcopy, RN))
        end
        return sort(RNs)
    end

end

function connected_components(graph::Union{Vector{Vector{Int64}},Vector{Vector{Any}}})

    CCs = []
    for node in eachindex(graph)
        RNs = sort([reachable_nodes(graph, node);[node]])
        if !(RNs in CCs)
            overlap = false
            for i in eachindex(CCs)
                if !isempty(intersect(CCs[i], RNs))
                    overlap = true
                    CCs[i] = sort(union(CCs[i], RNs))
                    break
                end
            end
            if overlap == false
                push!(CCs, RNs)
            end
        end
    end
    return Vector{Vector{Int64}}(CCs)

end