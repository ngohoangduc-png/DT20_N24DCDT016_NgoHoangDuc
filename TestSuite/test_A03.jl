include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

println("=== CA TU THIET KE 1 (TK01 / CA BAT BUOC 3 TREN PHIEU) ===")
println("Mo ta: Khoa nam o ngay vi tri dau tien cua mang")
a = [5, 9, 12]
x = 5
println("Mang a: ", a)
println("Khoa x: ", x)
println("Expected: Vi tri = 1 (hoac search = true)")

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

ket_qua_search = DeTai.search(a, x)
println("\nKET QUA THUC TE:")
println("• Ham search([5,9,12], 5)       : ", ket_qua_search)
println("• Vi tri tim thay (1-based)     : ", vi_tri, " -> ", vi_tri == 1 ? "DAT [PASS]" : "SAI [FAIL]")
println("• So lan xet mid                : ", so_buoc, " buoc")

