module Day22

using AdventOfCode2022

function day22(input::String = readInput(joinpath(@__DIR__, "..", "data", "day22.txt")))
    mapdata, instructions = parse_input(input)
    next_idx = Dict{Int, Matrix{Int}}()
    for k ∈ 0:3
        next_idx[k] = next_index_map(mapdata, k)
    end
    direction_change = deepcopy(next_idx)
    for k ∈ 0:3
        direction_change[k] .= -1
    end
    p1 = solve(mapdata, next_idx, direction_change, instructions)

    nrows = size(mapdata, 1)
    boarders = Dict(
        1 => to1d.(1, 51:100, nrows),
        2 => to1d.(1, 101:150, nrows),
        3 => to1d.(1:50, 150, nrows),
        4 => to1d.(50, 101:150, nrows),
        5 => to1d.(51:100, 100, nrows),
        6 => to1d.(101:150, 100, nrows),
        7 => to1d.(150, 51:100, nrows),
        8 => to1d.(151:200, 50, nrows),
        9 => to1d.(200, 1:50, nrows),
        10 => to1d.(151:200, 1, nrows),
        11 => to1d.(101:150, 1, nrows),
        12 => to1d.(101, 1:50, nrows),
        13 => to1d.(51:100, 51, nrows),
        14 => to1d.(1:50, 51, nrows),
    )
    connections = Dict(
        1 => (10, true, 3, 0),
        2 => (9, true, 3, 3),
        3 => (6, false, 0, 2),
        4 => (5, true, 1, 2),
        5 => (4, true, 0, 3),
        6 => (3, false, 0, 2),
        7 => (8, true, 1, 2),
        8 => (7, true, 0, 3),
        9 => (2, true, 1, 1),
        10 => (1, true, 2, 1),
        11 => (14, false, 2, 0),
        12 => (13, true, 3, 0),
        13 => (12, true, 2, 1),
        14 => (11, false, 2, 0),
    )

    for (k, (v, orientation, dirstart, dirend)) ∈ connections
        if orientation
            next_idx[dirstart][boarders[k]] .= boarders[v]
        else
            next_idx[dirstart][boarders[k]] .= reverse(boarders[v])
        end
        direction_change[dirstart][boarders[k]] .= dirend
    end
    p2 = solve(mapdata, next_idx, direction_change, instructions)

    return [p1, p2]
end

function solve(mapdata::Matrix{Char}, next_idx::Dict{Int, Matrix{Int}}, direction_change::Dict{Int, Matrix{Int}}, instructions::Vector{Any})
    ind = to1d(1, findfirst(x -> x == '.', mapdata[1, :]), size(mapdata, 1))
    dir = 0
    for instruction ∈ instructions
        if isa(instruction, Number)
            for _ ∈ 1:instruction
                l = next_idx[dir][ind]
                mapdata[l] == '#' && break
                ind = l
                if direction_change[dir][ind] != -1
                    dir = direction_change[dir][ind]
                end
            end
        elseif instruction == 'L'
            dir = turn_left(dir)
        elseif instruction == 'R'
            dir = turn_right(dir)
        end
    end
    i, j = to2d(ind, size(mapdata, 1))
    return 1000 * i + 4 * j + dir
end

turn_right(dir::Int) = mod(dir + 1, 4)
turn_left(dir::Int) = mod(dir - 1, 4)
to1d(i::Int, j::Int, nrows::Int) = (j - 1) * nrows + i
to2d(ind::Int, nrows::Int) = mod1(ind, nrows), ind ÷ nrows + 1

function next_index_map(mapdata::Matrix{Char}, dir::Int)
    dir2c = Dict(0 => (0, 1), 1 => (1, 0), 2 => (0, -1), 3 => (-1, 0))
    indexmap = zeros(Int, size(mapdata))
    for i ∈ axes(mapdata, 1)
        for j ∈ axes(mapdata, 2)
            if mapdata[i, j] != ' '
                x, y = i, j
                while true
                    x = mod1(x + dir2c[dir][1], size(mapdata, 1))
                    y = mod1(y + dir2c[dir][2], size(mapdata, 2))
                    if mapdata[x, y] != ' '
                        indexmap[i, j] = to1d(x, y, size(mapdata, 1))
                        break
                    end
                end
            end
        end
    end
    return indexmap
end

function parse_input(input::AbstractString)
    m, instr = split(rstrip(input), "\n\n")
    lines = split(m, "\n")
    nrows = length(lines)
    ncols = maximum(length(rstrip(x)) for x ∈ lines)
    mapdata = fill(' ', nrows, ncols)
    for (i, line) ∈ enumerate(lines)
        for (j, c) ∈ enumerate(line)
            mapdata[i, j] = c
        end
    end

    instructions = []
    for r ∈ findall(r"(\d+|R|L)", instr)
        inst = tryparse(Int, instr[r])
        if inst === nothing
            push!(instructions, instr[r][1])
        else
            push!(instructions, inst)
        end
    end

    return mapdata, instructions
end

end # module
