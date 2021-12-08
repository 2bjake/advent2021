struct Pattern: Hashable {
  let segments: Set<Character>

  private static let segmentsToDigit: [Set<Character>: Int] = [
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

  var digit: Int? { Self.segmentsToDigit[segments] }
}

extension Pattern {
  init<S: StringProtocol>(_ source: S) {
    segments = Set(source)
  }

  func converted(using conversion: [Character: Character]) -> Pattern {
    Pattern(segments: Set(segments.map { conversion[$0]! }))
  }
}
