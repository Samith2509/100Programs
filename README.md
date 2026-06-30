# 100 Programs



Six programs, each written in both **C++** and **x86-64 Assembly** (NASM syntax, Linux).

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

## Build All at Once

Run this from inside the `100_Programs/` directory:

```bash
# C++ — all six programs
g++ -O2 -o 01_reverse_words/reverse_words           01_reverse_words/reverse_words.cpp
g++ -O2 -o 02_divisibility_check/divisibility_check 02_divisibility_check/divisibility_check.cpp
g++ -O2 -o 03_fibonacci/fibonacci                   03_fibonacci/fibonacci.cpp
g++ -O2 -o 04_factorial/factorial                   04_factorial/factorial.cpp
g++ -O2 -o 05_palindrome/palindrome                 05_palindrome/palindrome.cpp
g++ -O2 -o 06_max_in_array/max_in_array             06_max_in_array/max_in_array.cpp

# Assembly — all six programs
for dir in 01_reverse_words 02_divisibility_check 03_fibonacci 04_factorial 05_palindrome 06_max_in_array; do
  name=$(ls $dir/*.asm | xargs basename -s .asm)
  nasm -f elf64 $dir/$name.asm -o $dir/${name}_asm.o
  gcc $dir/${name}_asm.o -o $dir/${name}_asm -no-pie
done
```

---


