module Day09

using AdventOfCode2022

function day09(input::String = readInput(joinpath(@__DIR__, "..", "data", "day09.txt")))
    data = map(x -> (x[1][1], parse(Int, x[2])), split.(eachsplit(rstrip(input), "\n")))
    return [solve(data, 2), solve(data, 10)]
end

function solve(data::Vector{Tuple{Char,Int}}, nknots::Int)
    visited = Set{Tuple{Int,Int}}()
    coordinates = [[0, 0] for _ = 1:nknots]
    push!(visited, (0, 0))
    for (dir, nsteps) ∈ data
        for _ = 1:nsteps
            coordinates[1] .= move_head(dir, coordinates[1]...)
            for k = 2:length(coordinates)
                coordinates[k] .= move_tail(coordinates[k-1]..., coordinates[k]...)
            end
            push!(visited, (coordinates[end][1], coordinates[end][2]))
        end
    end
    visited |> length
end

function move_head(dir::Char, i::Int, j::Int)
    dir == 'D' && return i + 1, j
    dir == 'U' && return i - 1, j
    dir == 'R' && return i, j + 1
    dir == 'L' && return i, j - 1
end

function move_tail(ih::Int, jh::Int, it::Int, jt::Int)
    di = ih - it
    dj = jh - jt
    stepi = (di >= 0 ? 1 : -1)
    stepj = (dj >= 0 ? 1 : -1)
    if abs(di) >= 2
        it += stepi
        if abs(dj) >= 1
            jt += stepj
        end
    elseif abs(dj) >= 2
        jt += stepj
        if abs(di) >= 1
            it += stepi
        end
    end
    return it, jt
end

end # module
