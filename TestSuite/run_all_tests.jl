# run_all_tests.jl
include("src/DeTai.jl")
using .DeTai
using Dates   # để định dạng thời gian (tùy chọn)

# ----------------------------------------------------------------
# Định nghĩa cấu trúc ca kiểm thử
# ----------------------------------------------------------------
struct TestCase
    desc::String
    fn::Function
    expected::Any
    expect_exception::Bool
end

# ----------------------------------------------------------------
# Danh sách ≥12 ca kiểm thử (độc lập)
# ----------------------------------------------------------------
tests = [
    TestCase("search start true",        () -> DeTai.search([5,9,12],5),   true,  false),
    TestCase("search end true",          () -> DeTai.search([5,9,12],12),  true,  false),
    TestCase("search middle true",       () -> DeTai.search([5,9,12],9),   true,  false),
    TestCase("search not found false",   () -> DeTai.search([5,9,12],8),   false, false),
    TestCase("search invalid array",     () -> DeTai.search([5,9,9],9),    nothing,true),
    TestCase("tim_nhi_phan found",       () -> DeTai.tim_nhi_phan([5,9,12],9), 2,  false),
    TestCase("tim_nhi_phan not found",   () -> DeTai.tim_nhi_phan([5,9,12],8), 0,  false),
    TestCase("lan_vet_nhi_phan found pos", () -> begin
        pos, trace, steps = DeTai.lan_vet_nhi_phan([5,9,12],9)
        pos
    end, 2, false),
    TestCase("tim_tuyen_tinh found",     () -> DeTai.tim_tuyen_tinh([5,9,12],9), (2,2), false),
    TestCase("tim_tuyen_tinh not found", () -> DeTai.tim_tuyen_tinh([5,9,12],8), (0,3), false),
    TestCase("kiem_tra_tang true",       () -> DeTai.kiem_tra_tang([1,2,3]), true, false),
    TestCase("kiem_tra_tang false",      () -> DeTai.kiem_tra_tang([1,2,2]), false,false)
]

function run_all_tests(test_list)
    # ----------------------------------------------------------------
    # Đếm kết quả
    # ----------------------------------------------------------------
    pass = 0
    fail = 0
    asserts = 0   # số ca mong đợi ngoại lệ

    # ----------------------------------------------------------------
    # Đánh dấu thời gian bắt đầu
    # ----------------------------------------------------------------
    start_time = time()   # epoch time (seconds)

    for (i, tc) in enumerate(test_list)
        try
            result = tc.fn()
            if tc.expect_exception
                println("Test $i ($(tc.desc)): FAIL - expected exception but got $(result)")
                fail += 1
            elseif result == tc.expected
                println("Test $i ($(tc.desc)): PASS")
                pass += 1
            else
                println("Test $i ($(tc.desc)): FAIL - got $(result), expected $(tc.expected)")
                fail += 1
            end
        catch e
            if tc.expect_exception
                println("Test $i ($(tc.desc)): PASS (caught expected $(typeof(e)))")
                pass += 1
                asserts += 1
            else
                println("Test $i ($(tc.desc)): FAIL - exception $(e)")
                fail += 1
            end
        end
    end

    # ----------------------------------------------------------------
    # Tính thời gian kết thúc và tổng thời gian
    # ----------------------------------------------------------------
    elapsed = time() - start_time   # giây (float)

    # ----------------------------------------------------------------
    # In kết quả tổng hợp
    # ----------------------------------------------------------------
    println("\nSummary: PASS=$pass, FAIL=$fail, ASSERT=$asserts, TOTAL TIME=$(round(elapsed, digits=3))s")
end

run_all_tests(tests)