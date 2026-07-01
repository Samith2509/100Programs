// Count vowels in a string entered by the user (case-insensitive).
// Example: "Hello World" -> 3
//
// Build: g++ -O2 -o count_vowels count_vowels.cpp
// Run:   ./count_vowels

#include <iostream>
#include <string>
#include <cctype>

int main() {
    std::string s;
    std::cout << "Enter a string: ";
    std::getline(std::cin, s);

    int count = 0;
    for (char c : s) {
        c = std::tolower(c);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u')
            count++;
    }

    std::cout << "Vowel count: " << count << '\n';
    return 0;
}
