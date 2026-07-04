#!/usr/bin/env bash
# Build and run all C++ unit tests. Exits non-zero if any test fails.
#
#   ./run_tests.sh
#
# Requires g++ with C++17 support.
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CXX="${CXX:-g++}"
CXXFLAGS="-std=c++17 -O2 -Wall -Wextra"

# Each entry: "<dir>:<test_source>"
TESTS=(
    "01_reverse_words:test_reverse_words.cpp"
    "02_divisibility_check:test_divisibility_check.cpp"
    "03_fibonacci:test_fibonacci.cpp"
    "04_factorial:test_factorial.cpp"
    "05_palindrome:test_palindrome.cpp"
    "06_max_in_array:test_max_in_array.cpp"
    "07_sum_of_digits:test_sum_of_digits.cpp"
    "08_fizzbuzz:test_fizzbuzz.cpp"
    "09_count_vowels:test_count_vowels.cpp"
    "10_prime_check:test_prime_check.cpp"
    "11_hcf:test_hcf.cpp"
    "12_binary_search:test_binary_search.cpp"
    "13_lcm:test_lcm.cpp"
    "14_reverse_number:test_reverse_number.cpp"
    "15_linked_list_reverse:test_linked_list_reverse.cpp"
    "16_linked_list_middle:test_linked_list_middle.cpp"
    "17_linked_list_cycle:test_linked_list_cycle.cpp"
)

overall=0
for entry in "${TESTS[@]}"; do
    dir="${entry%%:*}"
    src="${entry##*:}"
    bin="${src%.cpp}"

    echo "=============================================="
    echo "Building $dir/$src"
    echo "=============================================="
    if ! "$CXX" $CXXFLAGS -o "$ROOT/$dir/$bin" "$ROOT/$dir/$src"; then
        echo "[BUILD FAILED] $dir/$src"
        overall=1
        continue
    fi

    "$ROOT/$dir/$bin"
    if [ $? -ne 0 ]; then
        overall=1
    fi
    echo
done

echo "=============================================="
if [ "$overall" -eq 0 ]; then
    echo "ALL TEST SUITES PASSED"
else
    echo "SOME TEST SUITES FAILED"
fi
echo "=============================================="
exit "$overall"
