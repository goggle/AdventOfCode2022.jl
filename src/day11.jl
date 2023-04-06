module Day11

using AdventOfCode2022
using DataStructures

struct Monkey
    id::Int
    items::Queue{Int}
    opc::Char
    update::Function
    divisible::Int
    true_throw_id::Int
    false_throw_id::Int
end

operation(m::Monkey, old::Int) = isa(m.op2, String) ? m.operator(old, old) : m.operator(old, m.op2)

function day11(input::String = readInput(joinpath(@__DIR__, "..", "data", "day11.txt")))
    monkeys = parse_input(input)
    return [part1(monkeys), part2!(monkeys)]
end

function part1(monkeys::Vector{Monkey})
    processed = zeros(Int, length(monkeys))
    monkeys = deepcopy(monkeys)
    for _ ∈ 1:20
        play_round!(monkeys, processed, 3)
    end
    return sort(processed, rev = true)[1:2] |> prod
end

function part2!(monkeys::Vector{Monkey})
    processed = zeros(Int, length(monkeys))
    divprod = prod(m.divisible for m ∈ monkeys)
    for _ ∈ 1:10_000
        play_round!(monkeys, processed, 1, divprod = divprod)
    end
    return sort(processed, rev = true)[1:2] |> prod
end

function play_round!(monkeys::Vector{Monkey}, processed::Vector{Int}, divide_by; divprod = 0)
    for monkey ∈ monkeys
        for _ ∈ 1:length(monkey.items)
            processed[monkey.id+1] += 1
            worry_level = dequeue!(monkey.items)
            worry_level = monkey.update(worry_level)
            worry_level ÷= divide_by
            if divprod != 0 && monkey.opc == '*'
                worry_level = mod(worry_level, divprod)
            end
            if mod(worry_level, monkey.divisible) == 0
                enqueue!(monkeys[monkey.true_throw_id+1].items, worry_level)
            else
                enqueue!(monkeys[monkey.false_throw_id+1].items, worry_level)
            end
        end
    end
    return processed
end

function parse_input(input::AbstractString)
    data = Monkey[]
    for block ∈ eachsplit(rstrip(input), "\n\n")
        lines = split(block, "\n")
        id = parse(Int, match(r"Monkey\s+(\d+)\:", lines[1]).captures[1])
        numbers_match = match(r"\s*Starting\s+items\:\s+(.+)$", lines[2])
        items = Queue{Int}()
        for elem ∈ reverse(parse.(Int, split(numbers_match.captures[1], ",")))
            enqueue!(items, elem)
        end
        opm = match(r"\s+Operation\:\s+new\s+=\s+(\w+|\d+)\s+(\*|\+)\s+(\w+|\d+)", lines[3])
        op2 = opm.captures[3] |> String
        tpop2 = tryparse(Int, op2)
        if tpop2 !== nothing
            op2 = tpop2
        end

        opc = opm.captures[2][1]
        if opc == '*'
            if isa(op2, Int)
                update = x::Int -> x * op2
            else
                update = x::Int -> x * x
            end
        else
            update = x::Int -> x + op2
        end

        divm = match(r"Test\:\s+divisible\s+by\s+(\d+)", lines[4])
        divisible = parse(Int, divm.captures[1])
        truem = match(r"\s+If\s+true\:\s+throw\s+to\s+monkey\s+(\d+)", lines[5])
        true_throw_id = parse(Int, truem.captures[1])
        falsem = match(r"\s+If\s+false\:\s+throw\s+to\s+monkey\s+(\d+)", lines[6])
        false_throw_id = parse(Int, falsem.captures[1])
        push!(data, Monkey(id, items, opc, update, divisible, true_throw_id, false_throw_id))
    end
    return data
end

end # module