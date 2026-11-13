include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

println("=== CA BIEN 3 (BIEN03 / CA BAT BUOC 5C TREN PHIEU) ===")
println("Mo ta: Mang 1 phan tu, khoa khong co mat trong mang (vang mat)")
a = [2]
x = 5
println("Mang a: ", a)
println("Khoa x: ", x)
println("Expected: Vi tri = 0, so buoc = 1 (doan tim bi co lai thanh l > r)")

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
println("• Ham tim_nhi_phan([2], 5)      : ", vi_tri, " -> ", vi_tri == 0 ? "DAT [PASS]" : "SAI [FAIL]")
println("• So lan xet mid                : ", so_buoc, " buoc")
println("• Trang thai ket thuc           : l = 2 > r = 1 (doan tim rong)")

