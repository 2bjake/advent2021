import Algorithms
import Extensions

enum NaiveSolution {
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
    let (template, rules) = parse()
    var result = template
    for _ in 0..<10 {
      result = inserting(rules: rules, into: result)
    }

    let counts = result.occurrenceCounts()
    let max = counts.max(by: sorter(for: \.count))!
    let min = counts.min(by: sorter(for: \.count))!
    return max.count - min.count
  }
}
