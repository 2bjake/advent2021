import Extensions

struct Converter {
  private enum Segment: Character, CaseIterable {
    case top = "a"
    case upperLeft = "b"
    case upperRight = "c"
    case middle = "d"
    case lowerLeft = "e"
    case lowerRight = "f"
    case bottom = "g"
  }

  private let converter: [Character: Character]

  init(_ signals: [Signal]) {
    self.converter = Self.buildConverter(signals)
  }

  func convert(_ signal: Signal) -> Signal {
    Set(signal.map { converter[$0]! })
  }

  func callAsFunction(_ signal: Signal) -> Signal { convert(signal) }

  private static func buildConverter(_ signals: [Signal]) -> [Character: Character] {
    let segmentCountToSignals = Dictionary(grouping: signals, by: \.count)

    let digitToSignal = [1: 2, 4: 4, 7: 3, 8: 7].mapValues { segmentCountToSignals[$0]!.first! }

    var segmentToChar: [Segment: Character] = [:]

    // top is the segment in 7 that is not in 1
    segmentToChar[.top] = digitToSignal[7]!.subtracting(digitToSignal[1]!).first!

    // lowerRight is the segment in 1 that is in all signals where segment count = 6
    segmentToChar[.lowerRight] = digitToSignal[1]!.first { char in
      segmentCountToSignals[6]!.allSatisfy { $0.contains(char) }
    }!

    // upperRight is the segment in 1 that is not lowerRight
    segmentToChar[.upperRight] = digitToSignal[1]!.subtracting([segmentToChar[.lowerRight]!]).first!

    // middle is the segment in 4 but not in 1 that is in all signals where segment count = 5
    let possibleMiddles = digitToSignal[4]!.subtracting(digitToSignal[1]!)
    let middleSet = possibleMiddles.filter { char in
      segmentCountToSignals[5]!.allSatisfy { $0.contains(char) }
    }
    segmentToChar[.middle] = middleSet.first!

    // upperLeft is the segment in 4 but not in 1 that is not middle
    segmentToChar[.upperLeft] = possibleMiddles.subtracting(middleSet).first!

    // zero signal is all segments of 8 + middle
    let zeroSignalSet = digitToSignal[8]!.union(middleSet)

    // remaining segments (bottom & lowerLeft) can be found by subtracting from zero, the segments in 4 and the top segment
    let possibleBottoms = zeroSignalSet.subtracting(digitToSignal[4]! + [segmentToChar[.top]!])

    // bottom is the segment in possibleSegments that is in all signals where count = 5
    let bottomSet = possibleBottoms.filter { char in
      segmentCountToSignals[5]!.allSatisfy { $0.contains(char) }
    }
    segmentToChar[.bottom] = bottomSet.first!

    // lowerLeft is segment in possibleSegments that is not bottom
    segmentToChar[.lowerLeft] = possibleBottoms.subtracting(bottomSet).first!

    return segmentToChar.flipWithUniqueValues().mapValues(\.rawValue)
  }
}
