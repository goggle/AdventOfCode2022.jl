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
