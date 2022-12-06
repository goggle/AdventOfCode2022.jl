module Day06

using AdventOfCode2022

function day06(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    return [findfirst(marker(input, i, k) for i=1:length(input)-k+1) + k - 1 for k ∈ (4, 14)]
end

marker(s::AbstractString, i::Int, l::Int) = (s[i:i+l-1] |> unique |> length) == l

end # module
