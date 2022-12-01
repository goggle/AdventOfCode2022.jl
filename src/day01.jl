module Day01

using AdventOfCode2022

function day01(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    data = parse_input(input)
    sorted_sums = map(x -> sum(x), data) |> sort
    p1 = sorted_sums[end]
    p2 = sorted_sums[end-2:end] |> sum
    return [p1, p2]
end

function parse_input(input::AbstractString)
    sinput = split(rstrip(input), "\n")
    loc = findall(isempty, sinput)
    grouped = getindex.(Ref(sinput), UnitRange.([1; loc .+ 1], [loc .- 1; length(sinput)]))
    return [parse.(Int, g) for g in grouped]
end

end # module
