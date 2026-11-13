include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

println("=== CA TU THIET KE 2 (TK02 / CA BAT BUOC 4 TREN PHIEU) ===")
println("Mo ta: Khoa nam o ngay vi tri cuoi cung cua mang")
a = [5, 9, 12]
x = 12
println("Mang a: ", a)
println("Khoa x: ", x)
println("Expected: Vi tri = 3 (hoac search = true)")

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
println("• Ham search([5,9,12], 12)      : ", ket_qua_search)
println("• Vi tri tim thay (1-based)     : ", vi_tri, " -> ", vi_tri == 3 ? "DAT [PASS]" : "SAI [FAIL]")
println("• So lan xet mid                : ", so_buoc, " buoc")

