import Extensions

enum Segment: Character, CaseIterable {
  case top = "a"
  case upperLeft = "b"
  case upperRight = "c"
  case middle = "d"
  case lowerLeft = "e"
  case lowerRight = "f"
  case bottom = "g"
}

struct Solver {
  let entry: Entry

  // TODO: consider flipping these since it seems that digitToPattern is used more often?
  var patternToDigit: [Set<Character>: Int] = [:]
  var digitToPattern: [Int: Set<Character>] { patternToDigit.flipWithUniqueValues() }

  static let segmentsToDigit: [Set<Character>: Int] = [
    Set("abcefg"): 0,
    Set("cf"): 1,
    Set("acdeg"): 2,
    Set("acdfg"): 3,
    Set("bcdf"): 4,
    Set("abdfg"): 5,
    Set("abdefg"): 6,
    Set("acf"): 7,
    Set("abcdefg"): 8,
    Set("abcdfg"): 9,
  ]

  // static let segmentCount = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
  static let segmentCount = segmentsToDigit.reduce(into: Array(repeating: 0, count: 10)) { result, entry in
    result[entry.value] = entry.key.count
  }

  mutating func solve() -> Int {
    let letterConverter = makeLetterConverter()

    let digits: [Int] = entry.output.map { wrongPattern in
      let pattern = Set(wrongPattern.map { letterConverter[$0]! })
      return Self.segmentsToDigit[pattern]!
    }

    return digits.reduce(0) { result, value in
      result * 10 + value
    }
  }

  private mutating func makeLetterConverter() -> [Character: Character] {
    return makeSegmentToLetter().flipWithUniqueValues().mapValues(\.rawValue)
  }

  // TODO: this shouldn't be mutating....
  private mutating func makeSegmentToLetter() -> [Segment: Character] {
    let segmentCountToPatterns: [Int: [Set<Character>]] = entry.patterns.reduce(into: [:]) { result, pattern in
      result[pattern.count, default: []].append(pattern)
    }

    // start with known patterns
    patternToDigit = [1, 4, 7, 8].reduce(into: [:]) { result, digit in
      let segmentCount = Self.segmentCount[digit]
      let pattern = segmentCountToPatterns[segmentCount]!.first!
      result[pattern] = digit
    }

    var segmentToLetter: [Segment: Character] = [:]

    // top is segment in 7 but not in 1
    segmentToLetter[.top] = digitToPattern[7]!.subtracting(digitToPattern[1]!).first!

    // lowerRight is segment in 1 that is in all patterns where count = 6
    segmentToLetter[.lowerRight] = digitToPattern[1]!.first { letter in
      segmentCountToPatterns[6]!.allSatisfy { $0.contains(letter) }
    }!

    // upperRight is segment in 1 that is not lowerRight
    segmentToLetter[.upperRight] = digitToPattern[1]!.subtracting([segmentToLetter[.lowerRight]!]).first!

    // middle is segment in 4 but not in 1 that is in all patterns where count = 5
    let possibleMiddles = digitToPattern[4]!.subtracting(digitToPattern[1]!)
    let middleSet = possibleMiddles.filter { letter in
      segmentCountToPatterns[5]!.allSatisfy { $0.contains(letter) }
    }
    segmentToLetter[.middle] = middleSet.first!

    // upperLeft is segment in 4 but not in 1 that is not middle
    segmentToLetter[.upperLeft] = possibleMiddles.subtracting(middleSet).first!

    // zero is 8 pattern + middle
    let zeroPattern = digitToPattern[8]!.union(middleSet)
    patternToDigit[zeroPattern] = 0

    // remaining segments (bottom & lowerLeft) can be found by subtracting segments in 4 and top segment from zero
    let possibleBottoms = digitToPattern[0]!.subtracting(digitToPattern[4]! + [segmentToLetter[.top]!])

    // bottom is segment in possibleSegments that is in all patterns where count = 5
    let bottomSet = possibleBottoms.filter { letter in
      segmentCountToPatterns[5]!.allSatisfy { $0.contains(letter) }
    }
    segmentToLetter[.bottom] = bottomSet.first!

    // lowerLeft is segment in possibleSegments that is not bottom
    segmentToLetter[.lowerLeft] = possibleBottoms.subtracting(bottomSet).first!

    return segmentToLetter
  }
}
