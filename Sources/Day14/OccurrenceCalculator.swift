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

  /// Expands expansion into in-order subExpansions
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

  private mutating func calculateOccurrences(for expansion: Expansion) -> [Character: UInt64] {
    if let occurrences = cache[expansion] { return occurrences }

    let insertion = rules[expansion.pair]!
    var occurrences = [Character: UInt64]()
    if expansion.count == 1 {
      let pair = expansion.pair
      occurrences = [pair.first, pair.second, insertion].reduce(into: [:]) { result, value in result[value, default: 0] += 1 }
    } else {
      occurrences = calculateOccurrences(for: expansion.expand(inserting: insertion))
    }
    cache[expansion] = occurrences
    return occurrences
  }

  private mutating func calculateOccurrences(for adjacentExpansions: [Expansion]) -> [Character: UInt64] {
    var result = [Character: UInt64]()
    for expansion in adjacentExpansions {
      var occurrences = calculateOccurrences(for: expansion)
      occurrences[expansion.pair.second]! -= 1 // The occurrence for the second char will be counted in the next expansion (or after the loop)
      result.merge(occurrences, uniquingKeysWith: +)
    }
    result[adjacentExpansions.last!.pair.second]! += 1 // add back in occurrence for last char
    return result
  }

  mutating func calculateOccurrences(in template: [Character], expandingTimes times: Int) -> [Character: UInt64] {
    let expansions = template.adjacentPairs().map(Pair.init).map { Expansion($0, times) }
    return calculateOccurrences(for: expansions)
  }
}
