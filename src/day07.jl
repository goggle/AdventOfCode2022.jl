module Day07

using AdventOfCode2022

struct Tree
    name::String
    isdir::Bool
    size::Int
    children::Vector{Tree}
end

function day07(input::String = readInput(joinpath(@__DIR__, "..", "data", "day07.txt")))
    tree = parse_input(input)
    p1 = sum_dir_100_000(tree)
    free_space = 70_000_000 - sum_dir(tree)
    delete_at_least = 30_000_000 - free_space
    sizes = dir_sizes(tree, Int[])
    p2 = filter(x -> x >= delete_at_least, sizes) |> minimum
    return [p1, p2]
end

function parse_input(input::AbstractString)
    t = Tree("/", true, 0, Tree[])
    stack = Tree[t]
    lines = split(rstrip(input), "\n")
    for line ∈ lines
        line ∈ ("\$ cd /", "\$ ls") && continue
        if startswith(line, "\$ cd")
            t = chdir!(stack, t, String(split(line)[end]))
        else
            dirsize, name = split(line)
            if dirsize == "dir"
                push!(t.children, Tree(String(name), true, 0, Tree[]))
            else
                push!(t.children, Tree(String(name), false, parse(Int, dirsize), Tree[]))
            end
        end
    end
    return stack[1]
end

function chdir!(stack::Vector{Tree}, t::Tree, name::String)
    if name == ".."
        pop!(stack)
        return stack[end]
    end
    for child ∈ t.children
        if child.name == name
            push!(stack, child)
            return child
        end
    end
end

function sum_dir_100_000(node::Tree)
    s = 0
    for c ∈ node.children
        if c.isdir
            value = sum_dir(c)
            if value <= 100_000
                s += value
            end
            s += sum_dir_100_000(c)
        end
    end
    return s
end

function sum_dir(node::Tree)
    s = 0
    for c ∈ node.children
        if !c.isdir
            s += c.size
        else
            s += sum_dir(c)
        end
    end
    return s
end

function dir_sizes(node::Tree, sizes::Vector{Int})
    push!(sizes, sum_dir(node))
    for c ∈ node.children
        if c.isdir
            dir_sizes(c, sizes)
        end
    end
    return sizes
end

end # module