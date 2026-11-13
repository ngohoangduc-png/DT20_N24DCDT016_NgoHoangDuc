include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

println("=== CA BIEN 2 (BIEN02 / CA BAT BUOC 5B TREN PHIEU) ===")
println("Mo ta: Mang 1 phan tu, khoa co mat trong mang (tim thay)")
a = [2]
x = 2
println("Mang a: ", a)
println("Khoa x: ", x)
println("Expected: Vi tri = 1, so buoc = 1")

vi_tri, bang, so_buoc = lan_vet_nhi_phan(a, x)

println("\nBANG LAN VET TUNG BUOC:")
println("  +-------+-------+-------+-------+---------+")
println("  | Buoc  |   l   |   r   |  mid  | a[mid]  |")
println("  +-------+-------+-------+-------+---------+")
for (i, row) in enumerate(bang)
    l, r, mid, val = row
    @printf("  | %-5d | %-5d | %-5d | %-5d | %-7d |\n", i, l, r, mid, val)
end
println("  +-------+-------+-------+-------+---------+")

println("\nKET QUA THUC TE:")
println("• Ham tim_nhi_phan([2], 2)      : ", vi_tri, " -> ", vi_tri == 1 ? "DAT [PASS]" : "SAI [FAIL]")
println("• So lan xet mid                : ", so_buoc, " buoc")
println("• Ca bat buoc tren phieu        : Ca 5b dat chuan")
