// Core logic for reversing each word in a string, factored out for unit testing.
#ifndef REVERSE_WORDS_H
#define REVERSE_WORDS_H

#include <algorithm>
#include <string>

// Reverses each whitespace-separated word in `s`, preserving spaces exactly.
// Example: "HEllo world" -> "ollEH dlrow".
inline std::string reverseEachWord(const std::string& s) {
    std::string res = s;
    int n = static_cast<int>(res.length());
    int i = 0;
    while (i < n) {
        if (res[i] == ' ') { ++i; continue; }   // preserve spaces exactly
        int j = i;
        while (j < n && res[j] != ' ') ++j;      // find end of word
        std::reverse(res.begin() + i, res.begin() + j);
        i = j;
    }
    return res;
}

#endif  // REVERSE_WORDS_H
