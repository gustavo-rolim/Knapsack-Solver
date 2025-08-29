# Knapsack-Solver

This repository provides a dynamic programming solver in Julia for the **0-1 Knapsack Problem**.

The solver contains two main scripts:

1. **gen.jl** — Generates a random knapsack instance and saves it as a `.csv` file. An accompanying file, **example.csv**, is provided to illustrate the expected CSV format and can be used to test the solver immediately. 
2. **knapsack_solver.jl** — Reads a `.csv` instance and solves it using dynamic programming. The algorithm runs in pseudo-polynomial time **O(W·n)**, where **W** is the knapsack capacity and **n** is the number of items in the instance. The solver outputs the optimal total value and the list of selected items.

-- 

## Usage 

### 1. Generate an Instance

1. Run the generator with the following syntax:

```bash
julia gen.jl <n> <min_val> <max_val> <min_weight> <max_weight> <capacity> <filename>
```

2. Alternatively, use the provided **example.csv** file. 

### Solve the instance 

1. Run the solver by passing the filename as an argument: 

```bash
julia knapsack_solver.jl <filename>
```

--

## 2. Output example

Optimal objective: 27.0
Selected items: [5, 6, 7]
Run time: 0.0 

## 3. Requirements

- Julia 1.11 or later  
- Packages: `CSV`, `DataFrames`, `ArgParse`