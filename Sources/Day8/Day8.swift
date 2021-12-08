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

public func partTwo() {
  let sum = input
    .lazy
    .map(Entry.init)
    .reduce(0) { result, entry in
      result + Solver.solve(entry: entry)
    }

  print(sum) // 933305
  if sum != 933305 { fatalError() }
}
