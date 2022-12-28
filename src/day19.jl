module Day19

using AdventOfCode2022

function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    blueprints = parse_input(input)
    
    # blueprint = blueprints[2]
    # solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1, 0, 0, 0)), 0)
    p1 = 0
    println("Part 1")
    println("------")
    # p1tasks = Vector{Task}()
    for blueprint ∈ blueprints
        println(blueprint[1])
        p1 += blueprint[1] * solve(
            Int8(24), NTuple{6,Int8}(blueprint[2:end]),
            NTuple{4,Int8}((0, 0, 0, 0)),
            NTuple{4,Int8}((1,0,0,0)),
            0,
            (true, true, true, true),
            Dict{NTuple{9,Int8},Int}())
        #  push!(p1tasks, Threads.@spawn blueprint[1] * solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)), 0))
    end

    # p1 = fetch.(p1tasks) |> sum

    p2 = 1
    println("Part 2")
    println("------")
    for blueprint ∈ blueprints[1:min(length(blueprints), 3)]
        println(blueprint[1])
    #     # println(solve(Int8(24), NTuple{6,Int8}(blueprint[2:end]), NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)), 0))
        p2 *= solve(Int8(32), NTuple{6,Int8}(blueprint[2:end]),
                    NTuple{4,Int8}((0, 0, 0, 0)), NTuple{4,Int8}((1,0,0,0)),
                    0,
                    (true, true, true, true),
                    Dict{NTuple{9,Int8},Int}())
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
               max_geode::Int,
               allow::NTuple{4,Bool},
               memo::Dict{NTuple{9,Int8},Int})
    can_build = (
        material_inventory[1] >= build_costs[1],
        material_inventory[1] >= build_costs[2],
        material_inventory[1] >= build_costs[3] && material_inventory[2] >= build_costs[4],
        material_inventory[1] >= build_costs[5] && material_inventory[3] >= build_costs[6]
    )

    key = Tuple((time_left, material_inventory..., robot_inventory...))
    haskey(memo, key) && return memo[key]
    
    time_left == 0 && return Int(material_inventory[4])
    new_materials = material_inventory .+ robot_inventory

    # Pruning:

    # max_add_if_can_build = (time_left - 1) * time_left ÷ 2
    # max_add_if_cannot_build = (time_left - 2) * (time_left - 1) ÷ 2

    # max_additional_ore = 0
    # if can_build[1]
    #     max_additional_ore = time_left * robot_inventory[1] + max_add_if_can_build
    # else
    #     max_additional_ore = time_left * robot_inventory[1] + max_add_if_cannot_build
    # end

    # max_additional_clay = 0
    # if can_build[2]
    #     max_additional_clay = time_left * robot_inventory[2] + max_add_if_can_build
    # else
    #     max_additional_clay = time_left * robot_inventory[2] + max_add_if_cannot_build
    # end

    # max_additional_obs = 0
    # if can_build[3]
    #     max_additional_obs = time_left * robot_inventory[3] + max_add_if_can_build
    # else
    #     max_additional_obs = time_left * robot_inventory[3] + max_add_if_cannot_build
    # end

    # max_ore = material_inventory[1] + max_additional_ore
    # max_clay = material_inventory[2] + max_additional_clay
    
    # max_additional_obs_robots = min(max_ore ÷ build_costs[3], max_clay ÷ build_costs[4])
    # if max_additional_obs_robots < time_left
    #     if can_build[3]
    #         max_additional_obs = time_left * robot_inventory[3] + (2*time_left-max_additional_obs_robots) * (max_additional_obs_robots+1) ÷ 2
    #     else
    #         max_additional_obs = time_left * robot_inventory[3] + (2*time_left-2-max_additional_obs_robots) * (max_additional_obs_robots+1) ÷ 2
    #     end
    # end
    # max_obs = material_inventory[3] + max_additional_obs

    # max_additional_geode_robots = min(max_ore ÷ build_costs[5], max_obs ÷ build_costs[6])



    # max_additional_geode = 0
    # if max_additional_geode_robots < time_left
    #     if can_build[4]
    #         max_additional_geode = time_left * robot_inventory[4] + (2*time_left-max_additional_geode_robots) * (max_additional_geode_robots+1) ÷ 2
    #     else
    #         max_additional_geode = time_left * robot_inventory[4] + (2*time_left-2-max_additional_geode_robots) * (max_additional_geode_robots+1) ÷ 2
    #     end
    # else
    #     if can_build[4]
    #         max_additional_geode = time_left * robot_inventory[4] + max_add_if_can_build
    #     else
    #         max_additional_geode = time_left * robot_inventory[4] + max_add_if_cannot_build
    #     end
    # end
    # if material_inventory[4] + max_additional_geode <= max_geode
    #     return max_geode
    # end

    if can_build[4]
        max_additional_geode = time_left * robot_inventory[4] + time_left * (time_left - 1) ÷ 2
    else
        max_additional_geode = time_left * robot_inventory[4] + (time_left - 1) * (time_left - 2) ÷ 2
    end
    if material_inventory[4] + max_additional_geode <= max_geode
        memo[key] = max_geode
        return max_geode
    end

    if can_build[4] #&& time_left >= 2
        geode = solve(time_left - Int8(1), build_costs,
        new_materials .- NTuple{4,Int8}((build_costs[5], 0, build_costs[6], 0)),
        robot_inventory .+ NTuple{4,Int8}((0,0,0,1)),
        max_geode, (true, true, true, true), memo)
        if geode > max_geode
            max_geode = geode
        end
        memo[key] = max_geode
        # If we can build a geode robot, do it and do not follow the other branches
        return max_geode
    end
    if can_build[3] && allow[3] && build_costs[6] >= robot_inventory[3] #&& time_left >= 3
        geode = solve(time_left - Int8(1), build_costs,
        new_materials .- NTuple{4,Int8}((build_costs[3], build_costs[4], 0, 0)),
        robot_inventory .+ NTuple{4,Int8}((0,0,1,0)),
        max_geode, (true, true, true, true), memo)
        if geode > max_geode
            max_geode = geode
        end
    end
    if can_build[2] && allow[2] && build_costs[4] >= robot_inventory[2] #&& time_left >= 4
        geode = solve(time_left - Int8(1), build_costs,
        new_materials .- NTuple{4,Int8}((build_costs[2], 0, 0, 0)),
        robot_inventory .+ NTuple{4,Int8}((0,1,0,0)),
        max_geode, (true, true, true, true), memo)
        if geode > max_geode
            max_geode = geode
        end
    end
    # max_ore_robots_needed = max(build_costs[1], build_costs[2], build_costs[3], build_costs[5])
    if can_build[1] && allow[1] && max(build_costs[1], build_costs[2], build_costs[3], build_costs[5]) >= robot_inventory[1]
        geode = solve(time_left - Int8(1), build_costs,
        new_materials .- NTuple{4,Int8}((build_costs[1], 0, 0, 0)),
        robot_inventory .+ NTuple{4,Int8}((1,0,0,0)),
        max_geode, (true, true, true, true), memo)
        if geode > max_geode
            max_geode = geode
        end
    end
    if !can_build[4]
        geode = solve(time_left - Int8(1), build_costs, new_materials, robot_inventory, max_geode, Tuple((!x for x ∈ can_build)), memo)
        if geode > max_geode
            max_geode = geode
        end
    end
    memo[key] = Int(max_geode)
    return Int(max_geode)
end

end # module
