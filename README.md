# 100 Programs

Seventeen programs, each written in both **C++** and **x86-64 Assembly** (NASM syntax, Linux).

---

## Prerequisites

### C++
```bash
sudo apt install build-essential   # includes g++
```

### Assembly
```bash
sudo apt install nasm gcc          # NASM assembler + GCC linker
```

---

## Build Instructions

### C++
```bash
g++ -O2 -o <name> <name>.cpp
```

### Assembly
```bash
nasm -f elf64 <name>.asm -o <name>_asm.o
gcc <name>_asm.o -o <name>_asm -no-pie
```

---

## Programs

### 1. Reverse Words — `01_reverse_words/`

Reverses each word in the input string while preserving word order.

| Input | Output |
|-------|--------|
| `HEllo world` | `ollEH dlrow` |
| `foo BAR baz` | `oof RAB zab` |

#### C++
```bash
cd 01_reverse_words
g++ -O2 -o reverse_words reverse_words.cpp
./reverse_words
```

#### Assembly
```bash
cd 01_reverse_words
nasm -f elf64 reverse_words.asm -o reverse_words_asm.o
gcc reverse_words_asm.o -o reverse_words_asm -no-pie
./reverse_words_asm
```

---

### 2. Divisibility Check — `02_divisibility_check/`

For each consecutive pair `(arr[i], arr[i+1])`:
- **1** — `arr[i]` is divisible by `arr[i+1]`
- **2** — `arr[i+1]` is divisible by `arr[i]`
- **0** — neither

| Input | Output |
|-------|--------|
| `[6, 3, 7, 2]` | `[1, 0, 0]` |
| `[2, 4, 9, 3]` | `[2, 0, 1]` |

#### C++
```bash
cd 02_divisibility_check
g++ -O2 -o divisibility_check divisibility_check.cpp
./divisibility_check
```

#### Assembly
```bash
cd 02_divisibility_check
nasm -f elf64 divisibility_check.asm -o divisibility_check_asm.o
gcc divisibility_check_asm.o -o divisibility_check_asm -no-pie
./divisibility_check_asm
```

---

### 3. Fibonacci Sequence — `03_fibonacci/`

Prints the first N terms of the Fibonacci sequence.

| Input | Output |
|-------|--------|
| `7` | `0 1 1 2 3 5 8` |
| `10` | `0 1 1 2 3 5 8 13 21 34` |

#### C++
```bash
cd 03_fibonacci
g++ -O2 -o fibonacci fibonacci.cpp
./fibonacci
```

#### Assembly
```bash
cd 03_fibonacci
nasm -f elf64 fibonacci.asm -o fibonacci_asm.o
gcc fibonacci_asm.o -o fibonacci_asm -no-pie
./fibonacci_asm
```

---

### 4. Factorial — `04_factorial/`

Computes N! using an iterative loop. Accurate for **N ≤ 20** (20! is the largest value that fits in a signed 64-bit integer).

| Input | Output |
|-------|--------|
| `5` | `5! = 120` |
| `10` | `10! = 3628800` |
| `20` | `20! = 2432902008176640000` |

#### C++
```bash
cd 04_factorial
g++ -O2 -o factorial factorial.cpp
./factorial
```

#### Assembly
```bash
cd 04_factorial
nasm -f elf64 factorial.asm -o factorial_asm.o
gcc factorial_asm.o -o factorial_asm -no-pie
./factorial_asm
```

---

### 5. Palindrome Check — `05_palindrome/`

Checks whether the entered word reads the same forwards and backwards (case-sensitive).

| Input | Result |
|-------|--------|
| `racecar` | palindrome |
| `level` | palindrome |
| `hello` | not a palindrome |

#### C++
```bash
cd 05_palindrome
g++ -O2 -o palindrome palindrome.cpp
./palindrome
```

#### Assembly
```bash
cd 05_palindrome
nasm -f elf64 palindrome.asm -o palindrome_asm.o
gcc palindrome_asm.o -o palindrome_asm -no-pie
./palindrome_asm
```

---

### 6. Maximum in Array — `06_max_in_array/`

Finds the largest number in an array entered by the user.

| Input | Output |
|-------|--------|
| `[3, 9, 1, 7, 4]` | `Maximum: 9` |
| `[10, 25, 6, 99, 42]` | `Maximum: 99` |

#### C++
```bash
cd 06_max_in_array
g++ -O2 -o max_in_array max_in_array.cpp
./max_in_array
```

#### Assembly
```bash
cd 06_max_in_array
nasm -f elf64 max_in_array.asm -o max_in_array_asm.o
gcc max_in_array_asm.o -o max_in_array_asm -no-pie
./max_in_array_asm
```

---

### 7. Sum of Digits — `07_sum_of_digits/`

Sums all digits of an integer entered by the user. Negative numbers are handled by taking the absolute value first.

| Input | Output |
|-------|--------|
| `1234` | `Sum of digits: 10` |
| `9999` | `Sum of digits: 36` |
| `-57` | `Sum of digits: 12` |

#### C++
```bash
cd 07_sum_of_digits
g++ -O2 -o sum_of_digits sum_of_digits.cpp
./sum_of_digits
```

#### Assembly
```bash
cd 07_sum_of_digits
nasm -f elf64 sum_of_digits.asm -o sum_of_digits_asm.o
gcc sum_of_digits_asm.o -o sum_of_digits_asm -no-pie
./sum_of_digits_asm
```

---

### 8. FizzBuzz — `08_fizzbuzz/`

Prints numbers from 1 to N, replacing multiples of 3 with `Fizz`, multiples of 5 with `Buzz`, and multiples of both with `FizzBuzz`.

| Input | Output |
|-------|--------|
| `5` | `1 2 Fizz 4 Buzz` |
| `15` | `1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz` |

#### C++
```bash
cd 08_fizzbuzz
g++ -O2 -o fizzbuzz fizzbuzz.cpp
./fizzbuzz
```

#### Assembly
```bash
cd 08_fizzbuzz
nasm -f elf64 fizzbuzz.asm -o fizzbuzz_asm.o
gcc fizzbuzz_asm.o -o fizzbuzz_asm -no-pie
./fizzbuzz_asm
```

---

### 9. Count Vowels — `09_count_vowels/`

Counts the number of vowels (`a e i o u`) in a string entered by the user. Case-insensitive.

| Input | Output |
|-------|--------|
| `Hello World` | `Vowel count: 3` |
| `assembly` | `Vowel count: 3` |
| `rhythm` | `Vowel count: 0` |

#### C++
```bash
cd 09_count_vowels
g++ -O2 -o count_vowels count_vowels.cpp
./count_vowels
```

#### Assembly
```bash
cd 09_count_vowels
nasm -f elf64 count_vowels.asm -o count_vowels_asm.o
gcc count_vowels_asm.o -o count_vowels_asm -no-pie
./count_vowels_asm
```

---

### 10. Prime Check — `10_prime_check/`

Checks whether a number entered by the user is prime.

| Input | Output |
|-------|--------|
| `7` | `7 is prime` |
| `8` | `8 is not prime` |

#### C++
```bash
cd 10_prime_check
g++ -O2 -o prime_check prime_check.cpp
./prime_check
```

#### Assembly
```bash
cd 10_prime_check
nasm -f elf64 prime_check.asm -o prime_check_asm.o
gcc prime_check_asm.o -o prime_check_asm -no-pie
./prime_check_asm
```

---

### 11. HCF — `11_hcf/`

Computes the HCF (GCD) of two numbers entered by the user, using the Euclidean algorithm.

| Input | Output |
|-------|--------|
| `12, 18` | `HCF: 6` |
| `17, 5` | `HCF: 1` |

#### C++
```bash
cd 11_hcf
g++ -O2 -o hcf hcf.cpp
./hcf
```

#### Assembly
```bash
cd 11_hcf
nasm -f elf64 hcf.asm -o hcf_asm.o
gcc hcf_asm.o -o hcf_asm -no-pie
./hcf_asm
```

---

### 12. Binary Search — `12_binary_search/`

Searches for a target value in a sorted array entered by the user and prints its index (or "Not found").

| Input | Output |
|-------|--------|
| `[2, 4, 6, 8, 10]`, target `6` | `Found at index: 2` |
| `[2, 4, 6, 8, 10]`, target `7` | `Not found` |

#### C++
```bash
cd 12_binary_search
g++ -O2 -o binary_search binary_search.cpp
./binary_search
```

#### Assembly
```bash
cd 12_binary_search
nasm -f elf64 binary_search.asm -o binary_search_asm.o
gcc binary_search_asm.o -o binary_search_asm -no-pie
./binary_search_asm
```

---

### 13. LCM — `13_lcm/`

Computes the LCM of two numbers entered by the user. Uses the Euclidean algorithm for the GCD, then `LCM = a / gcd * b`.

| Input | Output |
|-------|--------|
| `12, 18` | `LCM: 36` |
| `17, 5` | `LCM: 85` |

#### C++
```bash
cd 13_lcm
g++ -O2 -o lcm lcm.cpp
./lcm
```

#### Assembly
```bash
cd 13_lcm
nasm -f elf64 lcm.asm -o lcm_asm.o
gcc lcm_asm.o -o lcm_asm -no-pie
./lcm_asm
```

---

### 14. Reverse Number — `14_reverse_number/`

Reverses the digits of an integer entered by the user. Negative numbers keep their sign.

| Input | Output |
|-------|--------|
| `1234` | `Reversed: 4321` |
| `-57` | `Reversed: -75` |

#### C++
```bash
cd 14_reverse_number
g++ -O2 -o reverse_number reverse_number.cpp
./reverse_number
```

#### Assembly
```bash
cd 14_reverse_number
nasm -f elf64 reverse_number.asm -o reverse_number_asm.o
gcc reverse_number_asm.o -o reverse_number_asm -no-pie
./reverse_number_asm
```

---

### 15. Reverse a Linked List — `15_linked_list_reverse/`

Builds a singly linked list from values entered by the user and reverses it in place using the classic three-pointer (prev / cur / next) technique.

| Input | Output |
|-------|--------|
| `1 2 3 4 5` | `Reversed list: 5 4 3 2 1` |
| `7 9` | `Reversed list: 9 7` |

#### C++
```bash
cd 15_linked_list_reverse
g++ -O2 -o linked_list_reverse linked_list_reverse.cpp
./linked_list_reverse
```

#### Assembly
```bash
cd 15_linked_list_reverse
nasm -f elf64 linked_list_reverse.asm -o linked_list_reverse_asm.o
gcc linked_list_reverse_asm.o -o linked_list_reverse_asm -no-pie
./linked_list_reverse_asm
```

---

### 16. Middle of a Linked List — `16_linked_list_middle/`

Finds the middle node of a singly linked list using the slow/fast (tortoise-and-hare) pointer technique. For an even number of nodes, the second of the two middle nodes is reported.

| Input | Output |
|-------|--------|
| `1 2 3 4 5` | `Middle: 3` |
| `1 2 3 4` | `Middle: 3` |

#### C++
```bash
cd 16_linked_list_middle
g++ -O2 -o linked_list_middle linked_list_middle.cpp
./linked_list_middle
```

#### Assembly
```bash
cd 16_linked_list_middle
nasm -f elf64 linked_list_middle.asm -o linked_list_middle_asm.o
gcc linked_list_middle_asm.o -o linked_list_middle_asm -no-pie
./linked_list_middle_asm
```

---

### 17. Detect a Cycle in a Linked List — `17_linked_list_cycle/`

Builds a list from user values, then optionally loops the tail back to node `pos` (or `-1` for no loop), and detects whether the list contains a cycle using Floyd's tortoise-and-hare algorithm.

| Input (values, loop index) | Output |
|----------------------------|--------|
| `1 2 3 4 5`, `-1` | `No cycle` |
| `1 2 3 4 5`, `2` | `Cycle detected` |

#### C++
```bash
cd 17_linked_list_cycle
g++ -O2 -o linked_list_cycle linked_list_cycle.cpp
./linked_list_cycle
```

#### Assembly
```bash
cd 17_linked_list_cycle
nasm -f elf64 linked_list_cycle.asm -o linked_list_cycle_asm.o
gcc linked_list_cycle_asm.o -o linked_list_cycle_asm -no-pie
./linked_list_cycle_asm
```

---

## Build All at Once

### C++
```bash
g++ -O2 -o 01_reverse_words/reverse_words           01_reverse_words/reverse_words.cpp
g++ -O2 -o 02_divisibility_check/divisibility_check 02_divisibility_check/divisibility_check.cpp
g++ -O2 -o 03_fibonacci/fibonacci                   03_fibonacci/fibonacci.cpp
g++ -O2 -o 04_factorial/factorial                   04_factorial/factorial.cpp
g++ -O2 -o 05_palindrome/palindrome                 05_palindrome/palindrome.cpp
g++ -O2 -o 06_max_in_array/max_in_array             06_max_in_array/max_in_array.cpp
g++ -O2 -o 07_sum_of_digits/sum_of_digits           07_sum_of_digits/sum_of_digits.cpp
g++ -O2 -o 08_fizzbuzz/fizzbuzz                     08_fizzbuzz/fizzbuzz.cpp
g++ -O2 -o 09_count_vowels/count_vowels             09_count_vowels/count_vowels.cpp
g++ -O2 -o 10_prime_check/prime_check               10_prime_check/prime_check.cpp
g++ -O2 -o 11_hcf/hcf                               11_hcf/hcf.cpp
g++ -O2 -o 12_binary_search/binary_search           12_binary_search/binary_search.cpp
g++ -O2 -o 13_lcm/lcm                               13_lcm/lcm.cpp
g++ -O2 -o 14_reverse_number/reverse_number         14_reverse_number/reverse_number.cpp
g++ -O2 -o 15_linked_list_reverse/linked_list_reverse 15_linked_list_reverse/linked_list_reverse.cpp
g++ -O2 -o 16_linked_list_middle/linked_list_middle   16_linked_list_middle/linked_list_middle.cpp
g++ -O2 -o 17_linked_list_cycle/linked_list_cycle     17_linked_list_cycle/linked_list_cycle.cpp
```

### Assembly
```bash
for dir in 01_reverse_words 02_divisibility_check 03_fibonacci 04_factorial 05_palindrome 06_max_in_array 07_sum_of_digits 08_fizzbuzz 09_count_vowels 10_prime_check 11_hcf 12_binary_search 13_lcm 14_reverse_number 15_linked_list_reverse 16_linked_list_middle 17_linked_list_cycle; do
  name=$(basename $dir/*.asm .asm)
  nasm -f elf64 $dir/$name.asm -o $dir/${name}_asm.o
  gcc $dir/${name}_asm.o -o $dir/${name}_asm -no-pie
done
```
