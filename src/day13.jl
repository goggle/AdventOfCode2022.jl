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
        result = compare(l, r)
        if result == -1
            total += i
        end
    end
    return total
end

function part2(packets)
    sorted = Any[[[2]], [[6]]]
    for packet ∈ packets
        for (i, sp) ∈ enumerate(sorted)
            res = compare(packet, sp)
            if res == -1
                insert!(sorted, i, packet)
                break
            end
            if i == length(sorted) && res != -1
                insert!(sorted, i+1, packet)
                break
            end
        end
    end
    ind1 = findfirst(x -> x==[[2]], sorted)
    ind2 = findfirst(x -> x==[[6]], sorted)
    return ind1 * ind2
end

function compare(left, right)
    if isa(left, Vector) && isa(right, Vector)
        m = min(length(left), length(right))
        for (l, r) ∈ zip(left[1:m], right[1:m])
            result = compare(l, r)
            if result ∈ (-1, 1)
                return result
            end
        end
        length(left) < length(right) && return -1
        length(left) > length(right) && return 1
        length(left) == length(right) && return 0
    elseif isa(left, Vector)
        return compare(left, [right])
    else
        return compare([left], right)
    end
end

function compare(left::Int, right::Int)
    if left < right
        return -1
    elseif right < left
        return 1
    else
        return 0
    end
end

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
            i, nobj = recparse(line, i+1, [])
            push!(obj, nobj)
            i > length(line) && return i, obj
        end
        if isnumeric(line[i])
            j = i
            while isnumeric(line[j]) || line[j] == ','
                j += 1
            end
            numbers = parse.(Int, split(line[i:j-1], ",", keepempty=false))
            push!(obj, numbers...)
            i = j - 1
        end
        i += 1
        if i > length(line)
            return i, obj
        end
    end
    return i+1, obj
end

end # module
