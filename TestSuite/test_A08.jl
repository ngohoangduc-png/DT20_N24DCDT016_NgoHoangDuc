include("src/DeTai.jl")
using .DeTai

println("Expected: Input validation error – array not strictly increasing")

try
    # Input violates strict increasing condition, should raise ArgumentError
    DeTai.search([5,9,9], 9)
catch e
    println("Actual: ", e)
end
