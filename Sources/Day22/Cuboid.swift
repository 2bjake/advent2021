struct Cuboid: Shape {
  var xRange: ClosedRange<Int>
  var yRange: ClosedRange<Int>
  var zRange: ClosedRange<Int>

  var count: UInt64 { UInt64(xRange.count) * UInt64(yRange.count) * UInt64(zRange.count) }

  func overlaps(_ shape: Shape) -> Bool {
    if let cuboid = shape as? Cuboid {
      return overlaps(cuboid)
    } else {
      return shape.overlaps(self)
    }
  }

  func overlaps(_ cuboid: Cuboid) -> Bool {
    xRange.overlaps(cuboid.xRange) && yRange.overlaps(cuboid.yRange) && zRange.overlaps(cuboid.zRange)
  }

  func clamped(to cuboid: Cuboid) -> Cuboid {
    guard self.overlaps(cuboid) else { fatalError() }

    var result = self
    result.xRange = xRange.clamped(to: cuboid.xRange)
    result.yRange = yRange.clamped(to: cuboid.yRange)
    result.zRange = zRange.clamped(to: cuboid.zRange)
    return result
  }
}

extension Cuboid {
  func clamped(to clampRange: ClosedRange<Int>) -> Cuboid? {
    guard xRange.overlaps(clampRange) && yRange.overlaps(clampRange) && zRange.overlaps(clampRange) else { return nil }

    var clamped = self
    clamped.xRange = xRange.clamped(to: clampRange)
    clamped.yRange = yRange.clamped(to: clampRange)
    clamped.zRange = zRange.clamped(to: clampRange)
    return clamped
  }
}
