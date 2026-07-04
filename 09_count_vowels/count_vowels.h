// Core logic for counting vowels, factored out for unit testing.
#ifndef COUNT_VOWELS_H
#define COUNT_VOWELS_H

#include <cctype>
#include <string>

// Counts vowels (a, e, i, o, u) in `s`, case-insensitively.
inline int countVowels(const std::string& s) {
    int count = 0;
    for (char c : s) {
        c = static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u')
            count++;
    }
    return count;
}

#endif  // COUNT_VOWELS_H
