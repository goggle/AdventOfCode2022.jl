module Day15

using AdventOfCode2022

function day15(input::String = readInput(joinpath(@__DIR__, "..", "data", "day15.txt")))
    sensors, beacons = parse_input(input)
    return [part1(sensors, beacons; y=2_000_000), part2(sensors, beacons)]
end

function part1(sensors::Vector{Tuple{Int,Int}}, closest_beacons::Vector{Tuple{Int,Int}}; y=10)
    distances = [manhatten(s..., b...) for (s, b) ∈ zip(sensors, closest_beacons)]
    ranges = Set{UnitRange{Int}}()
    for (sensor, r) ∈ zip(sensors, distances)
        nran = non_available_x_ranges(sensor..., r, y)
        !isempty(nran) && push!(ranges, nran)
    end

    b = findall(x -> x[2] == y, unique(closest_beacons)) |> length
    ranges = decouple(ranges)
    total = (length.(ranges) |> sum) - b
    return total
end

function part2(sensors::Vector{Tuple{Int,Int}}, closest_beacons::Vector{Tuple{Int,Int}})
    distances = [manhatten(s..., b...) for (s, b) ∈ zip(sensors, closest_beacons)]

    # Idea:
    # Calculate lines along the edges of the Manhatten sphere of each sphere.
    # These lines have either slope +1 or -1.
    # It is enough to store their y-intercepts (b1, b2, b3, b4).
    lines = NTuple{4,Int}[]
    for ((x, y), d) ∈ zip(sensors, distances)
        b1 = y - x - d
        b2 = y - x + d
        b3 = y + x + d
        b4 = y + x - d
        push!(lines, (b1, b2, b3, b4))
    end

    # Calculate the intersection points of all the lines:
    intersections = Tuple{Int,Int}[]
    for line ∈ lines
        for line2 ∈ lines
            for i = 1:2
                for j = 3:4
                    b1 = line[i]
                    b2 = line2[j]

                    # It is enough to store the intersection points
                    # with integer-valued coordinates
                    mod(b1 + b2, 2) != 0 && continue
                    
                    x = (b2 - b1) ÷ 2
                    y = (b1 + b2) ÷ 2
                    admissible(x, y) && push!(intersections, (x, y))
                end
            end
        end
    end

    # For each intersection point, count how many other points are in the list
    # that have Manhatten distance of 2 from each other:
    ndists2 = [count(manhatten(point..., p2...) == 2 for p2 ∈ intersections if p2 ≠ point) for point ∈ intersections]
 
    # Search the pattern: The square we want to find must have neighbours
    # at each direction from it.
    candidates = intersections[findall(x -> x >= 3, ndists2)]
    for (x, y) ∈ candidates
        (x+2,y) ∈ candidates && (x+1,y+1) ∈ candidates && (x+1,y-1) ∈ candidates && return (x+1) * 4_000_000 + y
    end
end

admissible(x::Int, y::Int) = 0 <= x <= 4_000_000 && 0 <= y <= 4_000_000
manhatten(x1::Int, y1::Int, x2::Int, y2::Int) = abs(x1-x2) + abs(y1-y2)

function non_available_x_ranges(sx::Int, sy::Int, r::Int, y0::Int)
    t = abs(sy - y0)
    return sx - r + t : r - t + sx
end

function decouple(ranges::Set{UnitRange{Int}})
    # First remove ranges that are completely
    # contained in another range:
    rs = sort(collect(ranges))
    snew = copy(ranges)
    for i ∈ eachindex(rs)
        for j ∈ eachindex(rs)
            i == j && continue
            if rs[j] ⊆ rs[i]
                delete!(snew, rs[j])
            end
        end
    end

    # Replace all the ranges that intersect each other by ranges
    # that do not intersect each other anymore
    while true
        rs = sort(collect(snew))
        intersects = [!isempty(rs[i] ∩ rs[i+1]) for i ∈ axes(rs, 1)[1:end-1]]
        !any(intersects) && break
        ind = findfirst(x -> x == true, intersects)
        nrange = rs[ind].start:rs[ind+1].stop
        delete!(snew, rs[ind])
        delete!(snew, rs[ind+1])
        push!(snew, nrange)
    end

    return snew
end

function parse_input(input::AbstractString)
    r = r"Sensor\s+at\s+x=(-?\d+),\s+y=(-?\d+)\:\s+closest\s+beacon\s+is\s+at\s+x=(-?\d+),\s+y=(-?\d+)$"
    sensors = Vector{Tuple{Int,Int}}()
    beacons = Vector{Tuple{Int,Int}}()
    for line in eachsplit(rstrip(input), "\n")
        m = match(r, line)
        x1, y1, x2, y2 = parse.(Int, m.captures)
        push!(sensors, (x1, y1))
        push!(beacons, (x2, y2))
    end
    return sensors, beacons
end

end # module
