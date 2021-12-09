import Extensions

private enum Segment: Character {
  case top = "a"
  case upperLeft = "b"
  case upperRight = "c"
  case middle = "d"
  case lowerLeft = "e"
  case lowerRight = "f"
  case bottom = "g"
}

struct Converter {
  private static let uniqueWireCountForDigit = [1: 2, 4: 4, 7: 3, 8: 7]

  private let signalForDigit: [Int : Signal]
  private let signalsForWireCount: [Int: [Signal]]

  init(_ signals: [Signal]) {
    let signalsForWireCount = Dictionary(grouping: signals, by: \.count)
    self.signalsForWireCount = signalsForWireCount
    signalForDigit = Self.uniqueWireCountForDigit.mapValues { signalsForWireCount[$0]!.only! }
  }

  func build() -> (Signal) -> Signal {
    let mapping = buildMapping()
    return { signal in
      Set(signal.map { mapping[$0]! })
    }
  }

  private func buildMapping() -> [Character: Character] {
    let top = wire(in: 7, butNotIn: 1)

    let (lowerRight, upperRight) = wires(in: 1, orderedBy: isInAllSignalsWithWireCount(6))
    let (middle, upperLeft) = wires(in: 4, butNotIn: 1, orderedBy: isInAllSignalsWithWireCount(5))
    let mask = signalForDigit(4).inserting(top)
    let (bottom, lowerLeft) = wires(in: 8, butNotIn: mask, orderedBy: isInAllSignalsWithWireCount(5))

    return [
      top: Segment.top,
      upperLeft: .upperLeft,
      upperRight: .upperRight,
      middle: .middle,
      lowerLeft: .lowerLeft,
      lowerRight: .lowerRight,
      bottom: .bottom
    ].mapValues(\.rawValue)
  }
}

// helper code to make algorithm code read more fluently
private extension Converter {
  func signalForDigit(_ digit: Int) -> Signal {
    guard let signal = signalForDigit[digit] else { fatalError() }
    return signal
  }

  // makes a predicate which checks if a wire is in all signals with the specified wire count
  func isInAllSignalsWithWireCount(_ count: Int) -> (Character) -> Bool {
    return { wire in
      signalsForWireCount[count]!.allSatisfy { $0.contains(wire) }
    }
  }

  func wires(in aSet: Set<Character>, butNotIn bSet: Set<Character>) -> Set<Character> {
    aSet.subtracting(bSet)
  }

  func wire(in aInt: Int, butNotIn bInt: Int) -> Character {
    wires(in: aInt, butNotIn: bInt).only!
  }

  func wires(in aInt: Int, butNotIn bInt: Int? = nil) -> Set<Character> {
    let bSet = bInt != nil ? signalForDigit(bInt!) : []
    return wires(in: signalForDigit(aInt), butNotIn: bSet)
  }

  func wires(in signal: Set<Character>, orderedBy predicate: (Character) -> Bool) -> (Character, Character) {
    guard signal.count == 2 else { fatalError() }
    let first = signal.first!
    let second = signal.dropFirst().first!
    return predicate(first) ? (first, second) : (second, first)
  }

  func wires(in aInt: Int, butNotIn bInt: Int? = nil, orderedBy predicate: (Character) -> Bool) -> (Character, Character) {
    let signal = wires(in: aInt, butNotIn: bInt)
    return wires(in: signal, orderedBy: predicate)
  }

  func wires(in int: Int, butNotIn set: Set<Character>, orderedBy predicate: (Character) -> Bool) -> (Character, Character) {
    let signal = wires(in: signalForDigit(int), butNotIn: set)
    return wires(in: signal, orderedBy: predicate)
  }
}
