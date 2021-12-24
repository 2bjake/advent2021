import Algorithms

//func printVars(_ vars: [Identifier: Int]) {
//  print("[w: \(vars[.w]!), x: \(vars[.x]!), y: \(vars[.y]!), z: \(vars[.z]!) ]")
//}
//
//func printInstruction(_ i: Instruction) {
//  print("\(i.op.rawValue) \(i.dest.rawValue) \(i.arg)")
//}
//
//func inspect(instruction: Instruction, variables: [Identifier: Int]) {
//  if instruction.op == .inp {
//    print("#############")
//  }
//  printInstruction(instruction)
//  printVars(variables)
//  print()
//}

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

var cache: [[Int]: Int] = [:]

//func findLongestCacheHit(_ value: [Int]) -> [Int] {
//  var prefixLength = 1
//  while prefixLength <= value.count && cache[Array(value.prefix(prefixLength))] != nil {
//    prefixLength += 1
//  }
//
//  guard prefixLength > 0 else { return [] }
//
//  return Array(value.prefix(prefixLength - 1))
//}

func findLongestCacheHit(_ value: [Int]) -> [Int] {
  var prefix = ArraySlice(value)
  while !prefix.isEmpty {
    let arr = Array(prefix)
    if cache[Array(prefix)] != nil { return arr }
    prefix = prefix.dropLast()
  }
  return []
}

func run(with value: [Character]) -> Int {
  var val2: ArraySlice = [-11, -14, -10,  0, -12, -12, -12,  8,  9, -11,  0,  5,  6, 12]
  var val3: ArraySlice = [  8,  13,   2,  7,  11,   4,  13, 13, 10,   1,  2, 14,  6, 14]

  let values = value.compactMap(Int.init)
  var processed = findLongestCacheHit(values)
  var result = cache[processed] ?? 0

//  print("\(processed): \(result)")
  var inputs = ArraySlice(values).dropFirst(processed.count)
  val2 = val2.dropFirst(processed.count)
  val3 = val3.dropFirst(processed.count)

  while !inputs.isEmpty {
    let value2 = val2.removeFirst()
    let value3 = val3.removeFirst()
    let input = inputs.removeFirst()
    processed.append(input)
    if cache[processed] == nil {
      cache[processed] = process(input: input,
                                 previous: result,
                                 val2: value2,
                                 val3: value3)
    }
    //print("\(input): \(cache[processed]!)")
    result = cache[processed]!
  }
  return result
}

//func run(with value: [Character]) -> Int {
//  var val2: ArraySlice = [-11, -14, -10,  0, -12, -12, -12,  8,  9, -11,  0,  5,  6, 12]
//  var val3: ArraySlice = [  8,  13,   2,  7,  11,   4,  13, 13, 10,   1,  2, 14,  6, 14]
//
//  var inputs = ArraySlice(value.compactMap(Int.init))
//
//  var processed = [Int]()
//  var result = 0
//  while !inputs.isEmpty {
//    let input = inputs.removeFirst()
//    processed.append(input)
//    if cache[processed] == nil {
//      cache[processed] = process(input: input,
//                                 previous: result,
//                                 val2: val2.removeFirst(),
//                                 val3: val3.removeFirst())
//    }
//    result = cache[processed]!
//  }
//  return result
//}

var positiveCache: [PositiveValues: Int] = [:]
var negativeCache: [NegativeValues: Int] = [:]

func process(input: Int, previous: Int, val2: Int, val3: Int) -> Int {
  if val2 >= 0 {
    let values = PositiveValues(input: input, previous: previous, val2: val2, val3: val3)
    if positiveCache[values] == nil {
      positiveCache[values] = processPositive(values)
    }
    return positiveCache[values]!
  } else {
    let values = NegativeValues(input: input, previous: previous, val3: val3)
    if negativeCache[values] == nil {
      negativeCache[values] = processNegative(values)
    }
    return negativeCache[values]!
  }
}

struct NegativeValues: Hashable {
  var input: Int
  var previous: Int
  var val3: Int
}

func processNegative(_ values: NegativeValues) -> Int {
  values.previous * 26 + values.input + values.val3
}

struct PositiveValues: Hashable {
  var input: Int
  var previous: Int
  var val2: Int
  var val3: Int
}

func processPositive(_ values: PositiveValues) -> Int {
  var next = values.previous / 26
  if values.previous % 26 - values.val2 != values.input {
    next = next * 26 + values.input + values.val3
  }
  return next
}

public func partOne() {
    let values = (10_000_000_000_000...99_999_999_999_999)
      .lazy
      .reversed()
      .map { Array(String($0)) }
      .filter { !$0.contains("0") }

  for value in values {
    if run(with: value) == 0 {
      print(value)
      return
    }
  }
}

//public func partOne() {
//  let values: [UInt64] = [
//    95_292_431_512_841,
//    95_292_431_512_841,
//    95_292_431_562_843,
//    95_292_431_562_843,
//    15_282_431_312_743,
//    95_292_222_512_843,
//    82_292_431_512_243
//  ]
//
//  var alu = ALU(input)
//  for value in values {
//    let z1 = run(&alu, with: value)
//    let z2 = run(with: value)
//    print(z1)
//    assert(z1 == z2)
//  }
//
////  printPositiveMatches(target: 0...0, index: 13)
////  printPositiveMatches(target: 13...21, index: 12)
////  printPositiveMatches(target: 0...25, index: 11)
//}

public func partTwo() {

}

