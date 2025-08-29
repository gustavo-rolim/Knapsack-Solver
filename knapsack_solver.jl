#!/usr/bin/env julia
using ArgParse, CSV, DataFrames

struct KnapsackInstance
    values::Vector{Int}
    weights::Vector{Int}
    capacity::Int
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--file"
        help = ".csv file with knapsack instance"
        arg_type = String
        required = true
    end

    return parse_args(s)
end

function read_instance_data(filename::String)::KnapsackInstance
    #----- Read the .csv file and inputs the data 

    df = CSV.read(filename, DataFrame)

    #----- Extract values, weights, and capacity

    values = Vector{Int}(df.Value)
    weights = Vector{Int}(df.Weight)
    capacity = df.Capacity[1]
  
    return KnapsackInstance(values, weights, capacity)
end

function solve_knapsack(inst::KnapsackInstance)
    #----- Solve the 0/1 Knapsack Problem

    n = length(inst.weights)
    C = inst.capacity
    dp = zeros(Float64, n+1, C+1)

    #----- Build dynamic programming table

    for i in 1:n
        for w in 0:C
            if inst.weights[i] <= w
                dp[i+1, w+1] = max(dp[i, w+1], inst.values[i] + dp[i, w+1 - inst.weights[i]])
            else
                dp[i+1, w+1] = dp[i, w+1]
            end
        end
    end

    # Backtracking to recover solution

    selected = Int[]
    w = C

    for i in n:-1:1
        if dp[i+1, w+1] != dp[i, w+1]
            push!(selected, i)
            w -= inst.weights[i]
        end
    end

    return dp[n+1, C+1], reverse(selected)
end

function main_knapsack()
    #----- Parse command line arguments
    
    args = parse_commandline()
    filename = args["file"]

    #----- Read the problem file

    inst = read_instance_data(filename)

    #----- Solve the problem instance

    start_time = time()
    opt_value, selected = solve_knapsack(inst)
    elapsed = time() - start_time

    #----- Round the elapsed time to three decimals

    elapsed = round(elapsed, digits = 3)

    #----- Print the final result

    println("Optimal objective: $opt_value")
    println("Selected items: ", selected)
    println("Run time: $elapsed")
end

main_knapsack()