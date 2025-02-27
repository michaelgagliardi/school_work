class Solution:
    def longestPalindrome(self, s: str) -> str:
        start = 0  # Start position of longest palindrome
        end = 0  # End position of longest palindrome
        length = len(s)
        for i in range(0, len(s)):

            l1 = self.expand_around(s, i, i)
            l2 = 0
            if i + 1 < length:
                l2 = self.expand_around(s, i, i + 1)

            if l1 > l2:
                if l1 > (end - start) + 1:
                    start = i - (l1 // 2)
                    end = i + (l1 // 2)

            else:
                if l2 > (end - start) + 1:
                    start = i - ((l2 // 2) - 1)
                    end = i + (l2 // 2)
            i += 1
        return s[start: end + 1]

    # expand around given centers and return the length of the longest palindrome.
    def expand_around(self, s, left, right):
        if s[left] == s[right]:
            l = left
            r = right
        else:
            return 0
        while (left >= 0 and right < len(s) and s[left] == s[right]): ##while the two sides are the same, measure the longest length from right
            l = left
            r = right
            left = left - 1
            right = right + 1

        return (r - l) + 1
        ## return the length of the longest palindrome

    def runtime_complexity(self):
        # Select the tightest big-Oh notation, where n is the length of the string
        # Uncomment the right answer,

        # runtime = "O(Log(n))"
        # runtime = "O(n)"
        runtime = "O(n^2)"
        # runtime = "O(n/2)"
        # runtime = "O(nLon(n))
        return runtime

if __name__ == "__main__":
    solution = Solution()
    test_cases = [
        "a", "abaab", "racecar", "bullet", "rarfile",
        "computer", "windows", "saippuakivikauppias",
        "aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "kkkkkkkkkkkkkkkkkkkkkkdldkkkkkkkkkkkkkkkkkkkkkk",
        "ddddddddddddddddddddddddddddddddddddddddddddddddddks"
    ]

    for test_case in test_cases:
        print(solution.longestPalindrome(test_case))

    print(solution.runtime_complexity())
