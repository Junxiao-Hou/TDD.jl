export direct_neighbors

function direct_neighbors(graph::Union{Vector{Vector{Int64}},Vector{Vector{Any}}}, st_node::Int64)

    return filter(node -> node != st_node, graph[st_node])

end