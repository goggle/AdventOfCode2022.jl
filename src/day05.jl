module Day05

using AdventOfCode2022

function day05(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    crates, instructions = parse_input(input)
    p1 = part1!(deepcopy(crates), instructions)
    p2 = part2!(crates, instructions)
    return [p1, p2]
end

function parse_input(input::AbstractString)
    cr, instr = split(input, "\n\n")
    crates_reversed = reverse(split(cr, "\n"))
    numbers = parse.(Int, split(crates_reversed[1]))
    crates = Dict{Int,Vector{Char}}()
    for number ∈ numbers
        crates[number] = Char[]
    end
    for line ∈ crates_reversed[2:end]
        for (i, c) ∈ enumerate(line[2:4:end])
            if c != ' '
                push!(crates[i], c)
            end
        end
    end
    reg = r"move\s+(\d+)\s+from\s+(\d+)\s+to\s+(\d+)"
    instructions = [parse.(Int, match(reg, x).captures) for x ∈ split(rstrip(instr), "\n")]
    return crates, instructions
end

function part1!(crates::Dict{Int,Vector{Char}}, instructions::Vector{Vector{Int}})
    for instruction ∈ instructions
        times, from, to = instruction
        for i = 1:times
            push!(crates[to], pop!(crates[from]))
        end
    end
    return join([crates[x][end] for x ∈ sort(collect(keys(crates)))])
end

function part2!(crates::Dict{Int,Vector{Char}}, instructions::Vector{Vector{Int}})
    for instruction ∈ instructions
        times, from, to = instruction
        l = length(crates[from])
        push!(crates[to], splice!(crates[from], l-times+1:l)...)
    end
    return join([crates[x][end] for x ∈ sort(collect(keys(crates)))])
end

end # module