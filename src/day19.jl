module Day19

using AdventOfCode2022

function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    blueprints = parse_input(input)
    
    # blueprint = blueprints[2]
    # solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1, 0, 0, 0)), 0)
    p1 = 0
    println("Part 1")
    println("------")
    # p1arr = zeros(Int, length(blueprints))
    p1tasks = Vector{Task}()
    for blueprint ∈ blueprints
        println(blueprint[1])
        # p1 += blueprint[1] * solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)), 0)
         push!(p1tasks, Threads.@spawn blueprint[1] * solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)), 0))
    end

    p1 = fetch.(p1tasks) |> sum

    p2 = 1
    println("Part 2")
    println("------")
    for blueprint ∈ blueprints[1:min(length(blueprints), 3)]
        println(blueprint[1])
        # println(solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)), 0))
        p2 *= solve(Int8(32), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)), 0)
    end

    return [p1, p2]
end

function parse_input(input::AbstractString)
    blueprints = Vector{Vector{Int}}()
    for line in eachsplit(input, "\n", keepempty=false)
        numbers = [parse.(Int, line[x]) for x ∈ findall(r"(\d+)", line)]
        push!(blueprints, numbers)
    end
    return blueprints
end

function solve(time_left::Int8,
               build_costs::NTuple{6,Int8},
               material_inventory::NTuple{4,Int8},
               robot_inventory::NTuple{4,Int8},
               max_geode::Int)
    # println("Hello, World!")
    # can_build = (
    #     material_inventory[1] - build_costs[1] >= 0,
    #     material_inventory[1] - build_costs[2] >= 0,
    #     material_inventory[1] - build_costs[3] >= 0 && material_inventory[2] - build_costs[4] >= 0,
    #     material_inventory[1] - build_costs[5] >= 0 && material_inventory[3] - build_costs[6] >= 0
    # )
    can_build = (
        material_inventory[1] >= build_costs[1],
        material_inventory[1] >= build_costs[2],
        material_inventory[1] >= build_costs[3] && material_inventory[2] >= build_costs[4],
        material_inventory[1] >= build_costs[5] && material_inventory[3] >= build_costs[6]
    )

    # after_build = (
    #     material_inventory[1] - build_costs[1],
    #     material_inventory[1] - build_costs[2],
    #     material_inventory[1] - build_costs[3],
    #     material_inventory[2] - build_costs[4],
    #     material_inventory[1] - build_costs[5],
    #     material_inventory[3] - build_costs[6]
    # )
    
    new_materials = material_inventory .+ robot_inventory
    time_left == 0 && return Int(material_inventory[4])

    # Pruning:
    max_additional_geode = 0
    if can_build[4]
        max_additional_geode = time_left * robot_inventory[4] + time_left * (1 + time_left) ÷ 2
    else
        max_additional_geode = time_left * robot_inventory[4] + (time_left - 1) * time_left ÷ 2
    end
    if material_inventory[4] + max_additional_geode <= max_geode
        return max_geode
    end

    if can_build[1] && !can_build[4]
        geode = solve(time_left - Int8(1), build_costs,
                      new_materials .- NTuple{4,Int8}((build_costs[1], 0, 0, 0)),
                      robot_inventory .+ NTuple{4,Int8}((1,0,0,0)),
                      max_geode)
        if geode > max_geode
            max_geode = geode
        end
    end
    if can_build[2] && !can_build[4]
        geode = solve(time_left - Int8(1), build_costs,
                      new_materials .- NTuple{4,Int8}((build_costs[2], 0, 0, 0)),
                      robot_inventory .+ NTuple{4,Int8}((0,1,0,0)),
                      max_geode)
        if geode > max_geode
            max_geode = geode
        end
    end
    if can_build[3] && !can_build[4]
        geode = solve(time_left - Int8(1), build_costs,
                      new_materials .- NTuple{4,Int8}((build_costs[3], build_costs[4], 0, 0)),
                      robot_inventory .+ NTuple{4,Int8}((0,0,1,0)),
                      max_geode)
        if geode > max_geode
            max_geode = geode
        end
    end
    if can_build[4]
        geode = solve(time_left - Int8(1), build_costs,
                      new_materials .- NTuple{4,Int8}((build_costs[5], 0, build_costs[6], 0)),
                      robot_inventory .+ NTuple{4,Int8}((0,0,0,1)),
                      max_geode)
        if geode > max_geode
            max_geode = geode
        end
    end
    if !can_build[4]
        geode = solve(time_left - Int8(1), build_costs, new_materials, robot_inventory, max_geode)
        if geode > max_geode
            max_geode = geode
        end
    end
    return Int(max_geode)
end

end # module
