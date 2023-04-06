module Day14

using AdventOfCode2022
using DataStructures

function day14(input::String = readInput(joinpath(@__DIR__, "..", "data", "day14.txt")))
    walls, maxy = parse_input(input)
    return [solve!(deepcopy(walls), maxy), solve!(walls, maxy; part1 = false)]
end

function solve!(walls::DefaultDict{Tuple{Int, Int}, Bool}, maxy::Int; part1 = true)
    total_sand = 0
    while add_sand!(walls, maxy; part1 = part1)
        total_sand += 1
    end
    return total_sand
end

function is_wall(walls::DefaultDict{Tuple{Int, Int}, Bool}, x::Int, y::Int, maxy::Int; part1 = true)
    part1 && return walls[x, y]
    return (y == maxy + 2 || walls[x, y])
end

function add_sand!(walls::DefaultDict{Tuple{Int, Int}, Bool}, maxy::Int; part1 = true)
    x, y = 500, 0
    !part1 && is_wall(walls, x, y, maxy; part1 = false) && return false
    while true
        res, x, y = move_sand!(walls, maxy, x, y; part1 = part1)
        y > maxy && part1 && return false
        !res && break
    end
    return true
end

function move_sand!(walls::DefaultDict{Tuple{Int, Int}, Bool}, maxy::Int, x::Int, y::Int; part1 = true)
    if !is_wall(walls, x, y + 1, maxy; part1 = part1)
        return true, x, y + 1
    elseif !is_wall(walls, x - 1, y + 1, maxy; part1 = part1)
        return true, x - 1, y + 1
    elseif !is_wall(walls, x + 1, y + 1, maxy; part1 = part1)
        return true, x + 1, y + 1
    end
    walls[x, y] = true
    return false, x, y
end

function parse_input(input::AbstractString)
    data = map.(x -> (parse(Int, x[1]), parse(Int, x[2])), map.(x -> split(x, ","), split.(split(rstrip(input), "\n"), " -> ")))
    walls = DefaultDict{Tuple{Int, Int}, Bool}(false)
    maxy = 0
    for line ∈ data
        for i ∈ 1:length(line)-1
            x1, x2 = minmax(line[i][1], line[i+1][1])
            y1, y2 = minmax(line[i][2], line[i+1][2])
            if y2 > maxy
                maxy = y2
            end
            if x1 < x2
                for i ∈ x1:x2
                    walls[(i, y1)] = true
                end
            else
                for j ∈ y1:y2
                    walls[(x1, j)] = true
                end
            end
        end
    end
    return walls, maxy
end

end # module
