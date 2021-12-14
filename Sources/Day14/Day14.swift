import Algorithms
import Extensions
import Foundation

struct Pair: Hashable {
  var first: Character
  var second: Character

  init(_ first: Character, _ second: Character) {
    self.first = first
    self.second = second
  }
}

func parse() -> ([Character], [Pair: Character]) {
  let parts = input.components(separatedBy: "\n\n")

  let rules = parts[1].split(separator: "\n").reduce(into: [:]) { result, line in
    result[Pair(line.first!, line.second!)] = line.last!
  }

  return (Array(parts[0]), rules)
}

let (template, rules) = parse()

struct PairExpansion: Hashable {
  var pair: Pair
  var count: Int

  init(_ pair: Pair, _ count: Int) {
    self.pair = pair
    self.count = count
  }

  //(BC 2) -> BDC -> (BD 1) (DC 1)
  //(BC 3) -> BDC -> (BD 2) (DC 2) -> BEDFC -> (BE 1) (ED 1) (DF 1) (FC 1)
  func expandOnce() -> [PairExpansion] {
    guard count > 1 else { fatalError() }
    let firstPair = Pair(pair.first, rules[pair]!)
    let secondPair = Pair(rules[pair]!, pair.second)
    return [.init(firstPair, count - 1), .init(secondPair, count - 1)]
  }
}

@discardableResult
func updateOccurrenceCounts(in counts: inout [PairExpansion: [Character: UInt64]], for pairExpansion: PairExpansion) -> [Character: UInt64] {
  if let occurrenceCounts = counts[pairExpansion] { return occurrenceCounts }

  guard pairExpansion.count > 1 else {
    let pair = pairExpansion.pair
    let occurrenceCounts = [pair.first, pair.second, rules[pair]!].reduce(into: [:]) { result, value in result[value, default: UInt64(0)] += 1 }
    counts[pairExpansion] = occurrenceCounts
    return occurrenceCounts
  }

  var occurrenceCounts = [Character: UInt64]()
  for expansion in pairExpansion.expandOnce() {
    var newOccurrenceCounts = updateOccurrenceCounts(in: &counts, for: expansion)
    newOccurrenceCounts[expansion.pair.second]! -= 1 // the second char of the pair will be counted in the next expansion (or after the loop if it's the final one)
    occurrenceCounts.merge(newOccurrenceCounts, uniquingKeysWith: +)
  }
  occurrenceCounts[pairExpansion.pair.second]! += 1 // add back in the final char

  counts[pairExpansion] = occurrenceCounts
  return occurrenceCounts
}

func growPolymer(_ times: Int) -> UInt64 {
  // use dynamic programming to pre-fill counts
  var counts = [PairExpansion: [Character: UInt64]]()
  for i in 1...times {
    for (pair, _) in rules {
      updateOccurrenceCounts(in: &counts, for: PairExpansion(pair, i))
    }
  }

  let expansions = template.adjacentPairs().map(Pair.init).map { PairExpansion($0, times) }

  var occurrenceCounts = [Character: UInt64]()
  for expansion in expansions {
    var newOccurrenceCounts = updateOccurrenceCounts(in: &counts, for: expansion)
    newOccurrenceCounts[expansion.pair.second]! -= 1
    occurrenceCounts.merge(newOccurrenceCounts, uniquingKeysWith: +)
  }
  occurrenceCounts[expansions.last!.pair.second]! += 1

  let max = occurrenceCounts.map { $0 }.max(by: makeSorter(for: \.1))!
  let min = occurrenceCounts.map { $0 }.min(by: makeSorter(for: \.1))!
  return max.1 - min.1
}

public func partOne() {
 // print(NaïveSolution.partOne())
  print(growPolymer(10)) // 2797
}

public func partTwo() {
  print(growPolymer(40)) // 2926813379532
}


enum NaïveSolution {
  private static func inserting(rules: [Pair: Character], into template: [Character]) -> [Character] {
    template
      .lazy
      .adjacentPairs()
      .map(Pair.init)
      .flatMap { pair -> [Character] in
        let insertion = rules[pair]
        return insertion == nil ? [pair.first] : [pair.first, insertion!]
      } + [template.last!]
  }

  static func partOne() -> Int {
    var result = template
    for _ in 0..<10 {
      result = inserting(rules: rules, into: result)
    }

    let counts = result.occurrenceCounts()
    let max = counts.max(by: makeSorter(for: \.count))!
    let min = counts.min(by: makeSorter(for: \.count))!
    return max.count - min.count

  }
}
