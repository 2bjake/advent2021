import Extensions

let knownPatternLengths = [2, 3, 4, 7]
func countKnownPatterns(in line: Substring) -> Int {
  line
    .suffix { $0 != "|" }
    .split(separator: " ")
    .count { knownPatternLengths.contains($0.count) }
}

public func partOne() {
  let count = input
    .lazy
    .map(countKnownPatterns)
    .reduce(0, +)
  print(count) // 247
}

////// part 2

typealias Signal = Set<Character>

struct Entry {
  let uniqueSignals: [Signal]
  let outputSignals: [Signal]

  init<S: StringProtocol>(_ source: S) {
    let parts = source.split(separator: "|")
    uniqueSignals = parts[0].split(separator: " ").map(Signal.init)
    outputSignals = parts[1].split(separator: " ").map(Signal.init)
  }
}

extension Entry {
  private static let signalToDigit: [Signal: Int] = [
    .init("abcefg"): 0,
    .init("cf"): 1,
    .init("acdeg"): 2,
    .init("acdfg"): 3,
    .init("bcdf"): 4,
    .init("abdfg"): 5,
    .init("abdefg"): 6,
    .init("acf"): 7,
    .init("abcdefg"): 8,
    .init("abcdfg"): 9,
  ]

  func numericValue() -> Int {
    let convert = Converter(uniqueSignals)
    return outputSignals
      .lazy
      .map { Self.signalToDigit[convert($0)]! }
      .reduce(0) { result, value in
        result * 10 + value
      }
  }
}

public func partTwo() {
  let sum = input
    .lazy
    .map { Entry($0).numericValue() }
    .reduce(0, +)

  print(sum) // 933305
}
