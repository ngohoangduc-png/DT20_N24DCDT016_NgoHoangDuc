# ĐỒ ÁN MÔN HỌC: CẤU TRÚC DỮ LIỆU VÀ GIẢI THUẬT (INT13185)
# ĐỀ TÀI DT020 — TÌM KIẾM NHỊ PHÂN TRÊN MẢNG ĐÃ TĂNG

## Thông tin sinh viên và căn cứ đề tài

- **Họ và tên sinh viên:** Ngô Hoàng Đức
- **Mã số sinh viên (MSSV):** N24DCDT016
- **Lớp:** D24CQDT01-N
- **Mã đề tài:** DT020
- **Tên đề tài:** Tìm kiếm nhị phân trên mảng đã tăng
- **Giảng viên hướng dẫn:** ThS. Hồ Nhựt Minh (Nhóm 03)
- **Học phần:** Cấu trúc dữ liệu và giải thuật (INT13185)
- **Giáo trình căn cứ:** `Giao-trinh-Cau-truc-du-lieu-va-Giai-thuat-INT1306.pdf`
  - Chương 2, Mục 2.6.2 (Tìm kiếm nhị phân)
  - Bảng 2.9 (Minh họa các bước tìm kiếm nhị phân)
  - Mục 2.8 Bài 14
  - Trang in: 50–52, 61; Trang PDF: 62–64, 73
- **Môi trường & Ngôn ngữ:** Julia 1.12.7 (hoặc Julia 1.10+)

---

## Cấu trúc thư mục mã nguồn

```
N24DCDT016_DT020_NgoHoangDuc_MaNguon/
├── .gitignore
├── README.md
├── demo.jl                   # Chương trình chạy minh họa 2 ví dụ và nhập liệu
├── src/
│   └── DeTai.jl              # Module chứa toàn bộ thuật toán và validator
├── test/
│   └── runtests.jl           # Bộ kiểm thử tự động gồm 12 ca kiểm thử độc lập
└── docs/
    └── anh_ket_qua/          # Thư mục chứa 11 ảnh minh chứng thực thi (A01 - A11)
        └── README.md
```

---

## Hướng dẫn chạy chương trình

Mở terminal (PowerShell hoặc Command Prompt) tại thư mục mã nguồn:

```powershell
# 1. Kiểm tra phiên bản Julia
julia --version

# 2. Chạy chương trình minh họa (Ví dụ 1 và Ví dụ 2 trên phiếu đề tài)
julia --startup-file=no demo.jl

# 3. Chạy với dữ liệu tùy biến truyền từ dòng lệnh (Cú pháp: julia demo.jl <x> <a1> <a2> ... <an>)
julia --startup-file=no demo.jl 15 2 5 10 15 20 25

# 4. Chạy toàn bộ bộ kiểm thử 12 ca độc lập
julia --startup-file=no test/runtests.jl
```

---

## Tóm tắt kết quả kiểm thử

- **Tổng số ca kiểm thử độc lập:** 12 ca (`TC01` đến `TC12`).
- **Số lượng phép kiểm tra (`@test` / `@test_throws`):** 36/36 phép kiểm đạt `Pass`.
- **Tỷ lệ đạt:** 100% (Pass).
- **Các ca tiêu biểu:**
  - `TC01`: Ví dụ 1 trên phiếu ($x = 23 \rightarrow$ vị trí 6, 3 bước xét).
  - `TC02`: Ví dụ 2 trên phiếu ($x = 30 \rightarrow$ vị trí 0, 4 bước xét).
  - `TC03 - TC04`: Khóa ở hai đầu mút mảng ($x = 1 \rightarrow 1, x = 5 \rightarrow 3$).
  - `TC05 - TC07`: Các ca biên (Mảng rỗng, mảng 1 phần tử tìm thấy/không tìm thấy).
  - `TC08`: Kiểm tra bắt ngoại lệ khi dữ liệu vào vi phạm mảng tăng nghiêm ngặt (`ArgumentError`).
  - `TC11`: Khảo sát mảng lớn $n = 5000$, số bước tối đa $\le 13$ bước (nhanh hơn tuyến tính ~384 lần).
  - `TC12`: Đối chứng nhất quán giữa bản lặp và bản đệ quy.
