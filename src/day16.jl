module Day16

using AdventOfCode2022
using DataStructures

function day16(input::String = readInput(joinpath(@__DIR__, "..", "data", "day16.txt")))
    valves, flows, startidx = parse_input(input)
    walking_dists = walking_distances(valves)
    positive_flow_mask = flows .> 0
    dists = walking_dists[positive_flow_mask, positive_flow_mask]
    p1, _ = part1(walking_dists, positive_flow_mask, dists, flows, startidx, 30, Set{UInt8}(1:count(flows .> 0)), Dict{Int, Int}())

    p2 = 0
    _, scores = part1(walking_dists, positive_flow_mask, dists, flows, startidx, 26, Set{UInt8}(1:count(flows .> 0)), Dict{Int, Int}(); store_scores = true)
    test_value = p1 ÷ 2
    for (k1, v1) ∈ scores
        v1 < test_value && continue
        for (k2, v2) ∈ scores
            if k1 & k2 == 0  # set of opened valve indices are disjoint
                if p2 < v1 + v2
                    p2 = v1 + v2
                end
            end
        end
    end
    return [p1, p2]
end

function part1(walking_dists::Matrix{Int}, positive_flow_mask::BitVector, dists::Matrix{Int}, flows::Vector{Int}, startidx::Int, starttime::Int, available::Set{UInt8}, scores::Dict{Int, Int}; store_scores = false)
    q = Deque{Tuple{Int, Int, Int, Set{UInt8}}}()

    # Initialization of the search: Walk to all the valves with positive pressure
    # release, open them, and add these states to the queue.
    for i ∈ findall(flows .> 0)
        idx = (flows.>0)[1:i] |> sum
        idx ∉ available && continue
        time_left = starttime - walking_dists[startidx, i] - 1
        score = time_left * flows[i]
        open_idx = Set{UInt8}(idx)
        push!(q, (time_left, score, idx, open_idx))
    end

    max_score = 0
    while !isempty(q)
        time_left, score, idx, open_idx = popfirst!(q)

        if store_scores
            # Generate a key from the set of opened valve indices that can
            # be used to store the best score for this configuration in
            # a dictionary (only needed for part 2).
            key = 0
            for j ∈ open_idx
                key += 1 << j
            end
            if haskey(scores, key)
                if score > scores[key]
                    scores[key] = score
                end
            else
                scores[key] = score
            end
        end

        if score > max_score
            max_score = score
        end

        # Some pruning: If we certainly won't reach a better score than the
        # current best score, do not investigate further branches.
        sc = score
        for i ∈ setdiff(available, open_idx) |> collect
            tl = time_left - dists[idx, i] - 1
            tl <= 0 && continue
            sc += tl * flows[positive_flow_mask][i]
        end
        sc < max_score && continue

        # Choose next valve to open and add these new states to the queue.
        for i ∈ axes(dists, 1)
            (i ∈ open_idx || i ∉ available) && continue
            tl = time_left - dists[idx, i] - 1
            tl <= 0 && continue
            sc = score + tl * flows[positive_flow_mask][i]
            opidx = copy(open_idx)
            push!(opidx, UInt8(i))
            push!(q, (tl, sc, i, opidx))
        end
    end
    return max_score, scores
end

function walking_distances(valves::Dict{Int, Vector{Int}})
    # Calculates the walking distances between the valves by using
    # the Floyd–Warshall algorithm (https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm)
    n = length(valves)
    dist = fill(10_000, n, n)
    for (k, destinations) ∈ valves
        for dest ∈ destinations
            dist[k, dest] = 1
        end
    end
    for k ∈ 1:n
        dist[k, k] = 0
    end
    for k ∈ 1:n
        for i ∈ 1:n
            for j ∈ 1:n
                if dist[i, j] > dist[i, k] + dist[k, j]
                    dist[i, j] = dist[i, k] + dist[k, j]
                end
            end
        end
    end
    return dist
end

function parse_input(input::AbstractString)
    flows = Vector{Int}()
    valves = Dict{String, Vector{String}}()
    r = r"Valve\s(\w{2})\shas\sflow\srate=(\d+);\stunnels?\sleads?\sto\svalves?\s(.+)$"
    links = Dict{String, Int}()
    for (i, line) in enumerate(eachsplit(rstrip(input), "\n"))
        m = match(r, line)
        push!(flows, parse(Int, m.captures[2]))
        valve = m.captures[1]
        connections = strip.(split(m.captures[3]), ',')
        valves[valve] = connections
        links[valve] = i
    end

    graph = Dict{Int, Vector{Int}}()
    for (key, v) ∈ valves
        graph[links[key]] = [links[vi] for vi ∈ v]
    end
    return graph, flows, links["AA"]
end

end # module
