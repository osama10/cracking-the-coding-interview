
import Foundation

func countChar(result: [String:  Int], char: String.Element) -> [String: Int] {
    let key = String(char)
    var dict = result
    dict[key] = (dict[key] == nil) ? 1 : dict[key]! + 1
    return dict
}

func minMaxString(string1: String, string2: String) -> (max: String, min: String) {
    return (string1.count > string2.count) ? (max: string1, min: string2) : (max: string2, min: string1)
}

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
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

//print(urlify(string: "I   am a disco dancer "))


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

//print(palindromePermutation(string: "abcdeabdc"))
//print(palindromePermutation(string: "tact coap apa"))
//print(palindromePermutation(string: "tact coap ap"))


/// 1.5  One Away: There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.

func replacementCase(str1: String, str2: String) -> Bool {
    let replacement = str1.enumerated().reduce(0) { (result, val) in (str2[val.offset] == val.element) ? result + 0 : result + 1 }
    return (replacement <= 1)
}

func insertionCase(largeStr: String, smallStr: String) -> Bool {
    var smallStrIndex = 0
    largeStr.enumerated().forEach { (index, value) in
        guard (smallStrIndex <= (smallStr.count - 1)) else { return }
        if (smallStr[smallStrIndex] == value) { smallStrIndex += 1 }
    }
    return (smallStrIndex == smallStr.count)
}

func oneWay(string1: String, string2: String) -> Bool {
    guard string1 != string2 else { return true }// 0 edits case
    guard abs(string1.count - string2.count) <= 1 else { return false } // more then 1 edits
    if (string1.count == string2.count) { return replacementCase(str1: string1, str2: string2) }
    else if (string1.count > string2.count) { return insertionCase(largeStr: string1, smallStr: string2) }
    else { return insertionCase(largeStr: string2, smallStr: string1) }
}

//print(oneWay(string1: "pale", string2: "bae"))
//print(oneWay(string1: "pale", string2: "ple"))
//print(oneWay(string1: "pale", string2: "pales"))
//print(oneWay(string1: "pale", string2: "bale"))
