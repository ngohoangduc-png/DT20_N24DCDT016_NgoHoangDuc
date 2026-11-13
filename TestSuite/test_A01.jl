include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

function in_bang_lan_vet(bang_lan_vet)
    println("  +-------+-------+-------+-------+---------+")
    println("  | Buoc  |   l   |   r   |  mid  | a[mid]  |")
    println("  +-------+-------+-------+-------+---------+")
    for (i, row) in enumerate(bang_lan_vet)
        l, r, mid, val = row
        @printf("  | %-5d | %-5d | %-5d | %-5d | %-7d |\n", i, l, r, mid, val)
    end
    println("  +-------+-------+-------+-------+---------+")
end

println("=== VI DU 1 TREN PHIEU DE TAI DT020 (VD01) ===")
a = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
x = 23
println("Mang a: ", a)
println("Khoa x: ", x)
println("Expected: Vi tri = 6 (Theo phieu de tai)")

vi_tri, bang, so_buoc = lan_vet_nhi_phan(a, x)

println("\nBANG LAN VET TUNG BUOC:")
in_bang_lan_vet(bang)

pos_tt, buoc_tt = tim_tuyen_tinh(a, x)
println("\nKET QUA THUC TE:")
println("• Vi tri tim thay (1-based)   : ", vi_tri, " -> ", vi_tri == 6 ? "DAT [PASS]" : "SAI [FAIL]")
println("• So lan xet mid (nhi phan)   : ", so_buoc, " buoc")
println("• So phep so sanh (tuyen tinh): ", buoc_tt, " buoc")

