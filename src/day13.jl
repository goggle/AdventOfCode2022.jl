module Day13

using AdventOfCode2022

function day13(input::String = readInput(joinpath(@__DIR__, "..", "data", "day13.txt")))
    pairs = parse_input(input)
    p1 = part1(pairs)
    packets = union([p[1] for p ∈ pairs], [p[2] for p ∈ pairs])
    p2 = part2(packets)
    return [p1, p2]
end

function part1(pairs)
    total = 0
    for (i, (l, r)) ∈ enumerate(pairs)
        if l < r
            total += i
        end
    end
    return total
end

function part2(packets)
    divider1, divider2 = [[2]], [[6]]
    n_packets_before_divider1, n_packets_before_divider2 = 0, 1
    for packet ∈ packets
        if packet < divider1
            n_packets_before_divider1 += 1
            n_packets_before_divider2 += 1
        elseif packet < divider2
            n_packets_before_divider2 += 1
        end
    end
    return (n_packets_before_divider1 + 1) * (n_packets_before_divider2 + 1)
end

Base.isless(l::Int, r::AbstractVector) = [l] < r
Base.isequal(l::Int, r::AbstractVector) = isequal([l], r)
Base.isless(l::AbstractVector, r::Int) = l < [r]
Base.isequal(l::AbstractVector, r::Int) = isequal(l, [r])

function parse_input(input::AbstractString)
    pairs = []
    blocks = split(rstrip(input), "\n\n")
    for block ∈ blocks
        l, r = split(block, "\n")
        pair = (parse_line(l), parse_line(r))
        push!(pairs, pair)
    end
    return pairs
end

function parse_line(line::AbstractString)
    return recparse(line, 1, [])[2][1]
end

function recparse(line::AbstractString, i::Int, obj)
    while line[i] != ']'
        if line[i] == '['
            i, nobj = recparse(line, i + 1, [])
            push!(obj, nobj)
            i > length(line) && return i, obj
        end
        if isnumeric(line[i])
            j = i
            while isnumeric(line[j]) || line[j] == ','
                j += 1
            end
            numbers = parse.(Int, split(line[i:j-1], ",", keepempty = false))
            push!(obj, numbers...)
            i = j - 1
        end
        i += 1
        if i > length(line)
            return i, obj
        end
    end
    return i + 1, obj
end

end # module
