import Algorithms

func printVars(_ vars: [Identifier: Int]) {
    print("[w: \(vars[.w]!), x: \(vars[.x]!), y: \(vars[.y]!), z: \(vars[.z]!) ]")
//  print("w: \(vars[.w]!)")
//  print("x: \(vars[.x]!)")
//  print("y: \(vars[.y]!)")
//  print("z: \(vars[.z]!)")
}

func printInstruction(_ i: Instruction) {
  print("\(i.op.rawValue) \(i.dest.rawValue) \(i.arg)")
}

//public func partOne () {
//  let sections = input.components(separatedBy: "inp w").map { $0.split(separator: "\n") }.dropFirst()
//  let first = sections.first!
//  for i in first.indices {
//    let line = first[i]
//    if !sections.allSatisfy({ $0[i] == line }) {
//      let instructions = sections.map { $0[i] }.map(buildInstruction)
//      print("line \(i) DOES NOT match")
//      if i == 3 || i == 4 || i == 14 {
//        let args: [Int] = instructions.compactMap {
//          if case .value(let value) = $0.arg {
//            return value
//          }
//          return nil
//        }
//        print(args)
//      }
//    }
//  }
//}

//public func partOne () {
//  let sections = input.components(separatedBy: "inp w").map { $0.split(separator: "\n") }.dropFirst()
//  let first = sections.first!
//  for i in first.indices {
//    let line = first[i]
//    if sections.allSatisfy({ $0[i] == line }) {
//      print("line \(i) matches")
//    } else {
//      let instructions = sections.map { $0[i] }.map(buildInstruction)
//      print("line \(i) DOES NOT match")
//      if i == 3 {
//        print(instructions.allSatisfy { $0.op == .div && $0.dest == .z && $0.arg.isValue })
//      } else if i == 4 {
//        //add x {num2}
//        print(instructions.allSatisfy { $0.op == .add && $0.dest == .x && $0.arg.isValue })
//      } else if i == 14 {
//        //add y {num3}
//        print(instructions.allSatisfy { $0.op == .add && $0.dest == .y && $0.arg.isValue })
//      }
//    }
//  }
//}

func inspect(instruction: Instruction, variables: [Identifier: Int]) {
  if instruction.op == .inp {
    print("#############")
  }
  printInstruction(instruction)
  printVars(variables)
  print()
}

func run(_ alu: inout ALU, with value: UInt64) -> Int {
  run(&alu, with: Array(String(value)))
}

func run(_ alu: inout ALU, with value: [Character]) -> Int {
  var valueSlice = ArraySlice(value)
  let vars = alu.run { valueSlice.removeFirst() }
  return vars[.z]!
}

func run(with value: UInt64) -> Int {
  run(with: Array(String(value)))
}

//func process(input: Int, z: Int, val1: Int, val2: Int, val3: Int) -> Int {
//  var x = z % 26 + val2
//  var z = z
//
//  z /= val1
//
//  x = x == input ? 0 : 1
//
//  let temp1 = 25 * x + 1
//  z *= temp1
//
//  let temp2 = (input + val3) * x
//  z += temp2
//
//  return z
//}

func process(input: Int, previous: Int, shouldDivide: Bool, val2: Int, val3: Int) -> Int {
  var next = previous

  if shouldDivide {
    next /= 26
  }

  if previous % 26 != input - val2 {
    next *= 26
    next += input + val3
  }
  return next
}

func run(with value: [Character]) -> Int {
  var val1: ArraySlice = [ 1,  1,  1, 26,  1,  1,  1, 26, 26,  1, 26, 26, 26, 26]
  var val2: ArraySlice = [11, 14, 10,  0, 12, 12, 12, -8, -9, 11,  0, -5, -6, -12]
  var val3: ArraySlice = [ 8, 13,  2,  7, 11,  4, 13, 13, 10,  1,  2, 14,  6, 14]
  var inputs = ArraySlice(value.compactMap(Int.init))

  var result = 0
  while !inputs.isEmpty {
    result = process(input: inputs.removeFirst(),
                     previous: result,
                     shouldDivide: val1.removeFirst() == 26,
                     val2: val2.removeFirst(),
                     val3: val3.removeFirst())
  }
  return result
}

public func partOne() {
  let values = (10_000_000_000_000...99_999_999_999_999)
    .lazy
    .reversed()
    .map { Array(String($0)) }
    .filter { !$0.contains("0") }

  var alu = ALU(input)
//  //alu.inspector = inspect
//
  let value: UInt64 = 55_292_431_582_843
  let z1 = run(&alu, with: value)
  let z2 = run(with: value)

  print(z1 == z2)

//  for value in values {
//    if run(with: value) == 0 {
//      print(String(value))
//      return
//    }
//  }

//  for value in values {
//    if run(&alu, with: value) == 0 {
//      print(String(value))
//      return
//    }
//  }
}

public func partTwo() {

}
