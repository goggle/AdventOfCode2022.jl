module Day01

using AdventOfCode2022

function day01(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    sums = [parse.(Int, eachsplit(x)) |> sum for x in eachsplit(input, "\n\n")]
    partialsort!(sums, 1:3, rev=true)
    return [sums[1], sums[1:3] |> sum]
end

end # module
