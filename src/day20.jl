module Day20

using AdventOfCode2022

mutable struct CircularList
    value::Int
    prev::Union{CircularList,Nothing}
    next::Union{CircularList,Nothing}
end

function day20(input::String = readInput(joinpath(@__DIR__, "..", "data", "day20.txt")))
    cl, initial_order = parse_input(input)
    shuffle!(initial_order)
    zero = find_zero(cl)
    p1 = get_grove_number(zero, length(initial_order))

    cl, initial_order = parse_input(input; decryption_key=811589153)
    for _ ∈ 1:10
        shuffle!(initial_order)
    end
    zero = find_zero(cl)
    p2 = get_grove_number(zero, length(initial_order))

    return [p1, p2]
end

function get_grove_number(zero::CircularList, capacity::Int)
    nsteps = mod(1000, capacity)
    coords = Int[]
    for _ ∈ 1:3
        for _ ∈ 1:nsteps
            zero = zero.next
        end
        push!(coords, zero.value)
    end
    return coords |> sum
end

function find_zero(cl::CircularList)
    while cl.value != 0
        cl = cl.next
    end
    return cl
end

function shuffle!(initial_order::Vector{CircularList})
    for elem ∈ initial_order
        move!(elem, length(initial_order), elem.value)
    end
end

function move!(src::CircularList, capacity::Int, n::Int)
    n = mod(n, capacity - 1)
    n == 0 && return
    src.prev.next = src.next
    src.next.prev = src.prev
    prev = src
    for _ ∈ 1:n
        prev = prev.next
    end
    next = prev.next
    prev.next = src
    next.prev = src
    src.next = next
    src.prev = prev
end

function parse_input(input; decryption_key=1)
    numbers = parse.(Int, split(rstrip(input), "\n")) .* decryption_key
    circ = [CircularList(number, nothing, nothing) for number ∈ numbers]
    for i ∈ axes(circ,1)[1:end-1]
        circ[i].next = circ[i+1]
    end
    circ[end].next = circ[1]
    circ[1].prev = circ[end]
    for i ∈ axes(circ,1)[2:end]
        circ[i].prev = circ[i-1]
    end

    return circ[1], circ
end

end # module
