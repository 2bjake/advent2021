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
  if count != 247 { fatalError() }
}

struct Entry {
  let signals: [Set<Character>] // 10 values
  let output: [Pattern] // 4 values

  init<S: StringProtocol>(_ source: S) {
    let parts = source.split(separator: "|")
    signals = parts[0].split(separator: " ").map { Set($0) }
    output = parts[1].split(separator: " ").map(Pattern.init)
  }
}

func numericalValue(of entry: Entry) -> Int {
  let converter = Converter(entry.signals)
  return entry.output
    .lazy
    .map { converter.convert($0).digit! }
    .reduce(0) { result, value in
      result * 10 + value
    }
}

public func partTwo() {
  let sum = input
    .lazy
    .map(Entry.init)
    .map(numericalValue)
    .reduce(0, +)

  print(sum) // 933305
  if sum != 933305 { fatalError() }
}
