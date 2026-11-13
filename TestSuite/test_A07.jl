include("src/DeTai.jl")
using .DeTai
println("Biên hợp lệ thứ ba: giá trị không tồn tại trong mảng")
println(DeTai.search([5,9,12],7))
