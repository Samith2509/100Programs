# 100 Programs

Nine programs, each written in both **C++** and **x86-64 Assembly** (MASM syntax, Windows).

---

## Prerequisites

### C++
```bash
sudo apt install build-essential   # includes g++
```

### Assembly (MASM — Windows only)
Requires **Visual Studio** with the "Desktop development with C++" workload, which includes:
- `ml64.exe` — Microsoft Macro Assembler (64-bit)
- `link.exe` — Microsoft Linker

Open a **x64 Native Tools Command Prompt for VS** to use these tools.

---

## Build Instructions

### C++ (Linux / WSL)
```bash
g++ -O2 -o <name> <name>.cpp
```

### Assembly (MASM, Windows x64 Developer Prompt)
```bash
ml64 /c <name>.asm
link <name>.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
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
```
cd 01_reverse_words
ml64 /c reverse_words.asm
link reverse_words.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
reverse_words.exe
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
```
cd 02_divisibility_check
ml64 /c divisibility_check.asm
link divisibility_check.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
divisibility_check.exe
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
```
cd 03_fibonacci
ml64 /c fibonacci.asm
link fibonacci.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
fibonacci.exe
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
```
cd 04_factorial
ml64 /c factorial.asm
link factorial.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
factorial.exe
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
```
cd 05_palindrome
ml64 /c palindrome.asm
link palindrome.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
palindrome.exe
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
```
cd 06_max_in_array
ml64 /c max_in_array.asm
link max_in_array.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
max_in_array.exe
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
```
cd 07_sum_of_digits
ml64 /c sum_of_digits.asm
link sum_of_digits.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
sum_of_digits.exe
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
```
cd 08_fizzbuzz
ml64 /c fizzbuzz.asm
link fizzbuzz.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
fizzbuzz.exe
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
```
cd 09_count_vowels
ml64 /c count_vowels.asm
link count_vowels.obj /subsystem:console /entry:main /defaultlib:msvcrt.lib
count_vowels.exe
```

---

## Build All at Once

### C++ (Linux / WSL)
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
```

### Assembly (MASM — x64 Native Tools Command Prompt for VS)
```
for %d in (01_reverse_words 02_divisibility_check 03_fibonacci 04_factorial 05_palindrome 06_max_in_array 07_sum_of_digits 08_fizzbuzz 09_count_vowels) do (
    for %f in (%d\*.asm) do ml64 /c %f /Fo%d\
    for %f in (%d\*.obj) do link %f /subsystem:console /entry:main /defaultlib:msvcrt.lib /out:%d\%~nf.exe
)
```
