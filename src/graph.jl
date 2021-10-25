export direct_neighbors
export reachable_nodes
export connected_components

function direct_neighbors(graph::Union{Vector{Vector{Int64}},Vector{Vector{Any}}}, st_node::Int64)

    return filter(node -> node != st_node, graph[st_node])

end

function direct_neighbors(AM::Matrix{Bool}, st_node::Int64)

    DNs = filter(!iszero, AM[st_node,:].*(1:size(AM,2)))
    return filter(node -> node != st_node, DNs)

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

function reachable_nodes(AM::Matrix{Bool}, st_node::Int64)

    AMcopy = copy(AM)
    if isempty(direct_neighbors(AM, st_node))
        return []
    else
        RNs = direct_neighbors(AMcopy, st_node)
        AMcopy[st_node,:] = falses(size(AMcopy,2))
        AMcopy[:, st_node] = falses(size(AMcopy,1),1)
        for RN in RNs
            RNs = union(RNs, reachable_nodes(AMcopy, RN))
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

function connected_components(AM::Matrix{Bool})

    CCs = []
    for node in 1:size(AM,1)
        RNs = sort([reachable_nodes(AM, node);[node]])
        @show RNs
        if !(RNs in CCs)
            overlap = false
            for i in eachindex(CCs)
                if !isempty(intersect(CCs[i], RNs))
                    overlap = true
                    CCs[i] = sort(union(CCs[i], RNs))
                    @show CCs
                    break
                end
            end
            if overlap == false
                push!(CCs, RNs)
                @show CCs
            end
        end
    end
    return Vector{Vector{Int64}}(CCs)

end