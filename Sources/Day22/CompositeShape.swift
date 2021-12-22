struct CompositeShape: Shape {
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
}
