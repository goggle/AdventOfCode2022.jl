module Day23

using AdventOfCode2022

function day23(input::String = readInput(joinpath(@__DIR__, "..", "data", "day23.txt")))
    elvesmap = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    elves = Set(findall(x -> x == '#', elvesmap))

    for r ∈ 1:10
        elves, _ = round!(elves, r)
    end
    mini = minimum(x[1] for x ∈ elves)
    maxi = maximum(x[1] for x ∈ elves)
    minj = minimum(x[2] for x ∈ elves)
    maxj = maximum(x[2] for x ∈ elves)
    p1 = (maxi - mini + 1) * (maxj - minj + 1) - length(elves)

    p2 = 11
    while true
        _, moved = round!(elves, p2)
        !moved && break
        p2 += 1
    end

    return [p1, p2]
end

function Base.show(io::IO, M::Matrix{Char})
    for i ∈ axes(M, 1)
        println(join(M[i, :]))
    end
end

function round!(elves::Set{CartesianIndex{2}}, roundnumber::Int)
    dir = Dict(
        "NW" => CartesianIndex(-1, -1),
        "N" => CartesianIndex(-1, 0),
        "NE" => CartesianIndex(-1, 1),
        "E" => CartesianIndex(0, 1),
        "SE" => CartesianIndex(1, 1),
        "S" => CartesianIndex(1, 0),
        "SW" => CartesianIndex(1, -1),
        "W" => CartesianIndex(0, -1),
    )
    order = Dict(
        1 => ("N", "NE", "NW"),
        2 => ("S", "SE", "SW"),
        3 => ("W", "NW", "SW"),
        4 => ("E", "NE", "SE"),
    )

    fromto = Dict{CartesianIndex{2}, CartesianIndex{2}}()
    for elf ∈ elves
        if considers_moving(elves, elf)
            for i ∈ mod1.(roundnumber:roundnumber+3, 4)
                if elf + dir[order[i][1]] ∉ elves && elf + dir[order[i][2]] ∉ elves && elf + dir[order[i][3]] ∉ elves
                    fromto[elf] = elf + dir[order[i][1]]
                    break
                end
            end
        end
    end

    nmoves = 0
    for (from, to) ∈ fromto
        if to ∈ elves
            push!(elves, to + to - from)
            delete!(elves, to)
            nmoves -= 1
        else
            push!(elves, to)
            delete!(elves, from)
            nmoves += 1
        end
    end

    return elves, nmoves > 0
end

function considers_moving(s::Set{CartesianIndex{2}}, c::CartesianIndex{2})
    c + CartesianIndex(-1, -1) ∈ s && return true
    c + CartesianIndex(-1, 0) ∈ s && return true
    c + CartesianIndex(-1, 1) ∈ s && return true
    c + CartesianIndex(0, -1) ∈ s && return true
    c + CartesianIndex(0, 1) ∈ s && return true
    c + CartesianIndex(1, -1) ∈ s && return true
    c + CartesianIndex(1, 0) ∈ s && return true
    c + CartesianIndex(1, 1) ∈ s && return true
    return false
end

end # module
