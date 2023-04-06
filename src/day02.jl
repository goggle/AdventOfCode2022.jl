module Day02

using AdventOfCode2022

function day02(input::String = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    data = map.(x -> x[1], eachsplit.(eachsplit(rstrip(input), "\n")))
    p1 = sum(play_round(x[1], x[2]) for x ∈ data)
    p2 = sum(play_round(x[1], choose(x[1], x[2])) for x ∈ data)
    return [p1, p2]
end

function play_round(opp::Char, me::Char)
    s = me - 'X' + 1
    opp == 'A' && me == 'X' && return 3 + s
    opp == 'B' && me == 'Y' && return 3 + s
    opp == 'C' && me == 'Z' && return 3 + s
    opp == 'A' && me == 'Y' && return 6 + s
    opp == 'A' && me == 'Z' && return 0 + s
    opp == 'B' && me == 'X' && return 0 + s
    opp == 'B' && me == 'Z' && return 6 + s
    opp == 'C' && me == 'X' && return 6 + s
    opp == 'C' && me == 'Y' && return 0 + s
end

function choose(opp::Char, result::Char)
    if opp == 'A'
        result == 'X' && return 'Z'
        result == 'Y' && return 'X'
        result == 'Z' && return 'Y'
    elseif opp == 'B'
        result == 'X' && return 'X'
        result == 'Y' && return 'Y'
        result == 'Z' && return 'Z'
    elseif opp == 'C'
        result == 'X' && return 'Y'
        result == 'Y' && return 'Z'
        result == 'Z' && return 'X'
    end
end

end # module
