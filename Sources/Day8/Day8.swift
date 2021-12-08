import Extensions

struct Entry {
  let patterns: [Set<Character>] // 10 entries
  let output: [Set<Character>] // 4 entries

  init<S: StringProtocol>(_ source: S) {
    let parts = source.split(separator: "|")
    patterns = parts[0].split(separator: " ").map { Set($0) }
    output = parts[1].split(separator: " ").map { Set($0) }
  }
}

public func partOne() {
  let entries = input.map(Entry.init)
  let count = entries.reduce(0) { result, entry in
    result + entry.output.count { [2, 4, 3, 7].contains($0.count) }
  }
  print(count) // 247
}

public func partTwo() {
  let sum = input
    .lazy
    .map(Entry.init)
    .reduce(0) { result, entry in
      result + Solver.solve(entry: entry)
    }

  print(sum) // 933305
}
