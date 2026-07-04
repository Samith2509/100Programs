// Core logic for FizzBuzz, factored out for unit testing.
#ifndef FIZZBUZZ_H
#define FIZZBUZZ_H

#include <string>

// Returns the FizzBuzz token for a single value `i`:
//   multiple of 15 -> "FizzBuzz", of 3 -> "Fizz", of 5 -> "Buzz",
//   otherwise the number itself as a string.
inline std::string fizzbuzz(int i) {
    if      (i % 15 == 0) return "FizzBuzz";
    else if (i % 3  == 0) return "Fizz";
    else if (i % 5  == 0) return "Buzz";
    else                  return std::to_string(i);
}

#endif  // FIZZBUZZ_H
