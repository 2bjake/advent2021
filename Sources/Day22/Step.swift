import Extensions

struct Step {
  enum State: String { case on, off }
  var state: State
  var shape: Shape
}

extension Step {
  init(_ source: Substring) {
    let parts = source.split(separator: " ")
    state = State(rawValue: String(parts[0]))!
    shape = Self.buildCuboid(parts[1])
  }

  private static func buildRange(_ source: Substring) -> ClosedRange<Int> {
    let numbers = source.dropFirst(2).split(separator: ".").compactMap(Int.init)
    return numbers[0]...numbers[1]
  }

  private static func buildCuboid(_ source: Substring) -> Cuboid {
    let ranges = source.split(separator: ",").map(Self.buildRange)
    return Cuboid(xRange: ranges[0], yRange: ranges[1], zRange: ranges[2])
  }
}

extension Step {
  func clamped(to clampRange: ClosedRange<Int>) -> Step? {
    guard let originalCuboid = shape as? Cuboid, let clampedCuboid = originalCuboid.clamped(to: clampRange) else { return nil }
    var result = self
    result.shape = clampedCuboid
    return result
  }
}
