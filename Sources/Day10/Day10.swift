import Extensions

enum ParseResult {
  case success
  case corrupted(Character)
  case incomplete([Character])
}

extension ParseResult {
  private static let scoreForIllegal: [Character: Int] = [
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137
  ]

  private static let scoreForOpening: [Character: Int] = [
    "(": 1,
    "[": 2,
    "{": 3,
    "<": 4
  ]

  var score: Int {
    switch self {
      case .success:
        return 0
      case .corrupted(let illegal):
        return Self.scoreForIllegal[illegal]!
      case .incomplete(let expected):
        return expected.reduce(0) { result, opening in
          result * 5 + Self.scoreForOpening[opening]!
        }
    }
  }

  var isIncomplete: Bool {
    if case .incomplete = self { return true }
    return false
  }

  var isCorrupted: Bool {
    if case .corrupted = self { return true }
    return false
  }
}

let openingForClosing: [Character: Character] = [
  ")": "(",
  "}": "{",
  "]": "[",
  ">": "<",
]

func parse<S: StringProtocol>(_ line: S) -> ParseResult {
  var stack = [Character]()
  var remaining = ArraySlice(line)

  while !remaining.isEmpty {
    let char = remaining.removeFirst()
    if openingForClosing[char] == nil {
      stack.append(char)
    } else if openingForClosing[char] != stack.popLast() {
      return .corrupted(char)
    }
  }
  return stack.isEmpty ? .success : .incomplete(stack.reversed())
}

func scores(for keyPath: KeyPath<ParseResult, Bool>) -> [Int] {
  input
    .map(parse)
    .filter { $0[keyPath: keyPath] }
    .map(\.score)
}

public func partOne() {
  let score = scores(for: \.isCorrupted).reduce(0, +)
  assert(score == 374061) // 374061
}

public func partTwo() {
  let scores = scores(for: \.isIncomplete).sorted()
  assert(scores[scores.count / 2] == 2116639949) // 2116639949
}
