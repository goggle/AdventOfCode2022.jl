module Day10

using AdventOfCode2022

function day10(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    data = map(x -> length(x) == 2 ? (String(x[1]), parse(Int, x[2])) : (String(x[1]), 0), split.(eachsplit(rstrip(input), "\n")))
    d = collect_values(data)
    p1 = sum(d[x] * x for x ∈ (20 + 40 * k for k ∈ 0:5))
    p2 = part2(d)
    return [p1, p2 |> permutedims |> generate_image]
end

function collect_values(data::Vector{Tuple{String, Int}})
    d = Dict{Int, Int}()
    x = 1
    cycle = 0
    d[0] = 1
    for (command, value) ∈ data
        if command == "noop"
            d[cycle+1] = x
            cycle += 1
        else
            d[cycle+1] = x
            d[cycle+2] = x
            cycle += 2
            x += value
        end
    end
    return d
end

function part2(d::Dict{Int, Int})
    image = fill('.', 6, 40)
    for cycle ∈ 1:240
        if mod1(cycle, 40) ∈ d[cycle]:d[cycle]+2
            image[postoind(cycle)...] = '#'
        else
            image[postoind(cycle)...] = '.'
        end
    end
    return image
end

postoind(pos::Int) = (pos - 1) ÷ 40 + 1, mod1(pos, 40)

end # module
