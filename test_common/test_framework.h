// Minimal header-only unit-test framework (no external dependencies).
//
// Usage:
//   #include "../test_common/test_framework.h"
//
//   TEST(descriptive_name) {
//       CHECK_EQ(some_function(2, 3), 5);
//       CHECK(some_condition);
//   }
//
//   RUN_ALL_TESTS_MAIN()   // defines main() that runs every registered TEST
//
// Build a test:  g++ -std=c++17 -O2 -o test_x test_x.cpp && ./test_x
// Exit code is 0 when all tests pass, 1 otherwise (handy for CI / scripts).
#ifndef TEST_FRAMEWORK_H
#define TEST_FRAMEWORK_H

#include <functional>
#include <iostream>
#include <string>
#include <vector>

namespace testfw {

struct TestCase {
    std::string name;
    std::function<void()> fn;
};

inline std::vector<TestCase>& registry() {
    static std::vector<TestCase> r;
    return r;
}

inline int& failures() {
    static int f = 0;
    return f;
}

inline int& checks() {
    static int c = 0;
    return c;
}

struct Registrar {
    Registrar(const std::string& name, std::function<void()> fn) {
        registry().push_back({name, std::move(fn)});
    }
};

// Allow CHECK_EQ to print std::vector values on failure. Defined in this
// namespace so check_eq's unqualified stream call finds it.
template <typename T>
inline std::ostream& operator<<(std::ostream& os, const std::vector<T>& v) {
    os << "[";
    for (size_t i = 0; i < v.size(); ++i) {
        if (i) os << ", ";
        os << v[i];
    }
    os << "]";
    return os;
}

template <typename A, typename B>
inline void check_eq(const A& a, const B& b, const char* ea, const char* eb,
                     const char* file, int line) {
    checks()++;
    if (!(a == b)) {
        failures()++;
        std::cout << "    [FAIL] " << file << ":" << line << "  "
                  << ea << " == " << eb << "  (got " << a << " vs " << b << ")\n";
    }
}

inline void check_true(bool cond, const char* expr, const char* file, int line) {
    checks()++;
    if (!cond) {
        failures()++;
        std::cout << "    [FAIL] " << file << ":" << line << "  " << expr << "\n";
    }
}

inline int run_all() {
    int failed_tests = 0;
    for (auto& t : registry()) {
        int before = failures();
        t.fn();
        bool ok = (failures() == before);
        std::cout << (ok ? "[PASS] " : "[FAIL] ") << t.name << "\n";
        if (!ok) failed_tests++;
    }
    std::cout << "\n"
              << registry().size() << " tests, " << checks() << " checks, "
              << failures() << " failures\n";
    return failed_tests == 0 ? 0 : 1;
}

}  // namespace testfw

#define TEST(name)                                                       \
    static void name();                                                  \
    static testfw::Registrar test_registrar_##name(#name, name);         \
    static void name()

#define CHECK_EQ(a, b) testfw::check_eq((a), (b), #a, #b, __FILE__, __LINE__)
#define CHECK(cond) testfw::check_true((cond), #cond, __FILE__, __LINE__)

#define RUN_ALL_TESTS_MAIN() \
    int main() { return testfw::run_all(); }

#endif  // TEST_FRAMEWORK_H
