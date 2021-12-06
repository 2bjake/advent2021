import Foundation

public func printMillisecondsElapsed(for work: () -> Void) {
  let seconds = String(format: "%.4f", millisecondsElapsed(for: work))
  print("\(seconds) ms")
}

public func millisecondsElapsed(for work: () -> Void) -> Double {
  let start = DispatchTime.now()
  work()
  let end = DispatchTime.now()
  let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
  return Double(nanoTime) / 1_000_000
}
