import Algorithms
import Extensions

extension Range3D {
  func clamped(to clampRange: ClosedRange<Int>) -> Range3D? {
    guard xRange.overlaps(clampRange) && yRange.overlaps(clampRange) && zRange.overlaps(clampRange) else { return nil }

    var clamped = self
    clamped.xRange = xRange.clamped(to: clampRange)
    clamped.yRange = yRange.clamped(to: clampRange)
    clamped.zRange = zRange.clamped(to: clampRange)
    return clamped
  }
}

struct Point3D: Hashable {
  var x: Int
  var y: Int
  var z: Int
}

extension Range3D {
  var allPoints: [Point3D] {
    var result = [Point3D]()
    for x in xRange {
      for y in yRange {
        for z in zRange {
          result.append(Point3D(x: x, y: y, z: z))
        }
      }
    }
    return result
  }
}

public func partOne() {
  let clampRange = -50...50
  let ranges = input.map(Range3D.init).compactMap { $0.clamped(to: clampRange) }

  let cubeStates: [Point3D: Flip] = ranges.reduce(into: [:]) { result, range in
    for point in range.allPoints {
      result[point] = range.flip
    }
  }
  print(cubeStates.values.count { $0 == .on })
}

public func partTwo() {
  //let ranges = input.map(Range3D.init)

  //var onRanges = [Range3D]()

  let myRange = 0...2000

  let ranges = myRange.split(separator: 1000)
  for range in ranges {
    print("\(range.startIndex)...\(range.endIndex)")
  }


}
