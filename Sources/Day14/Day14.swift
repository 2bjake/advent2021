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

func growPolymer(_ times: Int) -> UInt64 {
  let (template, rules) = parse()

  var calculator = OccurrenceCalculator(rules: rules)
  let occurrences = calculator.calculateOccurrences(in: template, expandingTimes: times)
  let (min, max) = occurrences.values.minAndMax()!
  return max - min
}

public func partOne() {
  print(growPolymer(10)) // 2797
}

public func partTwo() {
  print(growPolymer(40)) // 2926813379532
}
