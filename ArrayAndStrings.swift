
import Foundation

func countChar(result: [String:  Int], char: String.Element) -> [String: Int] {
    let key = String(char)
    var dict = result
    dict[key] = (dict[key] == nil) ? 1 : dict[key]! + 1
    return dict
}

/// 1.1 Is Unique: Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?

func isUnique(string: String) -> Bool {
    var set = Set<String>()
    for char in string {
        let val = String(char)
        if set.contains(val) { return false }
        set.insert(val)
    }
    return true
}

//print(isUnique(string: "asdaasdabsda"))
//print(isUnique(string: "abcdefghi"))

/// without additional datastructure

func isUniquesWithAdditionalDS(string: String) -> Bool {
    let sortedString = string.sorted()

    for i in 0..<(sortedString.count - 1) {
        if sortedString[i] == sortedString[i + 1] { return false }
    }
    return true
}

//print(isUniquesWithAdditionalDS(string: "asdaasdabsda"))
//print(isUniquesWithAdditionalDS(string: "abcdefghi"))

/// 1.2 Check Permutation: Given two strings, write a method to decide if one is a permutation of the other.

func checkPermutation(string1: String, string2: String) -> Bool {
    guard string1.count == string2.count else { return false }
    let charCount1  = string1.reduce([String: Int](), countChar)
    let charCount2  = string2.reduce([String: Int](), countChar)
    return charCount1.allSatisfy { (key, value) in charCount2[key] == value }
}



//print(checkPermutation(string1: "abc", string2: "bca"))
//print(checkPermutation(string1: "abc", string2: "bcaa"))
//print(checkPermutation(string1: "abc", string2: "bce"))


/// 1.3 URLify: Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient space at the end to hold the additional characters, and that you are given the "true" length of the string.

func urlify(string: String) -> String {
    return string.reduce("") { (partialResult, char) in (String(char) == " ") ? partialResult + "%20" : partialResult + String(char)}
}

print(urlify(string: "I   am a disco dancer "))


/// 1.4 Palindrome Permutation: Given a string, write a function to check if it is a permutation of a palindrome. A palindrome is a word or phrase that is the same forwards and backwards. A permutation is a rearrangement of letters. The palindrome does not need to be limited to just dictionary words.

func palindromePermutation(string: String) -> Bool  {
    let filteredString = string.replacingOccurrences(of: " ", with: "")
    let charCountDict = filteredString.reduce([String: Int](), countChar)
    var oddCount = 0
    return charCountDict.allSatisfy { (key, value) in
        if (value % 2 != 0) {
            oddCount += 1
        }
        return (value % 2 == 0 || oddCount <= 1 )
    }
}

print(palindromePermutation(string: "abcdeabdc"))
print(palindromePermutation(string: "tact coap apa"))
print(palindromePermutation(string: "tact coap ap"))
