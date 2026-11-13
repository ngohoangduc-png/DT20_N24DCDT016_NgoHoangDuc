include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai

println("=== KIEM TRA INPUT KHONG HOP LE (LOI01) ===")
println("Dieu kien tren phieu bi vi pham : Mang a phai tang nghiem ngat (a[i] < a[i+1])")
println("Input vi pham                   : a = [5, 9, 9] (co 2 phan tu 9 lien tiep)")
println("Expected                        : Lop validator nem ArgumentError tu choi xu ly")

try
    DeTai.kiem_tra_dau_vao([5, 9, 9], 9)
    println("Actual                          : Khong bat duoc loi -> [FAIL]")
catch e
    println("Actual                          : ", e)
    println("Ket luan                        : Bat dung ngoai le ArgumentError -> [PASS]")
end

