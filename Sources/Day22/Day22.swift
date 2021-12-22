public func partOne() {
  let steps = input.map(Step.init).compactMap { $0.clamped(to:  -50...50) }
  var processor = StepProcessor()
  print(processor.process(steps)) // 647076
}

public func partTwo() {
  let steps = input.map(Step.init)
  var processor = StepProcessor()
  print(processor.process(steps)) // 1233304599156793
}
