module Day12

using AdventOfCode2022

function day12(input::String = readInput(joinpath(@__DIR__, "..", "data", "day12.txt")))
    startindex, endindex, heightmap = parse_input(input)
    revcosts = reverse_costs(endindex, heightmap)
    p1 = revcosts[startindex]
    p2 = revcosts[findall(x -> x == 0, heightmap)] |> minimum
    return [p1, p2]
end

function reverse_costs(endindex::CartesianIndex{2}, heightmap::Matrix{Int})
    costs = fill(prod(size(heightmap)), size(heightmap))
    costs[endindex] = 0
    visited = zeros(Bool, size(heightmap))
    visited[endindex] = true
    queue = [endindex]
    while !isempty(queue)
        current = popfirst!(queue)
        neighb = neighbours(current, size(heightmap)...)
        for neigh ∈ neighb
            if !visited[neigh] && heightmap[current] - heightmap[neigh] <= 1
                push!(queue, neigh)
                costs[neigh] = costs[current] + 1
                visited[neigh] = true
            end
        end
    end
    return costs
end

function neighbours(index::CartesianIndex{2}, M::Int, N::Int)
    neighb = CartesianIndex{2}[]
    i, j = index.I
    i - 1 >= 1 && push!(neighb, CartesianIndex(i - 1, j))
    j - 1 >= 1 && push!(neighb, CartesianIndex(i, j - 1))
    i + 1 <= M && push!(neighb, CartesianIndex(i + 1, j))
    j + 1 <= N && push!(neighb, CartesianIndex(i, j + 1))
    return neighb
end

function parse_input(input::AbstractString)
    heightmap = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    startindex = findfirst(x -> x == 'S', heightmap)
    endindex = findfirst(x -> x == 'E', heightmap)
    replace!(heightmap, 'S' => 'a', 'E' => 'z')
    return startindex, endindex, heightmap .- 'a'
end

end # module
