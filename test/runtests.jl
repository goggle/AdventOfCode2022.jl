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

@testset "Day 8" begin
    sample = "30373\n" *
             "25512\n" *
             "65332\n" *
             "33549\n" *
             "35390\n"
    @test AdventOfCode2022.Day08.day08(sample) == [21, 8]
    @test AdventOfCode2022.Day08.day08() == [1818, 368368]
end

@testset "Day 9" begin
    sample = "R 4\n" *
             "U 4\n" *
             "L 3\n" *
             "D 1\n" *
             "R 4\n" *
             "D 1\n" *
             "L 5\n" *
             "R 2\n"
    sample2 = "R 5\n" *
              "U 8\n" *
              "L 8\n" *
              "D 3\n" *
              "R 17\n" *
              "D 10\n" *
              "L 25\n" *
              "U 20\n"
    @test AdventOfCode2022.Day09.day09(sample) == [13, 1]
    @test AdventOfCode2022.Day09.day09(sample2) == [88, 36]
    @test AdventOfCode2022.Day09.day09() == [5907, 2303]
end

@testset "Day 10" begin
    sample = "addx 15\n" *
             "addx -11\n" *
             "addx 6\n" *
             "addx -3\n" *
             "addx 5\n" *
             "addx -1\n" *
             "addx -8\n" *
             "addx 13\n" *
             "addx 4\n" *
             "noop\n" *
             "addx -1\n" *
             "addx 5\n" *
             "addx -1\n" *
             "addx 5\n" *
             "addx -1\n" *
             "addx 5\n" *
             "addx -1\n" *
             "addx 5\n" *
             "addx -1\n" *
             "addx -35\n" *
             "addx 1\n" *
             "addx 24\n" *
             "addx -19\n" *
             "addx 1\n" *
             "addx 16\n" *
             "addx -11\n" *
             "noop\n" *
             "noop\n" *
             "addx 21\n" *
             "addx -15\n" *
             "noop\n" *
             "noop\n" *
             "addx -3\n" *
             "addx 9\n" *
             "addx 1\n" *
             "addx -3\n" *
             "addx 8\n" *
             "addx 1\n" *
             "addx 5\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx -36\n" *
             "noop\n" *
             "addx 1\n" *
             "addx 7\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx 2\n" *
             "addx 6\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx 1\n" *
             "noop\n" *
             "noop\n" *
             "addx 7\n" *
             "addx 1\n" *
             "noop\n" *
             "addx -13\n" *
             "addx 13\n" *
             "addx 7\n" *
             "noop\n" *
             "addx 1\n" *
             "addx -33\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx 2\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx 8\n" *
             "noop\n" *
             "addx -1\n" *
             "addx 2\n" *
             "addx 1\n" *
             "noop\n" *
             "addx 17\n" *
             "addx -9\n" *
             "addx 1\n" *
             "addx 1\n" *
             "addx -3\n" *
             "addx 11\n" *
             "noop\n" *
             "noop\n" *
             "addx 1\n" *
             "noop\n" *
             "addx 1\n" *
             "noop\n" *
             "noop\n" *
             "addx -13\n" *
             "addx -19\n" *
             "addx 1\n" *
             "addx 3\n" *
             "addx 26\n" *
             "addx -30\n" *
             "addx 12\n" *
             "addx -1\n" *
             "addx 3\n" *
             "addx 1\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx -9\n" *
             "addx 18\n" *
             "addx 1\n" *
             "addx 2\n" *
             "noop\n" *
             "noop\n" *
             "addx 9\n" *
             "noop\n" *
             "noop\n" *
             "noop\n" *
             "addx -1\n" *
             "addx 2\n" *
             "addx -37\n" *
             "addx 1\n" *
             "addx 3\n" *
             "noop\n" *
             "addx 15\n" *
             "addx -21\n" *
             "addx 22\n" *
             "addx -6\n" *
             "addx 1\n" *
             "noop\n" *
             "addx 2\n" *
             "addx 1\n" *
             "noop\n" *
             "addx -10\n" *
             "noop\n" *
             "noop\n" *
             "addx 20\n" *
             "addx 1\n" *
             "addx 2\n" *
             "addx 2\n" *
             "addx -6\n" *
             "addx -11\n" *
             "noop\n" *
             "noop\n" *
             "noop\n"
    @test AdventOfCode2022.Day10.day10(sample)[1] == 13140
    p1, p2 = AdventOfCode2022.Day10.day10()
    @test p1 == 13740
    @test p2 == "████ █  █ ███  ███  ████ ████  ██  █    \n" *
                "   █ █  █ █  █ █  █ █    █    █  █ █    \n" *
                "  █  █  █ █  █ █  █ ███  ███  █    █    \n" *
                " █   █  █ ███  ███  █    █    █    █    \n" *
                "█    █  █ █    █ █  █    █    █  █ █    \n" *
                "████  ██  █    █  █ █    ████  ██  ████ \n"
end

@testset "Day 11" begin
    sample = "Monkey 0:\n" *
             "  Starting items: 79, 98\n" *
             "  Operation: new = old * 19\n" *
             "  Test: divisible by 23\n" *
             "    If true: throw to monkey 2\n" *
             "    If false: throw to monkey 3\n" *
             "\n" *
             "Monkey 1:\n" *
             "  Starting items: 54, 65, 75, 74\n" *
             "  Operation: new = old + 6\n" *
             "  Test: divisible by 19\n" *
             "    If true: throw to monkey 2\n" *
             "    If false: throw to monkey 0\n" *
             "\n" *
             "Monkey 2:\n" *
             "  Starting items: 79, 60, 97\n" *
             "  Operation: new = old * old\n" *
             "  Test: divisible by 13\n" *
             "    If true: throw to monkey 1\n" *
             "    If false: throw to monkey 3\n" *
             "\n" *
             "Monkey 3:\n" *
             "  Starting items: 74\n" *
             "  Operation: new = old + 3\n" *
             "  Test: divisible by 17\n" *
             "    If true: throw to monkey 0\n" *
             "    If false: throw to monkey 1\n"
    @test AdventOfCode2022.Day11.day11(sample) == [10605, 2713310158]
    @test AdventOfCode2022.Day11.day11() == [110888, 25590400731]
end

@testset "Day 12" begin
    sample = "Sabqponm\n" *
             "abcryxxl\n" *
             "accszExk\n" *
             "acctuvwj\n" *
             "abdefghi\n"
    @test AdventOfCode2022.Day12.day12(sample) == [31, 29]
    @test AdventOfCode2022.Day12.day12() == [420, 414]
end

@testset "Day 13" begin
    sample = "[1,1,3,1,1]\n" *
             "[1,1,5,1,1]\n" *
             "\n" *
             "[[1],[2,3,4]]\n" *
             "[[1],4]\n" *
             "\n" *
             "[9]\n" *
             "[[8,7,6]]\n" *
             "\n" *
             "[[4,4],4,4]\n" *
             "[[4,4],4,4,4]\n" *
             "\n" *
             "[7,7,7,7]\n" *
             "[7,7,7]\n" *
             "\n" *
             "[]\n" *
             "[3]\n" *
             "\n" *
             "[[[]]]\n" *
             "[[]]\n" *
             "\n" *
             "[1,[2,[3,[4,[5,6,7]]]],8,9]\n" *
             "[1,[2,[3,[4,[5,6,0]]]],8,9]\n"
    @test AdventOfCode2022.Day13.day13(sample) == [13, 140]
    @test AdventOfCode2022.Day13.day13() == [5659, 22110]
end

@testset "Day 14" begin
    sample = "498,4 -> 498,6 -> 496,6\n" *
             "503,4 -> 502,4 -> 502,9 -> 494,9\n"
    @test AdventOfCode2022.Day14.day14(sample) == [24, 93]
    @test AdventOfCode2022.Day14.day14() == [793, 24166]
end

@testset "Day 15" begin
    @test AdventOfCode2022.Day15.day15() == [5166077, 13071206703981]
end

@testset "Day 16" begin
    sample = "Valve AA has flow rate=0; tunnels lead to valves DD, II, BB\n" *
             "Valve BB has flow rate=13; tunnels lead to valves CC, AA\n" *
             "Valve CC has flow rate=2; tunnels lead to valves DD, BB\n" *
             "Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE\n" *
             "Valve EE has flow rate=3; tunnels lead to valves FF, DD\n" *
             "Valve FF has flow rate=0; tunnels lead to valves EE, GG\n" *
             "Valve GG has flow rate=0; tunnels lead to valves FF, HH\n" *
             "Valve HH has flow rate=22; tunnel leads to valve GG\n" *
             "Valve II has flow rate=0; tunnels lead to valves AA, JJ\n" *
             "Valve JJ has flow rate=21; tunnel leads to valve II\n"
    @test AdventOfCode2022.Day16.day16(sample) == [1651, 1707]
    @test AdventOfCode2022.Day16.day16() == [1792, 2587]
end