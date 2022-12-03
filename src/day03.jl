module Day03

using AdventOfCode2022

function day03(input::String = readInput(joinpath(@__DIR__, "..", "data", "day03.txt")))
    data = split(rstrip(input), "\n")
    citems_p1 = [intersect(s[1:length(s)÷2], s[length(s)÷2+1:end])[1] for s ∈ data]
    citems_p2 = [intersect(data[i:i+2]...)[1] for i ∈ 1:3:length(data)]
    return [score.(citems_p1) |> sum, score.(citems_p2) |> sum]
end

function score(item::Char)
    islowercase(item) && return item - 'a' + 1
    return item - 'A' + 27
end

end # module
