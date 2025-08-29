#!/usr/bin/env julia
using ArgParse, CSV, DataFrames

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--n"
            help = "number of items"
            arg_type = Int
            required = true
        "--min_val"
            help = "minimum item value"
            arg_type = Int
            required = true
        "--max_val"
            help = "maximum item value"
            arg_type = Int
            required = true
        "--min_weight"
            help = "minimum item weight"
            arg_type = Int
            required = true
        "--max_weight"
            help = "maximum item weight"
            arg_type = Int
            required = true
        "--capacity"
            help = "knapsack capacity"
            arg_type = Int
            required = true
        "--filename"
            help = "output CSV file"
            arg_type = String
            required = true
    end

    return parse_args(s)
end

function generate_kp_instance(n::Integer, min_val::Integer, max_val::Integer,
    min_weight::Integer, max_weight::Integer, capacity::Integer,
    filename::String)
    #----- Feasibility check

    if min_weight > max_weight
        error("❌ Please, check the weight interval.")
    end

    if min_val > max_val
        error("❌ Please, check the reward interval")
    end

    if min_weight > capacity
        error("❌ Infeasible instance: all item weights exceed the knapsack capacity = $capacity")
    elseif max_weight > capacity
        @warn "Some items may exceed the knapsack capacity = $capacity"
    end

    #----- Random values and weights 

    values = rand(min_val:max_val, n)
    weights = rand(min_weight:max_weight, n)

    #----- Build a data frame to store items' values and weights 

    df = DataFrame(Item = 1:n,
    Value = values,
    Weight = weights, 
    Capacity = fill(capacity, n))

    #----- Save the data frame into a .csv file 

    CSV.write(filename, df)
end

function main()
    #----- Parse command line arguments 

    args = parse_commandline()

    #----- Generate an instance example

    generate_kp_instance(args["n"], args["min_val"], args["max_val"],
    args["min_weight"], args["max_weight"], args["capacity"], args["filename"])
end

main()