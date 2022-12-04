module Day04

using AdventOfCode2022

function day04(input::String = readInput(joinpath(@__DIR__, "..", "data", "day04.txt")))
    data = map(x -> parse.(Int, x), eachsplit.(eachsplit(input), r"\-|,"))
    return [count(nested(d...) for d ∈ data), count(inter(d...) for d ∈ data)]
end

nested(a::Int, b::Int, c::Int, d::Int) = intersect(a:b, c:d) ∈ (a:b, c:d)
inter(a::Int, b::Int, c::Int, d::Int) = length(intersect(a:b, c:d)) > 0

end # module
