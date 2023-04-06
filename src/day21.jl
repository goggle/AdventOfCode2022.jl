module Day21

using AdventOfCode2022

struct Node
    content::Union{Tuple{Union{Int, String, Node}, Union{Int, String, Node}, Char}, Int, String}
end

function day21(input::String = readInput(joinpath(@__DIR__, "..", "data", "day21.txt")))
    number_monkeys, math_monkeys = parse_input(input)
    number_monkeys_p1 = deepcopy(number_monkeys)
    math_monkeys_p1 = deepcopy(math_monkeys)
    part1!(number_monkeys_p1, math_monkeys_p1)
    p1 = number_monkeys_p1["root"].content

    left = math_monkeys["root"].content[1]
    right = math_monkeys["root"].content[2]
    delete!(math_monkeys, "root")
    number_monkeys["humn"] = Node("x")
    part1!(number_monkeys, math_monkeys)
    p2 = resolve(number_monkeys[left], number_monkeys[right])
    return [p1, p2]
end

function part1!(number_monkeys::Dict{String, Node}, math_monkeys::Dict{String, Node})
    operator = Dict('*' => mul, '/' => div, '+' => add, '-' => sub)
    while !isempty(math_monkeys)
        ks = keys(math_monkeys)
        for k ∈ ks
            param1, param2, op = math_monkeys[k].content
            if haskey(number_monkeys, param1) && haskey(number_monkeys, param2)
                number_monkeys[k] = operator[op](number_monkeys[param1], number_monkeys[param2])
                delete!(math_monkeys, k)
            end
        end
    end
end

function resolve(left::Node, right::Node)
    number = isa(left.content, Int) ? left.content : right.content
    equation = isa(left.content, Int) ? right : left
    while true
        isa(equation.content, String) && return number
        eq1 = equation.content[1]
        eq2 = equation.content[2]
        op = equation.content[3]
        case = isa(eq1.content, Int) ? 1 : 2
        n = isa(eq1.content, Int) ? eq1.content : eq2.content
        eq = isa(eq1.content, Int) ? eq2 : eq1
        if op == '*'
            number ÷= n
        elseif op == '/'
            number *= n
        elseif op == '+'
            number -= n
        elseif op == '-'
            if case == 1
                number = -1 * (number - n)
            else
                number += n
            end
        end
        equation = eq
    end
end

add(x::Node, y::Node) = isa(x.content, Int) && isa(y.content, Int) ? Node(x.content + y.content) : Node((x, y, '+'))
sub(x::Node, y::Node) = isa(x.content, Int) && isa(y.content, Int) ? Node(x.content - y.content) : Node((x, y, '-'))
mul(x::Node, y::Node) = isa(x.content, Int) && isa(y.content, Int) ? Node(x.content * y.content) : Node((x, y, '*'))
div(x::Node, y::Node) = isa(x.content, Int) && isa(y.content, Int) ? Node(x.content ÷ y.content) : Node((x, y, '/'))

function parse_input(input::AbstractString)
    number_monkeys = Dict{String, Node}()
    math_monkeys = Dict{String, Node}()
    for line ∈ eachsplit(rstrip(input), "\n")
        spline = split(line, " ")
        name = chop(spline[1], tail = 1)
        if length(spline) == 2
            number = parse(Int, spline[2])
            number_monkeys[name] = Node(number)
        else
            math_monkeys[name] = Node((string(spline[2]), string(spline[4]), spline[3][1]))
        end
    end
    return number_monkeys, math_monkeys
end

end # module
