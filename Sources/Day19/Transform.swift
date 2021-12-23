struct Transform {
  var rotationNum: Int
  var translation: (x: Int, y: Int, z: Int)

  init(rotationNum: Int, translating from: Point, to: Point) {
    self.rotationNum = rotationNum
    self.translation = to - from.rotated(rotationNum)
  }

  func apply(to points: Set<Point>) -> Set<Point> {
    Set(points.map { $0.rotated(rotationNum) + translation })
  }
}
