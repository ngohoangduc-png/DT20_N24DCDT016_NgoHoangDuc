include("src/DeTai.jl")
using .DeTai

println(DeTai.search([5, 9, 12], 5))
println(DeTai.search([5, 9, 12], 8))