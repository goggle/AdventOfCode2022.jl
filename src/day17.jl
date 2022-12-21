module Day17

using AdventOfCode2022

function day17(input::String = readInput(joinpath(@__DIR__, "..", "data", "day17.txt")))
    instructions = rstrip(input)
    shapes = (fill(true, 1, 4), Bool[0 1 0; 1 1 1; 0 1 0], Bool[0 0 1; 0 0 1; 1 1 1], fill(true, 4, 1), fill(true, 2, 2))
    diffs = part1(instructions, shapes, n=2500)
    p1 = sum(diffs[1:2022])
    cs = findall([all(diffs[101:101+200] .== diffs[i+100:i+100+200]) for i = 1:2200])
    cycle = cs[2] - cs[1]
    heightincrease = diffs[300:300+cycle] |> sum

    cycleadd = ((1_000_000_000_000 ÷ cycle) - 1) * heightincrease
    rest = mod(1_000_000_000_000, cycle) + cycle
    p2 = sum(diffs[1:rest]) + cycleadd

    return [p1, p2]
end

function part1(instructions::AbstractString, shapes::NTuple{5,Matrix{Bool}}; n=2022)
    board = zeros(Bool, n * 4, 7)
    board[end, :] .= true

    instri = 1
    shapei = 1

    diffs = zeros(Int, n)
    oldheighti = size(board, 1)
    for k ∈ 1:n
        shape = shapes[shapei]
        highest_i = highest_rock(board)
        i = (highest_i - 1) - 2 - size(shape, 1) - 1
        j = 2
        while true
            c = instructions[instri]
            instri = mod1(instri + 1, length(instructions))
            if c == '>'
                i, j, result = move_right(board, shape, i, j)
            else
                i, j, result = move_left(board, shape, i, j)
            end
            i, j, result = move_down(board, shape, i, j)
            if !result
                board[map(x -> x + CartesianIndex(i, j), findall(shape))] .= true
                newheighti = highest_rock(board)
                diffs[k] = oldheighti - newheighti
                oldheighti = newheighti
                break
            end
        end
        shapei = mod1(shapei + 1, length(shapes))
    end
    return diffs
end

highest_rock(b::Matrix{Bool}) = minimum(minimum(findall(b[:,i])) for i ∈ axes(b, 2))

function move_left(board::Matrix{Bool}, shape::Matrix{Bool}, i::Int, j::Int)
    occupied = map(x -> x + CartesianIndex(i, j - 1), findall(shape))
    (minimum(map(x -> x[2], occupied)) < 1 || any(board[occupied])) && return i, j, false
    return i, j - 1, true
end

function move_right(board::Matrix{Bool}, shape::Matrix{Bool}, i::Int, j::Int)
    occupied = map(x -> x + CartesianIndex(i, j + 1), findall(shape))
    (maximum(map(x -> x[2], occupied)) > 7 || any(board[occupied])) && return i, j, false
    return i, j + 1, true
end

function move_down(board::Matrix{Bool}, shape::Matrix{Bool}, i::Int, j::Int)
    occupied = map(x -> x + CartesianIndex(i + 1, j), findall(shape))
    any(board[occupied]) && return i, j, false
    return i + 1, j, true
end

end # module
