import Extensions

struct ALU {
  private var instructions: [Instruction]

  private var variables: [Identifier: Int] = [:]
  private var instructionStack: [Instruction] = []
  private var inputRetrieval: (() -> Character)!

  var inspector: ((Instruction, [Identifier: Int]) -> Void)?

  init(_ source: String) {
    instructions = source.split(separator: "\n").map(buildInstruction)
    reset()
  }

  mutating func reset() {
    Identifier.allCases.forEach { variables[$0] = 0 }
    instructionStack = instructions.reversed()
    inputRetrieval = nil
  }

  private func retrieveInput() -> Int {
    let char = inputRetrieval()
    guard char != "0" else { fatalError() }
    return Int(char)!
  }

  private func value(_ id: Identifier) -> Int { variables[id]! }

  private func value(_ arg: Argument) -> Int {
    switch arg {
      case .variable(let id): return value(id)
      case .value(let value): return value
      case .none: fatalError()
    }
  }

  private func result(for instruction: Instruction) -> Int {
    let (op, dest, arg) = instruction
    let a = value(dest)
    let b = op == .inp ? retrieveInput() : value(arg)

    switch instruction.op {
      case .inp: return b
      case .add: return a + b
      case .mul: return a * b
      case .div:
        guard b != 0 else { fatalError() }
        return a / b
      case .mod:
        guard a >= 0 && b > 0 else { fatalError() }
        return a % b
      case .eql: return a == b ? 1 : 0
    }
  }

  mutating func run(inputRetrieval: @escaping () -> Character) -> [Identifier: Int] {
    reset()
    self.inputRetrieval = inputRetrieval
    while let instruction = instructionStack.popLast() {
      variables[instruction.dest] = result(for: instruction)
      inspector?(instruction, variables)
    }
    return variables
  }
}

func run(_ alu: inout ALU, with value: UInt64) -> Int {
  run(&alu, with: Array(String(value)))
}

func run(_ alu: inout ALU, with value: [Character]) -> Int {
  var valueSlice = ArraySlice(value)
  let vars = alu.run { valueSlice.removeFirst() }
  return vars[.z]!
}
