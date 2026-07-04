// Count vowels in a string entered by the user (case-insensitive).
// Example: "Hello World" -> 3
//
// Build: g++ -O2 -o count_vowels count_vowels.cpp
// Run:   ./count_vowels

#include <iostream>
#include <string>

#include "count_vowels.h"

int main() {
    std::string s;
    std::cout << "Enter a string: ";
    std::getline(std::cin, s);

    std::cout << "Vowel count: " << countVowels(s) << '\n';
    return 0;
}
