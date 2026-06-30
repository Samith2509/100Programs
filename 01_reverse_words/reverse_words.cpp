// Reverse each word in the input string.
// Example: "HEllo world" -> "ollEH dlrow"
//
// Build: g++ -O2 -o reverse_words reverse_words.cpp
// Run:   ./reverse_words

#include <iostream>
#include <string>
#include <algorithm>

int main() {
    std::string line;
    std::cout << "Enter string: ";
    std::getline(std::cin, line);

    std::cout << "Output: ";
    size_t i = 0;
    bool first = true;
    while (i < line.size()) {
        while (i < line.size() && line[i] == ' ') i++;
        if (i >= line.size()) break;

        size_t start = i;
        while (i < line.size() && line[i] != ' ') i++;

        std::string word = line.substr(start, i - start);
        std::reverse(word.begin(), word.end());

        if (!first) std::cout << ' ';
        std::cout << word;
        first = false;
    }
    std::cout << '\n';
    return 0;
}
