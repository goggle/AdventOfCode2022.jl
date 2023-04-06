module Day08

using AdventOfCode2022

function day08(input::String = readInput(joinpath(@__DIR__, "..", "data", "day08.txt")))
    heightmap = reduce(vcat, permutedims.(map(x -> parse.(Int, split(x, "")), split(input))))
    return [part1(heightmap), part2(heightmap)]
end

function part1(heightmap::Matrix{Int})
    visible = zeros(Bool, size(heightmap))
    visible[1, :] .= visible[end, :] .= visible[:, 1] .= visible[:, end] .= true
    for i ∈ 2:size(visible)[1]-1
        M = heightmap[i, 1]
        for j ∈ 2:size(visible)[2]-1
            if heightmap[i, j] > M
                visible[i, j] = true
                M = heightmap[i, j]
            end
        end
    end
    for j ∈ 2:size(visible)[2]-1
        M = heightmap[1, j]
        for i ∈ 2:size(visible)[1]-1
            if heightmap[i, j] > M
                visible[i, j] = true
                M = heightmap[i, j]
            end
        end
    end
    for i ∈ size(visible)[1]-1:-1:2
        M = heightmap[i, end]
        for j ∈ size(visible)[2]-1:-1:2
            if heightmap[i, j] > M
                visible[i, j] = true
                M = heightmap[i, j]
            end
        end
    end
    for j ∈ size(visible)[2]-1:-1:2
        M = heightmap[end, j]
        for i ∈ size(visible)[1]-1:-1:2
            if heightmap[i, j] > M
                visible[i, j] = true
                M = heightmap[i, j]
            end
        end
    end
    return visible |> sum
end

function part2(heightmap::Matrix{Int})
    scoremap = zeros(Int, size(heightmap))
    for i ∈ 2:size(heightmap)[1]-1
        for j ∈ 2:size(heightmap)[2]-1
            up = down = left = right = 0
            M = heightmap[i, j]
            k, l = i, j
            while k >= 2
                k -= 1
                up += 1
                heightmap[k, l] >= M && break
            end

            k, l = i, j
            while k <= size(heightmap)[1] - 1
                k += 1
                down += 1
                heightmap[k, l] >= M && break
            end

            k, l = i, j
            while l >= 2
                l -= 1
                left += 1
                heightmap[k, l] >= M && break
            end

            k, l = i, j
            while l <= size(heightmap)[2] - 1
                l += 1
                right += 1
                heightmap[k, l] >= M && break
            end

            scoremap[i, j] = up * down * left * right
        end
    end
    return scoremap |> maximum
end

end # module
