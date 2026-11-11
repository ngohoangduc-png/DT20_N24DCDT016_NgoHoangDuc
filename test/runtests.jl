using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

@testset "Bộ kiểm thử đề tài DT020 - Tìm kiếm nhị phân trên mảng đã tăng" begin

    # TC01: Ví dụ 1 trên phiếu đề tài
    @testset "TC01 - Ví dụ 1 trên phiếu: Tìm thấy x=23 trong mảng 10 phần tử" begin
        a = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
        x = 23
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 6
        @test so_lan_xet == 3
        @test length(bang) == 3
        @test bang[1] == (1, 10, 5, 16)
        @test bang[2] == (6, 10, 8, 56)
        @test bang[3] == (6, 7, 6, 23)
        @test tim_nhi_phan(a, x) == 6
    end

    # TC02: Ví dụ 2 trên phiếu đề tài
    @testset "TC02 - Ví dụ 2 trên phiếu: Khóa x=30 vắng mặt" begin
        a = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
        x = 30
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 0
        @test so_lan_xet == 4
        @test length(bang) == 4
        @test bang[4] == (7, 7, 7, 38)
        @test tim_nhi_phan(a, x) == 0
    end

    # TC03: Ca tự thiết kế 1 - Khóa ở ngay đầu mảng
    @testset "TC03 - Khóa ở đầu mảng: [1, 3, 5], x=1" begin
        a = [1, 3, 5]
        x = 1
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 1
        @test tim_nhi_phan(a, x) == 1
    end

    # TC04: Ca tự thiết kế 2 - Khóa ở ngay cuối mảng
    @testset "TC04 - Khóa ở cuối mảng: [1, 3, 5], x=5" begin
        a = [1, 3, 5]
        x = 5
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 3
        @test tim_nhi_phan(a, x) == 3
    end

    # TC05: Ca biên 1 - Mảng rỗng
    @testset "TC05 - Ca biên: Mảng rỗng Int[], x=10" begin
        a = Int[]
        x = 10
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 0
        @test so_lan_xet == 0
        @test isempty(bang)
        @test tim_nhi_phan(a, x) == 0
    end

    # TC06: Ca biên 2 - Mảng 1 phần tử tìm thấy
    @testset "TC06 - Ca biên: Mảng một phần tử [2], x=2 (tìm thấy)" begin
        a = [2]
        x = 2
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 1
        @test so_lan_xet == 1
        @test bang[1] == (1, 1, 1, 2)
        @test tim_nhi_phan(a, x) == 1
    end

    # TC07: Ca biên 3 - Mảng 1 phần tử không tìm thấy
    @testset "TC07 - Ca biên: Mảng một phần tử [2], x=5 (không tìm thấy)" begin
        a = [2]
        x = 5
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 0
        @test so_lan_xet == 1
        @test bang[1] == (1, 1, 1, 2)
        @test tim_nhi_phan(a, x) == 0
    end

    # TC08: Kiểm tra input không hợp lệ (LOI01)
    @testset "TC08 - Bắt lỗi ngoại lệ khi mảng không tăng nghiêm ngặt" begin
        # Mảng chưa sắp xếp
        @test_throws ArgumentError kiem_tra_dau_vao([5, 2, 8], 2)
        # Mảng có phần tử trùng kề nhau
        @test_throws ArgumentError kiem_tra_dau_vao([1, 2, 2, 3], 2)
        # Mảng giảm dần
        @test_throws ArgumentError kiem_tra_dau_vao([9, 7, 5, 3], 5)
        # Khi gọi tim_nhi_phan trực tiếp trên mảng sai
        @test_throws ArgumentError tim_nhi_phan([3, 2, 1], 2)
    end

    # TC09: Khóa nhỏ hơn phần tử nhỏ nhất ngoài miền
    @testset "TC09 - Khóa nhỏ hơn phần tử nhỏ nhất ngoài miền: x < a[1]" begin
        a = [10, 20, 30, 40]
        x = 5
        @test tim_nhi_phan(a, x) == 0
    end

    # TC10: Khóa lớn hơn phần tử lớn nhất ngoài miền
    @testset "TC10 - Khóa lớn hơn phần tử lớn nhất ngoài miền: x > a[n]" begin
        a = [10, 20, 30, 40]
        x = 50
        @test tim_nhi_phan(a, x) == 0
    end

    # TC11: Mảng quy mô lớn (n = 5000), trường hợp xấu nhất O(log n)
    @testset "TC11 - Khảo sát mảng lớn n=5000, số bước tối đa <= 13" begin
        a = [2 * i for i in 1:5000] # Toàn số chẵn từ 2 đến 10000
        x = 5001 # Số lẻ, chắc chắn vắng mặt
        vi_tri, bang, so_lan_xet = lan_vet_nhi_phan(a, x)
        @test vi_tri == 0
        # log2(5000) ≈ 12.28 => floor(log2(5000)) + 1 = 13
        @test so_lan_xet <= 13
        # Đối chứng tìm kiếm tuyến tính phải tốn 5000 bước
        pos_tt, so_so_sanh = tim_tuyen_tinh(a, x)
        @test pos_tt == 0
        @test so_so_sanh == 5000
    end

    # TC12: Đối chứng tính nhất quán giữa bản lặp và bản đệ quy
    @testset "TC12 - Đối chứng nhất quán giữa bản lặp và bản đệ quy" begin
        a = [-15, -7, 0, 4, 9, 14, 25, 42, 60]
        for val in a
            pos_loop = tim_nhi_phan(a, val)
            pos_rec, do_sau = tim_nhi_phan_de_quy(a, val)
            @test pos_loop == pos_rec
            @test pos_loop > 0
        end
        # Test khóa không có
        pos_loop_absent = tim_nhi_phan(a, 999)
        pos_rec_absent, _ = tim_nhi_phan_de_quy(a, 999)
        @test pos_loop_absent == 0
        @test pos_rec_absent == 0
    end

end
