enum Flip: String {
  case on
  case off
}

protocol Shape {
  var count: UInt64 { get }
  func overlaps(_ shape: Shape) -> Bool
  func subtracting(_ shape: Shape) -> Shape
}

struct Irregular: Shape {
  var shapes: [Shape]

  var count: UInt64 { shapes.map(\.count).reduce(0, +) }

  func overlaps(_ shape: Shape) -> Bool {
    if let cuboid = shape as? Cuboid {
      return overlaps(cuboid)
    } else {
      return shapes.contains { shape.overlaps($0) }
    }
  }

  func overlaps(_ cuboid: Cuboid) -> Bool {
    shapes.contains { cuboid.overlaps($0) }
  }

  func subtracting(_ shape: Shape) -> Shape {
    fatalError()
  }
}

struct Cuboid: Shape {
  var xRange: ClosedRange<Int>
  var yRange: ClosedRange<Int>
  var zRange: ClosedRange<Int>
  var flip: Flip = .on

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
    var result = self
    result.xRange = xRange.clamped(to: cuboid.xRange)
    result.yRange = yRange.clamped(to: cuboid.yRange)
    result.zRange = zRange.clamped(to: cuboid.zRange)
    return result
  }

  func subtracting(_ shape: Shape) -> Shape {
    if let cuboid = shape as? Cuboid {
      return subtracting(cuboid)
    } else {
      fatalError()
    }
  }

  func subtracting(_ cuboid: Cuboid) -> Shape {
    guard self.overlaps(cuboid) else { return self }
    let clamped = cuboid.clamped(to: self)
    let A = Cuboid(xRange: xRange.lowerBound...(clamped.xRange.lowerBound - 1),
                   yRange: yRange,
                   zRange: zRange)
    let B = Cuboid(xRange: (clamped.xRange.upperBound + 1)...xRange.upperBound,
                   yRange: yRange,
                   zRange: zRange)
    let C = Cuboid(xRange: clamped.xRange,
                   yRange: (clamped.yRange.upperBound + 1)...yRange.upperBound,
                   zRange: zRange)
    let D = Cuboid(xRange: clamped.xRange,
                   yRange: yRange.lowerBound...(clamped.yRange.lowerBound - 1),
                   zRange: zRange)
    let E = Cuboid(xRange: clamped.xRange,
                   yRange: clamped.yRange,
                   zRange: zRange.lowerBound...(clamped.zRange.lowerBound - 1))
    let F = Cuboid(xRange: clamped.xRange,
                   yRange: clamped.yRange,
                   zRange: (clamped.zRange.upperBound + 1)...zRange.upperBound)
    return Irregular(shapes: [A, B, C, D, E, F])
  }
}

extension Cuboid {
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
