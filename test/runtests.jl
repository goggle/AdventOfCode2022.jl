using AdventOfCode2022
using Test

@testset "Day 1" begin
    @test AdventOfCode2022.Day01.day01() == [74711, 209481]
end

@testset "Day 2" begin
    @test AdventOfCode2022.Day02.day02() == [13565, 12424]
end

@testset "Day 3" begin
    sample = "vJrwpWtwJgWrhcsFMMfFFhFp\n" *
             "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\n" *
             "PmmdzqPrVvPwwTWBwg\n" *
             "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\n" *
             "ttgJtRGJQctTZtZT\n" *
             "CrZsJsPPZsGzwwsLwLmpwMDw\n"
    @test AdventOfCode2022.Day03.day03(sample) == [157, 70]
    @test AdventOfCode2022.Day03.day03() == [7831, 2683]
end

@testset "Day 4" begin
    @test AdventOfCode2022.Day04.day04() == [515, 883]
end