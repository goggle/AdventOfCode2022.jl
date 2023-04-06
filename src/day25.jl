module Day25

using AdventOfCode2022

function day25(input::String = readInput(joinpath(@__DIR__, "..", "data", "day25.txt")))
    numbers = Vector{Vector{Int}}()
    for line ∈ eachsplit(input, "\n", keepempty = false)
        d = Dict(
            '2' => 2,
            '1' => 1,
            '0' => 0,
            '-' => -1,
            '=' => -2,
        )
        sp = map(x -> d[x[1]], split(line, ""))
        push!(numbers, sp)
    end
    s = [0]
    for snafu ∈ numbers
        s = add!(s, snafu)
    end
    d = Dict(
        -2 => '=',
        -1 => '-',
        0 => '0',
        1 => '1',
        2 => '2',
    )
    return join(map(x -> d[x], s))
end

function add!(snafu1::Vector{Int}, snafu2::Vector{Int})
    if length(snafu1) > length(snafu2)
        nadd = length(snafu1) - length(snafu2)
        pushfirst!(snafu2, zeros(Int, nadd)...)
    elseif length(snafu1) < length(snafu2)
        nadd = length(snafu2) - length(snafu1)
        pushfirst!(snafu1, zeros(Int, nadd)...)
    end
    result = Vector{Int}()
    carry = 0
    for i ∈ axes(snafu1, 1) |> reverse
        res = carry + snafu1[i] + snafu2[i]
        if res > 2
            carry = 1
        elseif res < -2
            carry = -1
        else
            carry = 0
        end
        dig = mod(res + 2, 5) - 2
        pushfirst!(result, dig)
    end
    if carry ≠ 0
        pushfirst!(result, carry)
    end
    return result
end

end # module
