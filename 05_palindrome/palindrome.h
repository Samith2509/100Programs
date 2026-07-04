// Core logic for the palindrome check, factored out for unit testing.
#ifndef PALINDROME_H
#define PALINDROME_H

#include <algorithm>
#include <string>

// Returns true if `s` reads the same forwards and backwards (case-sensitive).
inline bool isPalindrome(const std::string& s) {
    std::string rev = s;
    std::reverse(rev.begin(), rev.end());
    return s == rev;
}

#endif  // PALINDROME_H
