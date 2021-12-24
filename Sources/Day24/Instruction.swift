//struct Instruction {
//  let op: Operation
//  let dest: Identifier
//  let arg: Argument
//}

//extension Instruction {
//  init<S: StringProtocol>(_ source: S) {
//    let parts = source.split(separator: " ")
//    self.op = Operation(parts[0])!
//    self.dest = Identifier(parts[1])!
//    self.arg = op == .inp ? .none : Argument(parts[2])
//  }
//}

typealias Instruction = (op: Operation, dest: Identifier, arg: Argument)

func buildInstruction<S: StringProtocol>(_ source: S) -> Instruction {
  let parts = source.split(separator: " ")
  let op = Operation(parts[0])!
  let dest = Identifier(parts[1])!
  let arg = op == .inp ? .none : Argument(parts[2])
  return (op, dest, arg)
}
