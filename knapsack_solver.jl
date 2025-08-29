function solve_knapsack(capacity::Int, weight::Vector{Int}, reward::Vector{<:Real})
    #----- Solve knapsack problem with dynamic programming

    n = length(weight)
    dp = zeros(Float64, n+1, capacity+1)

    #----- Build dynamic programming table
    for i in 1:n 
        for w in 1:capacity+1
            current_capacity = w - 1 
            if weight[i] <= current_capacity
                dp[i+1, w] = max(dp[i, w], reward[i] + dp[i, w - weight[i]])
            else
                dp[i+1, w] = dp[i, w]
            end
        end
    end

    #----- Backtracking 
    w = capacity + 1
    selected = Int[]

    for i in n:-1:1
        if dp[i+1, w] != dp[i, w]
            push!(selected, i)
            w -= weight[i]
            if w < 1
                break
            end
        end
    end

    return dp[n+1, capacity+1], reverse(selected)
end

function Main_knapsack()
    #----- Example
    lmax = 5
    l = [1, 2, 2, 3]
    m = [15.2, 12.0, 5.0, 5.7]

    opt_val, J = solve_knapsack(lmax, l, m)

    println("Optimal value: ", opt_val)
    println("Items chosen: ", J)
end

Main_knapsack()