module DeTai

export kiem_tra_tang, kiem_tra_dau_vao, tim_nhi_phan, lan_vet_nhi_phan, 
       tim_tuyen_tinh, tim_nhi_phan_de_quy, giai_bai

"""
    kiem_tra_tang(a::Vector{Int})::Bool

Kiểm tra mảng số nguyên `a` có được sắp tăng nghiêm ngặt (Strictly Increasing) hay không.
Điều kiện: a[i] < a[i+1] với mọi 1 <= i < length(a).
"""
function kiem_tra_tang(a::Vector{Int})::Bool
    n = length(a)
    for i in 1:(n - 1)
        if a[i] >= a[i + 1]
            return false
        end
    end
    return true
end

"""
    kiem_tra_dau_vao(a::Vector{Int}, x::Int)::Bool

Kiểm tra hợp đồng đầu vào cho đề tài DT020:
- Kích thước mảng 0 <= n <= 10000
- Mảng phải tăng nghiêm ngặt
Ném ArgumentError nếu vi phạm điều kiện.
"""
function kiem_tra_dau_vao(a::Vector{Int}, x::Int)::Bool
    n = length(a)
    if n > 10000
        throw(ArgumentError("Kich thuoc mang vuot qua gioi han cho phep (n <= 10000)"))
    end
    if !kiem_tra_tang(a)
        throw(ArgumentError("Mang dau vao khong thoa man dieu kien tang nghiem ngat"))
    end
    return true
end

# Hỗ trợ nhận dữ liệu dạng tuple (a, x)
function kiem_tra_dau_vao(du_lieu::Tuple{Vector{Int}, Int})::Bool
    return kiem_tra_dau_vao(du_lieu[1], du_lieu[2])
end

"""
    tim_nhi_phan(a::Vector{Int}, x::Int)::Int

Thuật toán tìm kiếm nhị phân dạng vòng lặp (chỉ số 1-based, công thức mid = l + div(r-l, 2)).
Trả về vị trí chỉ số 1-based nếu tìm thấy; trả về 0 nếu không tìm thấy.
"""
function tim_nhi_phan(a::Vector{Int}, x::Int)::Int
    kiem_tra_dau_vao(a, x)
    l = 1
    r = length(a)
    while l <= r
        mid = l + div(r - l, 2)
        if a[mid] == x
            return mid
        elseif x < a[mid]
            r = mid - 1
        else
            l = mid + 1
        end
    end
    return 0
end

"""
    lan_vet_nhi_phan(a::Vector{Int}, x::Int)

Tìm kiếm nhị phân có ghi nhận lịch sử từng bước (lần vết theo Bảng 2.9 giáo trình).
Trả về tuple: (vi_tri, bang_lan_vet, so_lan_xet)
- vi_tri: chỉ số 1-based (hoặc 0 nếu vắng mặt)
- bang_lan_vet: mảng các bộ (l, r, mid, a[mid])
- so_lan_xet: tổng số lần tính mid và đọc a[mid]
"""
function lan_vet_nhi_phan(a::Vector{Int}, x::Int)
    kiem_tra_dau_vao(a, x)
    l = 1
    r = length(a)
    so_lan_xet = 0
    bang_lan_vet = Tuple{Int, Int, Int, Int}[]

    while l <= r
        so_lan_xet += 1
        mid = l + div(r - l, 2)
        push!(bang_lan_vet, (l, r, mid, a[mid]))

        if a[mid] == x
            return (mid, bang_lan_vet, so_lan_xet)
        elseif x < a[mid]
            r = mid - 1
        else
            l = mid + 1
        end
    end

    return (0, bang_lan_vet, so_lan_xet)
end

"""
    giai_bai(du_lieu)

Hàm chuẩn hóa theo khung đồ án cá nhân.
Nhận du_lieu là cặp (a, x), trả về kết quả lần vết (vi_tri, bang_lan_vet, so_lan_xet).
"""
function giai_bai(du_lieu::Tuple{Vector{Int}, Int})
    return lan_vet_nhi_phan(du_lieu[1], du_lieu[2])
end

"""
    tim_tuyen_tinh(a::Vector{Int}, x::Int)

Thuật toán tìm kiếm tuyến tính đối chứng.
Trả về tuple: (vi_tri, so_phep_so_sanh)
"""
function tim_tuyen_tinh(a::Vector{Int}, x::Int)
    for i in 1:length(a)
        if a[i] == x
            return (i, i)
        end
    end
    return (0, length(a))
end

"""
    tim_nhi_phan_de_quy(a::Vector{Int}, x::Int, l::Int=1, r::Int=length(a), do_sau::Int=1)

Phiên bản đệ quy của tìm kiếm nhị phân (Yêu cầu nâng cao).
Trả về: (vi_tri, do_sau_ngan_xep)
"""
function tim_nhi_phan_de_quy(a::Vector{Int}, x::Int, l::Int=1, r::Int=length(a), do_sau::Int=1)
    if l == 1 && r == length(a)
        kiem_tra_dau_vao(a, x)
    end
    if l > r
        return (0, do_sau - 1)
    end
    mid = l + div(r - l, 2)
    if a[mid] == x
        return (mid, do_sau)
    elseif x < a[mid]
        return tim_nhi_phan_de_quy(a, x, l, mid - 1, do_sau + 1)
    else
        return tim_nhi_phan_de_quy(a, x, mid + 1, r, do_sau + 1)
    end
end

# --------------------------------------------------------------------
# Hàm alias “search” – trả về Bool (true nếu tìm thấy, false nếu không)
# --------------------------------------------------------------------
"""
    search(arr::Vector{Int}, x::Int) -> Bool

Kiểm tra xem giá trị `x` có xuất hiện trong mảng `arr` hay không
bằng cách gọi hàm `tim_nhi_phan`.  Hàm này thực hiện cùng
đầu vào và kiểm tra hợp lệ như các hàm khác trong module.

# Example
julia> search([5,9,12], 5)   # → true
julia> search([5,9,12], 8)   # → false
"""
function search(arr::Vector{Int}, x::Int)::Bool
    # Kiểm tra đầu vào (đúng chuẩn dự án)
    kiem_tra_dau_vao(arr, x)
    # `tim_nhi_phan` trả về vị trí 1‑based hoặc 0 nếu không tìm thấy
    return tim_nhi_phan(arr, x) != 0
end

# --------------------------------------------------------------------
# Hàm alias “search” – trả về Bool (true nếu tìm thấy, false nếu không)
# --------------------------------------------------------------------
"""
    search(arr::Vector{Int}, x::Int) -> Bool

Kiểm tra xem giá trị `x` có xuất hiện trong mảng `arr` hay không
bằng cách gọi hàm `tim_nhi_phan`.  Hàm này thực hiện cùng
đầu vào và kiểm tra hợp lệ như các hàm khác trong module.

# Example
julia> search([5,9,12], 5)   # → true
julia> search([5,9,12], 8)   # → false
"""
function search(arr::Vector{Int}, x::Int)::Bool
    # Kiểm tra đầu vào (đúng chuẩn dự án)
    kiem_tra_dau_vao(arr, x)
    # `tim_nhi_phan` trả về vị trí 1‑based hoặc 0 nếu không tìm thấy
    return tim_nhi_phan(arr, x) != 0
end

end # module DeTai
