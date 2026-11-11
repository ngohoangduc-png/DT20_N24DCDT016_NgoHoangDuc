include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

function in_bang_lan_vet(bang_lan_vet)
    println("  ┌───────┬───────┬───────┬───────┬─────────┐")
    println("  │ Bước  │   l   │   r   │  mid  │ a[mid]  │")
    println("  ├───────┼───────┼───────┼───────┼─────────┤")
    for (i, row) in enumerate(bang_lan_vet)
        l, r, mid, val = row
        @printf("  │ %-5d │ %-5d │ %-5d │ %-5d │ %-7d │\n", i, l, r, mid, val)
    end
    println("  └───────┴───────┴───────┴───────┴─────────┘")
end

function chay_minh_hoa(ten_ca::String, a::Vector{Int}, x::Int, exp_pos::Int)
    println("================================================================================")
    println("  CHẠY MINH HỌA: $ten_ca")
    println("================================================================================")
    println("  • Mảng a     : ", a)
    println("  • Độ dài n   : ", length(a))
    println("  • Khóa tìm x : ", x)
    println("  • Kỳ vọng    : Vị trí = $exp_pos")
    println("--------------------------------------------------------------------------------")
    
    vi_tri, bang, so_buoc = lan_vet_nhi_phan(a, x)
    
    println("  BẢNG LẦN VẾT TỪNG BƯỚC (Theo Bảng 2.9 Giáo trình):")
    in_bang_lan_vet(bang)
    
    # Đối chứng với tìm kiếm tuyến tính
    pos_tt, buoc_tt = tim_tuyen_tinh(a, x)
    
    println("  KẾT QUẢ THỰC TẾ:")
    println("  • Vị trí tìm thấy (1-based) : $vi_tri (Expected: $exp_pos) => ", vi_tri == exp_pos ? "ĐẠT [PASS]" : "SAI [FAIL]")
    println("  • Số lần xét mid (nhị phân) : $so_buoc bước")
    println("  • Số phép so sánh (tuyến tính) : $buoc_tt bước")
    println("  • Tỷ lệ tiết kiệm số bước    : ", buoc_tt > 0 ? @sprintf("%.1f lần", buoc_tt / max(1, so_buoc)) : "N/A")
    println()
end

function main()
    println("╔══════════════════════════════════════════════════════════════════════════════╗")
    println("║               HỌC VIỆN CÔNG NGHỆ BƯU CHÍNH VIỄN THÔNG                        ║")
    println("║                   CƠ SỞ TẠI THÀNH PHỐ HỒ CHÍ MINH                            ║")
    println("║             BÁO CÁO ĐỒ ÁN MÔN CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT                 ║")
    println("║  Đề tài: DT020 - Tìm kiếm nhị phân trên mảng đã tăng                         ║")
    println("║  Sinh viên: Ngô Hoàng Đức    MSSV: N24DCDT016    Lớp: D24CQDT01-N            ║")
    println("║  Giảng viên hướng dẫn: ThS. Hồ Nhựt Minh                                     ║")
    println("╚══════════════════════════════════════════════════════════════════════════════╝")
    println()

    # Dữ liệu 2 ví dụ chuẩn trên phiếu đề tài
    a_chuan = [2, 5, 8, 12, 16, 23, 38, 56, 72, 91]
    
    # 1. Ví dụ 1 trên phiếu: x = 23 (tìm thấy)
    chay_minh_hoa("VÍ DỤ 1 TRÊN PHIẾU (Khóa tồn tại trong mảng)", a_chuan, 23, 6)

    # 2. Ví dụ 2 trên phiếu: x = 30 (vắng mặt)
    chay_minh_hoa("VÍ DỤ 2 TRÊN PHIẾU (Khóa vắng mặt trong mảng)", a_chuan, 30, 0)

    # Hỗ trợ truyền tham số dòng lệnh nếu người dùng muốn thử dữ liệu tùy biến
    if length(ARGS) >= 2
        println("================================================================================")
        println("  CHẠY VỚI DỮ LIỆU TRUYỀN TỪ DÒNG LỆNH:")
        println("================================================================================")
        try
            x_custom = parse(Int, ARGS[1])
            a_custom = [parse(Int, s) for s in ARGS[2:end]]
            chay_minh_hoa("DỮ LIỆU TỰ NHẬP TỪ DÒNG LỆNH", a_custom, x_custom, -1)
        catch e
            println("  Lỗi định dạng tham số: ", e)
        end
    end
end

main()
