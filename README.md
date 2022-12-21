[![CI](https://github.com/goggle/AdventOfCode2022.jl/workflows/CI/badge.svg)](https://github.com/goggle/AdventOfCode2022.jl/actions?query=workflow%3ACI+branch%3Amaster)
<!-- [![Code coverage](https://codecov.io/gh/goggle/AdventOfCode2022.jl/branch/master/graphs/badge.svg?branch=master)](https://codecov.io/github/goggle/AdventOfCode2022.jl?branch=master) -->

# AdventOfCode2022.jl

This Julia package contains my solutions for [Advent of Code 2022](https://adventofcode.com/2022/).

## Overview

| Day | Problem | Time | Allocated memory | Source |
|----:|:-------:|-----:|-----------------:|:------:|
| 1 | [:white_check_mark:](https://adventofcode.com/2022/day/1) | 603.795 μs | 231.53 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day01.jl) |
| 2 | [:white_check_mark:](https://adventofcode.com/2022/day/2) | 1.838 ms | 1.09 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day02.jl) |
| 3 | [:white_check_mark:](https://adventofcode.com/2022/day/3) | 1.194 ms | 811.64 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day03.jl) |
| 4 | [:white_check_mark:](https://adventofcode.com/2022/day/4) | 1.512 ms | 522.12 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day04.jl) |
| 5 | [:white_check_mark:](https://adventofcode.com/2022/day/5) | 611.487 μs | 329.89 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day05.jl) |
| 6 | [:white_check_mark:](https://adventofcode.com/2022/day/6) | 2.331 ms | 2.85 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day06.jl) |
| 7 | [:white_check_mark:](https://adventofcode.com/2022/day/7) | 503.759 μs | 479.67 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day07.jl) |
| 8 | [:white_check_mark:](https://adventofcode.com/2022/day/8) | 1.312 ms | 804.73 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day08.jl) |
| 9 | [:white_check_mark:](https://adventofcode.com/2022/day/9) | 11.756 ms | 5.73 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day09.jl) |
| 10 | [:white_check_mark:](https://adventofcode.com/2022/day/10) | 87.203 μs | 94.35 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day10.jl) |
| 11 | [:white_check_mark:](https://adventofcode.com/2022/day/11) | 132.951 ms | 68.31 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day11.jl) |
| 12 | [:white_check_mark:](https://adventofcode.com/2022/day/12) | 623.635 μs | 1.02 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day12.jl) |
| 13 | [:white_check_mark:](https://adventofcode.com/2022/day/13) | 4.571 ms | 2.31 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day13.jl) |
| 14 | [:white_check_mark:](https://adventofcode.com/2022/day/14) | 81.430 ms | 2.48 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day14.jl) |
| 15 | [:white_check_mark:](https://adventofcode.com/2022/day/15) | 30.348 ms | 719.27 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day15.jl) |
| 16 | [:white_check_mark:](https://adventofcode.com/2022/day/16) | 6.051 s | 6.84 GiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day16.jl) |
| 17 | [:white_check_mark:](https://adventofcode.com/2022/day/17) | 842.701 ms | 574.77 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day17.jl) |
| 18 | [:white_check_mark:](https://adventofcode.com/2022/day/18) | 6.194 ms | 2.94 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day18.jl) |
| 20 | [:white_check_mark:](https://adventofcode.com/2022/day/20) | 535.589 ms | 1.78 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2022.jl/blob/master/src/day20.jl) |


The benchmarks have been measured on this machine:
```
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-13.0.0 (ORCJIT, skylake)
```


## Installation and Usage

Make sure you have [Julia 1.8 or newer](https://julialang.org/downloads/)
installed on your system.


### Installation

Start Julia and enter the package REPL by typing `]`. Create a new
environment:
```julia
(@v1.8) pkg> activate aoc
```

Install `AdventOfCode2022.jl`:
```
(aoc) pkg> add https://github.com/goggle/AdventOfCode2022.jl
```

Go back to the Julia REPL by pushing the `backspace` button.


### Usage

First, activate the package:
```julia
julia> using AdventOfCode2022
```

Each puzzle can now be run with `dayXY()`:
```julia
julia> day01()
2-element Vector{Int64}:
 74711
 209481
```

This will use my personal input. If you want to use another input, provide it
to the `dayXY` method as a string. You can also use the `readInput` method
to read your input from a text file:
```julia
julia> input = readInput("/path/to/input.txt")

julia> AdventOfCode2022.Day01.day01(input)
2-element Vector{Int64}:
 74711
 209481
```
