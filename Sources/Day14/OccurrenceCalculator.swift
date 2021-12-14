private struct Expansion: Hashable {
  var pair: Pair
  var count: Int

  init(_ pair: Pair, _ count: Int) {
    self.pair = pair
    self.count = count
  }
}

extension Expansion {
  init(_ first: Character, _ second: Character, _ count: Int) {
    self.init(.init(first, second), count)
  }

  /// Expands expansion into subExpansions
  /// (BC 2) -> BDC -> (BD 1) (DC 1)
  /// (BC 3) -> BDC -> (BD 2) (DC 2)
  func expand(inserting char: Character) -> [Expansion] {
    let newCount = count - 1
    guard newCount > 0 else { fatalError() }
    return [Self(pair.first, char, newCount), Self(char, pair.second, newCount)]
  }
}

struct OccurrenceCalculator {
  private let rules: [Pair: Character]
  private var cache: [Expansion: [Character: UInt64]] = [:]

  init(rules: [Pair: Character]) {
    self.rules = rules
  }

  private mutating func calculateOccurrences(for expansions: [Expansion]) -> [Character: UInt64] {
    var occurrences = [Character: UInt64]()
    for expansion in expansions {
      var expansionOccurrences = calculateOccurrences(for: expansion)
      expansionOccurrences[expansion.pair.second]! -= 1
      occurrences.merge(expansionOccurrences, uniquingKeysWith: +)
    }
    occurrences[expansions.last!.pair.second]! += 1
    return occurrences
  }

  private mutating func calculateOccurrences(for expansion: Expansion) -> [Character: UInt64] {
    if let occurrences = cache[expansion] { return occurrences }

    var occurrences = [Character: UInt64]()

    let insertion = rules[expansion.pair]!
    if expansion.count == 1 {
      let pair = expansion.pair
      occurrences = [pair.first, pair.second, insertion].reduce(into: [:]) { result, value in result[value, default: 0] += 1 }
    } else {
      occurrences = calculateOccurrences(for: expansion.expand(inserting: insertion))
    }

    cache[expansion] = occurrences
    return occurrences
  }

  mutating func calculateOccurrences(in template: [Character], expandingTimes times: Int) -> [Character: UInt64] {
    let expansions = template.adjacentPairs().map(Pair.init).map { Expansion($0, times) }
    return calculateOccurrences(for: expansions)
  }
}
