import Foundation

public func printMillisElapsed(_ description: String = "", for work: () -> Void) {
  printAvgMillisElapsed(description, runTimes: 1, for: work)
}

public func printAvgMillisElapsed(_ description: String = "", runTimes: Int = 1, for work: () -> Void) {
  var avg = 0.0
  for _ in 0..<runTimes {
    avg += millisecondsElapsed(for: work)
  }
  avg /= Double(runTimes)

  let timesDescription = runTimes == 1 ? "" : " - average from running \(runTimes) times"

  print("\(String(format: "%.4f", avg)) ms \(description)\(timesDescription)")
}

public func millisecondsElapsed(for work: () -> Void) -> Double {
  let start = DispatchTime.now()
  work()
  let end = DispatchTime.now()
  let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
  return Double(nanoTime) / 1_000_000
}
