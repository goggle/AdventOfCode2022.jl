module Day24

using AdventOfCode2022

function day24(input::String = readInput(joinpath(@__DIR__, "..", "data", "day24.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))

    # Additional assumption:
    # The starting point and goal point never contains a blizzard.
    ground = map(x -> x.I, findall(x -> x ∈ ('.', '>', '<', '^', 'v'), data)) |> Set
    start = (1, 2)
    goal = (size(data, 1), size(data, 2) - 1)
    cycle = lcm(size(data, 1) - 2, size(data, 2) - 2)

    # Precompute free points:
    up = map(x -> x.I, findall(x -> x == '^', data))
    down = map(x -> x.I, findall(x -> x == 'v', data))
    left = map(x -> x.I, findall(x -> x == '<', data))
    right = map(x -> x.I, findall(x -> x == '>', data))
    available_points = Dict{Int, Set{Tuple{Int, Int}}}()
    available_points[0] = setdiff(ground, union(up, down, left, right))
    for r ∈ 1:cycle-1
        for i ∈ axes(up, 1)
            up[i] = (mod1(up[i][1] - 1 - 1, size(data, 1) - 2) + 1, up[i][2])
        end
        for i ∈ axes(down, 1)
            down[i] = (mod1(down[i][1] + 1 - 1, size(data, 1) - 2) + 1, down[i][2])
        end
        for i ∈ axes(left, 1)
            left[i] = (left[i][1], mod1(left[i][2] - 1 - 1, size(data, 2) - 2) + 1)
        end
        for i ∈ axes(right, 1)
            right[i] = (right[i][1], mod1(right[i][2] + 1 - 1, size(data, 2) - 2) + 1)
        end
        available_points[r] = setdiff(ground, union(up, down, left, right))
    end

    p1 = solve(start, goal, available_points, 0, cycle)

    p22 = solve(goal, start, available_points, p1, cycle)
    p23 = solve(start, goal, available_points, p1 + p22, cycle)
    return [p1, p1 + p22 + p23]
end

function solve(start::Tuple{Int, Int}, goal::Tuple{Int, Int}, available::Dict{Int, Set{Tuple{Int, Int}}}, starttime::Int, cycle::Int)
    reachable_after = Dict{Int, Set{Tuple{Int, Int}}}()
    reachable_after[starttime] = Set([start])
    r = starttime + 1
    while true
        reachable_after[r] = Set{Tuple{Int, Int}}()
        for point ∈ reachable_after[r-1]
            point == goal && return r - 1 - starttime
            if point ∈ available[mod(r, cycle)]
                push!(reachable_after[r], point)
            end
            if (point[1] + 1, point[2]) ∈ available[mod(r, cycle)]
                push!(reachable_after[r], (point[1] + 1, point[2]))
            end
            if (point[1], point[2] + 1) ∈ available[mod(r, cycle)]
                push!(reachable_after[r], (point[1], point[2] + 1))
            end
            if (point[1] - 1, point[2]) ∈ available[mod(r, cycle)]
                push!(reachable_after[r], (point[1] - 1, point[2]))
            end
            if (point[1], point[2] - 1) ∈ available[mod(r, cycle)]
                push!(reachable_after[r], (point[1], point[2] - 1))
            end
        end
        r += 1
    end
end


end # module
