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

@testset "Day 5" begin
    @test AdventOfCode2022.Day05.day05() == ["JDTMRWCQJ", "VHJDDCWRD"]
end

@testset "Day 6" begin
    @test AdventOfCode2022.Day06.day06() == [1833, 3425]
end

@testset "Day 7" begin
    sample = "\$ cd /\n" *
             "\$ ls\n" *
             "dir a\n" *
             "14848514 b.txt\n" *
             "8504156 c.dat\n" *
             "dir d\n" *
             "\$ cd a\n" *
             "\$ ls\n" *
             "dir e\n" *
             "29116 f\n" *
             "2557 g\n" *
             "62596 h.lst\n" *
             "\$ cd e\n" *
             "\$ ls\n" *
             "584 i\n" *
             "\$ cd ..\n" *
             "\$ cd ..\n" *
             "\$ cd d\n" *
             "\$ ls\n" *
             "4060174 j\n" *
             "8033020 d.log\n" *
             "5626152 d.ext\n" *
             "7214296 k\n"
    @test AdventOfCode2022.Day07.day07(sample) == [95437, 24933642]
    @test AdventOfCode2022.Day07.day07() == [1543140, 1117448]
end