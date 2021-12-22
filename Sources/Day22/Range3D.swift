enum Flip: String {
  case on
  case off
}

struct Range3D {
  var xRange: ClosedRange<Int>
  var yRange: ClosedRange<Int>
  var zRange: ClosedRange<Int>
  var flip: Flip

  var count: UInt64 { UInt64(xRange.count) * UInt64(yRange.count) * UInt64(zRange.count) }

  func overlaps(_ other: Range3D) -> Bool {
    xRange.overlaps(other.xRange) && yRange.overlaps(other.yRange) && zRange.overlaps(other.zRange)
  }
}

extension Range3D {
  init(_ source: Substring) {
    let parts = source.split(separator: " ")
    flip = Flip(rawValue: String(parts[0]))!
    let ranges = parts[1].split(separator: ",").map(Self.buildRange)
    xRange = ranges[0]
    yRange = ranges[1]
    zRange = ranges[2]
  }

  private static func buildRange(_ source: Substring) -> ClosedRange<Int> {
    let numbers = source.dropFirst(2).split(separator: ".").compactMap(Int.init)
    return numbers[0]...numbers[1]
  }
}
