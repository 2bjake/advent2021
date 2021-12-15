import Extensions

// Assumes regular input (single digit units, only
// 'forward' 'up' and 'down' with no typos)
func processCommands() -> (Int, Int, Int) {
  input.reduce(into: (0, 0, 0)) { values, command in
    let units = Int(command.last!)!
    switch command.first {
      case "f":
        values.0 += units
        values.1 += units * values.2
      case "u":
        values.2 -= units
      case "d":
        values.2 += units
      default:
        fatalError("unexpected command: \(command)")
    }
  }
}

public func partOne() {
  let (horizontalPos, _, depth) = processCommands()
  assert(horizontalPos * depth == 1660158) // 1660158
}

public func partTwo() {
  let (horizontalPos, depth, _) = processCommands()
  assert(horizontalPos * depth == 1604592846) // 1604592846
}



// A Swiftier version that defined a Command type which
// accepts multi-digit units and will reject anything except
// 'forward' 'up' and 'down'
enum Swifty {
  struct Command {
    enum Direction: String { case forward, up, down }
    var direction: Direction
    var units: Int

    init<S: StringProtocol>(_ source: S) {
      let parts = source.split(separator: " ")
      self.direction = Direction(rawValue: String(parts[0]))!
      self.units = Int(parts[1])!
    }
  }

  static func processCommands() -> (Int, Int, Int) {
    input
      .lazy
      .map(Command.init)
      .reduce(into: (0, 0, 0)) { values, command in
        switch command.direction {
          case .forward:
            values.0 += command.units
            values.1 += command.units * values.2
          case .up:
            values.2 -= command.units
          case .down:
            values.2 += command.units
        }
      }
  }
}
