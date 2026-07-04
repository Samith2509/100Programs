// Check whether the entered word is a palindrome (case-sensitive).
// Example: "racecar" -> palindrome, "hello" -> not a palindrome
//
// Build: g++ -O2 -o palindrome palindrome.cpp
// Run:   ./palindrome

#include <iostream>
#include <string>

#include "palindrome.h"

int main() {
    std::string s;
    std::cout << "Enter a word: ";
    std::cin >> s;

    if (isPalindrome(s))
        std::cout << '"' << s << "\" is a palindrome.\n";
    else
        std::cout << '"' << s << "\" is not a palindrome.\n";

    return 0;
}
