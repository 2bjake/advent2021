struct StepProcessor {
  private var onShapes = [Shape]()

  private mutating func processOn(_ shape: Shape) {
    var curShape = shape
    for onShape in onShapes where onShape.overlaps(curShape) {
      curShape = subtract(shape: onShape, fromShape: curShape)
    }
    onShapes.append(curShape)
  }

  private mutating func processOff(_ offShape: Shape) {
    var newShapes = [Shape]()
    for onShape in onShapes {
      if onShape.overlaps(offShape) {
        newShapes.append(subtract(shape: offShape, fromShape: onShape))
      } else {
        newShapes.append(onShape)
      }
    }
    onShapes = newShapes
  }

  mutating func process(_ steps: [Step]) -> UInt64 {
    for step in steps {
      if step.state == .on {
        processOn(step.shape)
      } else {
        processOff(step.shape)
      }
    }
    return onShapes.map(\.count).reduce(0, +)
  }
}
