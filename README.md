# Knapsack-Solver

This repository provides a dynamic programming solver in Julia for the **0-1 Knapsack Problem**.

The solver contains two main scripts:

1. **gen.jl** — Generates a random knapsack instance and saves it as a `.csv` file. An accompanying file, **example.csv**, is provided to illustrate the expected CSV format and can be used to test the solver immediately. 
2. **knapsack_solver.jl** — Reads a `.csv` instance and solves it using dynamic programming. The algorithm runs in pseudo-polynomial time **O(W·n)**, where **W** is the knapsack capacity and **n** is the number of items in the instance. The solver outputs the optimal total value and the list of selected items.

## Usage 

### Generate an Instance

1. Run the generator with the following syntax, e.g.:

```bash
julia gen.jl --n 8 --min_val 1 --max_val 15 --min_weight 1 --max_weight 10 --capacity 10 --filename example.csv
```

2. Alternatively, use the provided **example.csv** file. 

### Solve the instance 

1. Run the solver by passing the filename as an argument: 

```bash
julia knapsack_solver.jl --file example.csv
```

## Output example

Optimal objective: 27.0

Selected items: [5, 6, 7]

Run time: 0.0 

## Requirements

- Julia 1.11 or later  
- Packages: `CSV`, `DataFrames`, `ArgParse`