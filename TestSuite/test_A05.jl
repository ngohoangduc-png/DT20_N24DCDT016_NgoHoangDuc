include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

println("=== CA BIEN 1 (BIEN01 / CA BAT BUOC 5A TREN PHIEU) ===")
println("Mo ta: Mang rong (n = 0)")
a = Int[]
x = 10
println("Mang a: ", a)
println("Khoa x: ", x)
println("Expected: Vi tri = 0, so buoc = 0 (khong gay loi BoundsError)")

vi_tri, bang, so_buoc = lan_vet_nhi_phan(a, x)

println("\nBANG LAN VET: ", isempty(bang) ? "[RONG - Khong xet mid vi l > r ngay tu dau]" : bang)

println("\nKET QUA THUC TE:")
println("• Ham tim_nhi_phan(Int[], 10)   : ", vi_tri, " -> ", vi_tri == 0 ? "DAT [PASS]" : "SAI [FAIL]")
println("• So lan xet mid                : ", so_buoc, " buoc")
println("• Do an toan bien               : XU LY DUNG, KHONG GAP LOI")
