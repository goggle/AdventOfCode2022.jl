module Day19

using AdventOfCode2022

function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    blueprints = parse_input(input)

    p1tasks = Vector{Task}()
    for blueprint ∈ blueprints
        push!(p1tasks, Threads.@spawn blueprint[1] * solve(
            Int8(24), NTuple{6, Int8}(blueprint[2:end]),
            NTuple{4, Int8}((0, 0, 0, 0)),
            NTuple{4, Int8}((1, 0, 0, 0)),
            0,
            (true, true, true, true)))
    end

    p2tasks = Vector{Task}()
    for blueprint ∈ blueprints[1:min(length(blueprints), 3)]
        push!(p2tasks, Threads.@spawn solve(Int8(32), NTuple{6, Int8}(blueprint[2:end]),
            NTuple{4, Int8}((0, 0, 0, 0)), NTuple{4, Int8}((1, 0, 0, 0)), 0,
            (true, true, true, true)))
    end

    p1 = fetch.(p1tasks) |> sum
    p2 = fetch.(p2tasks) |> prod
    return [p1, p2]
end

function parse_input(input::AbstractString)
    blueprints = Vector{Vector{Int}}()
    for line in eachsplit(input, "\n", keepempty = false)
        numbers = [parse.(Int, line[x]) for x ∈ findall(r"(\d+)", line)]
        push!(blueprints, numbers)
    end
    return blueprints
end

function solve(time_left::Int8,
    build_costs::NTuple{6, Int8},
    material_inventory::NTuple{4, Int8},
    robot_inventory::NTuple{4, Int8},
    max_geode::Int,
    allow::NTuple{4, Bool})
    can_build = (
        material_inventory[1] >= build_costs[1],
        material_inventory[1] >= build_costs[2],
        material_inventory[1] >= build_costs[3] && material_inventory[2] >= build_costs[4],
        material_inventory[1] >= build_costs[5] && material_inventory[3] >= build_costs[6],
    )

    time_left == 0 && return Int(material_inventory[4])
    new_materials = material_inventory .+ robot_inventory

    # Pruning:
    #
    #  * Estimate the maximum amount of geode by assuming that we can build
    #    a geode robot at each time step. If that estimation is less or equal
    #    than the currently known maximal amount of geode, we do not have to
    #    further investigate that branch.
    #  * If we choose to wait (and not build a robot, but could have built it),
    #    do not build that robot in the next turn either.
    #  * Do not build more robots than needed to build another robot, e.g.
    #    if the most expensive robot costs 5 ore, do not build more than
    #    5 ore robots.
    #  * Always build a geode robot if you can and do not investigate other
    #    branches in that case.
    if can_build[4]
        max_additional_geode = time_left * robot_inventory[4] + time_left * (time_left - 1) ÷ 2
    else
        max_additional_geode = time_left * robot_inventory[4] + (time_left - 1) * (time_left - 2) ÷ 2
    end
    if material_inventory[4] + max_additional_geode <= max_geode
        return max_geode
    end

    if can_build[4]
        geode = solve(time_left - Int8(1), build_costs,
            new_materials .- NTuple{4, Int8}((build_costs[5], 0, build_costs[6], 0)),
            robot_inventory .+ NTuple{4, Int8}((0, 0, 0, 1)),
            max_geode, (true, true, true, true))
        if geode > max_geode
            max_geode = geode
        end
        # If we can build a geode robot, do it and do not follow the other branches
        return max_geode
    end
    if can_build[3] && allow[3] && build_costs[6] >= robot_inventory[3]
        geode = solve(time_left - Int8(1), build_costs,
            new_materials .- NTuple{4, Int8}((build_costs[3], build_costs[4], 0, 0)),
            robot_inventory .+ NTuple{4, Int8}((0, 0, 1, 0)),
            max_geode, (true, true, true, true))
        if geode > max_geode
            max_geode = geode
        end
    end
    if can_build[2] && allow[2] && build_costs[4] >= robot_inventory[2]
        geode = solve(time_left - Int8(1), build_costs,
            new_materials .- NTuple{4, Int8}((build_costs[2], 0, 0, 0)),
            robot_inventory .+ NTuple{4, Int8}((0, 1, 0, 0)),
            max_geode, (true, true, true, true))
        if geode > max_geode
            max_geode = geode
        end
    end
    if can_build[1] && allow[1] && max(build_costs[1], build_costs[2], build_costs[3], build_costs[5]) >= robot_inventory[1]
        geode = solve(time_left - Int8(1), build_costs,
            new_materials .- NTuple{4, Int8}((build_costs[1], 0, 0, 0)),
            robot_inventory .+ NTuple{4, Int8}((1, 0, 0, 0)),
            max_geode, (true, true, true, true))
        if geode > max_geode
            max_geode = geode
        end
    end
    if !can_build[4]
        geode = solve(time_left - Int8(1), build_costs, new_materials, robot_inventory, max_geode, Tuple((!x for x ∈ can_build)))
        if geode > max_geode
            max_geode = geode
        end
    end
    return max_geode
end

end # module
