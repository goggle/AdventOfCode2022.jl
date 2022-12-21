module Day18

using AdventOfCode2022

function day18(input::String = readInput(joinpath(@__DIR__, "..", "data", "day18.txt")))
    coordinates = map(x -> parse.(Int, x), eachsplit.(eachsplit(rstrip(input), "\n"), ','))

    M = maximum(x[i] for x in coordinates for i in 1:3)
    data = zeros(Int, M+5, M+5, M+5)
    for coord ∈ coordinates
        data[(coord + [2,2,2])...] = 1
    end
    n_p1_connections = count_connections(data, Set(1))
    p1 = 6 * length(coordinates) - n_p1_connections

    interior = flood!(data)
    n_p2_connections = count_connections(data, interior)
    p2 = p1 - n_p2_connections
    return [p1, p2]
end

function count_connections(data::Array{Int,3}, valid::Set{Int})
    c = 0
    cubes = findall(x->x==1,data)
    for cube ∈ cubes
        x, y, z = cube.I
        if x - 1 >= 1 && data[x-1,y,z] ∈ valid
            c += 1
        end
        if y - 1 >= 1 && data[x,y-1,z] ∈ valid
            c += 1
        end
        if z - 1 >= 1 && data[x,y,z-1] ∈ valid
            c += 1
        end
        if x + 1 <= size(data,1) && data[x+1,y,z] ∈ valid
            c += 1
        end
        if y + 1 <= size(data,2) && data[x,y+1,z] ∈ valid
            c += 1
        end
        if z + 1 <= size(data,3) && data[x,y,z+1] ∈ valid
            c += 1
        end
    end
    return c
end

function flood!(data::Array{Int,3})
    exterior = Set{Int}()
    value = 2
    while true
        zero = findfirst(x -> x==0, data)
        zero === nothing && break
        q = CartesianIndex{3}[zero]
        while !isempty(q)
            x, y, z = popfirst!(q).I
            if !boundcheck(data, x, y, z)
                push!(exterior, value)
                continue
            end
            if data[x,y,z] == 0
                data[x,y,z] = value
                push!(q, CartesianIndex(x+1,y,z))
                push!(q, CartesianIndex(x-1,y,z))
                push!(q, CartesianIndex(x,y+1,z))
                push!(q, CartesianIndex(x,y-1,z))
                push!(q, CartesianIndex(x,y,z+1))
                push!(q, CartesianIndex(x,y,z-1))
            end
        end
        value += 1
    end
    interior = setdiff(Set(2:value-1), exterior)
    return interior
end

function boundcheck(data::Array{Int,3}, x::Int, y::Int, z::Int)
    (x <= 0 || y <= 0 || z <= 0 || x > size(data,1) || y > size(data,2) || z > size(data,3)) && return false
    return true
end

end # module
