// Reverse each word in the input string.
// Example: "HEllo world" -> "ollEH dlrow"
//
// Build: g++ -O2 -o reverse_words reverse_words.cpp
// Run:   ./reverse_words

#include <iostream>
#include <string>

#include "reverse_words.h"

using namespace std;

int main() {
    string line;
    cout << "Enter a string" << endl;
    if (!getline(cin, line)) return 0;
    cout << reverseEachWord(line) << '\n';
    return 0;
}

