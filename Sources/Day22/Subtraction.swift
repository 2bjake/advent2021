func subtract(shape: Shape, fromShape: Shape) -> Shape {
  switch (shape, fromShape) {
    case let (cuboid, fromCuboid) as (Cuboid, Cuboid):
      return subtract(cuboid, from: fromCuboid)
    case let (cuboid, fromComposite) as (Cuboid, CompositeShape):
      return subtract(cuboid, from: fromComposite)
    case let (composite, fromCuboid) as (CompositeShape, Cuboid):
      return subtract(composite, from: fromCuboid)
    case let (composite, fromComposite) as (CompositeShape, CompositeShape):
      return subtract(composite, from: fromComposite)
    default:
      fatalError()
  }
}

func subtract(_ cuboid: Cuboid, from fromCuboid: Cuboid) -> Shape {
  guard cuboid.overlaps(fromCuboid) else { return fromCuboid }
  let clamped = cuboid.clamped(to: fromCuboid)

  var shapes = [Shape]()

  // A
  if fromCuboid.xRange.lowerBound != clamped.xRange.lowerBound {
    shapes.append(Cuboid(xRange: fromCuboid.xRange.lowerBound...(clamped.xRange.lowerBound - 1),
                         yRange: fromCuboid.yRange,
                         zRange: fromCuboid.zRange))
  }

  // B
  if fromCuboid.xRange.upperBound != clamped.xRange.upperBound {
    shapes.append(Cuboid(xRange: (clamped.xRange.upperBound + 1)...fromCuboid.xRange.upperBound,
                         yRange: fromCuboid.yRange,
                         zRange: fromCuboid.zRange))
  }

  // C
  if fromCuboid.yRange.lowerBound != clamped.yRange.lowerBound {
    shapes.append(Cuboid(xRange: clamped.xRange,
                         yRange: fromCuboid.yRange.lowerBound...(clamped.yRange.lowerBound - 1),
                         zRange: fromCuboid.zRange))
  }

  // D
  if fromCuboid.yRange.upperBound != clamped.yRange.upperBound {
    shapes.append(Cuboid(xRange: clamped.xRange,
                         yRange: (clamped.yRange.upperBound + 1)...fromCuboid.yRange.upperBound,
                         zRange: fromCuboid.zRange))
  }

  // E
  if fromCuboid.zRange.lowerBound != clamped.zRange.lowerBound {
    shapes.append(Cuboid(xRange: clamped.xRange,
                         yRange: clamped.yRange,
                         zRange: fromCuboid.zRange.lowerBound...(clamped.zRange.lowerBound - 1)))
  }

  // F
  if fromCuboid.zRange.upperBound != clamped.zRange.upperBound {
    shapes.append(Cuboid(xRange: clamped.xRange,
                         yRange: clamped.yRange,
                         zRange: (clamped.zRange.upperBound + 1)...fromCuboid.zRange.upperBound))
  }
  return CompositeShape(shapes: shapes) // TODO: shapes is potentially empty...
}

func subtract(_ cuboid: Cuboid, from fromComposite: CompositeShape) -> Shape {
  let newShapes = fromComposite.shapes.map { subtract(shape: cuboid, fromShape: $0) }
  return CompositeShape(shapes: newShapes)
}

func subtract(_ composite: CompositeShape, from fromCuboid: Cuboid) -> Shape {
  var fromShape: Shape = fromCuboid
  for shape in composite.shapes {
    fromShape = subtract(shape: shape, fromShape: fromShape)
  }
  return fromShape
}

func subtract(_ composite: CompositeShape, from fromComposite: CompositeShape) -> Shape {
  var newShapes = [Shape]()

  for fromShape in fromComposite.shapes {
    var curShape = fromShape
    for subtractingShape in composite.shapes {
      curShape = subtract(shape: subtractingShape, fromShape: curShape)
    }
    newShapes.append(curShape)
  }

  return CompositeShape(shapes: newShapes)
}
