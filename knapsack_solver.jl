function solve_knapsack(capacity::Int, l::Vector{Int}, reward::Vector{<:Real})
    #----- Solve knapsack problem with dynamic programming

    n = length(l)
    dp = zeros(Float64, n+1, capacity+1)

    #----- Build dynamic programming table
    for i in 1:n 
        for w in 1:capacity+1
            current_capacity = w - 1 
            if l[i] <= current_capacity
                dp[i+1, w] = max(dp[i, w], reward[i] + dp[i, w - l[i]])
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
            w -= l[i]
            if w < 1
                break
            end
        end
    end

    return dp[n+1, capacity+1], reverse(selected)
end