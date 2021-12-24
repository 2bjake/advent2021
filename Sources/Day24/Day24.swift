import Algorithms

enum RunResult: Equatable {
  case failure
  case success([Int])

  var value: String? {
    guard case .success(let numbers) = self else { return nil }
    return numbers.map(String.init).joined()
  }
}

func run(path: [Int], value: Int, remainingVal2: ArraySlice<Int>, remainingVal3: ArraySlice<Int>, descending: Bool) -> RunResult {
  guard path.count < 14 else {
    return value == 0 ? .success(path) : .failure
  }

  guard validPreviousForPlace[path.count]!.contains(value) else { return .failure }

  var remainingVal2 = remainingVal2
  var remainingVal3 = remainingVal3

  let val2 = remainingVal2.removeFirst()
  let val3 = remainingVal3.removeFirst()

  var range: [Int] = Array(1...9)
  if descending {
    range = range.reversed()
  }

  for i in range {
    let newValue = process(input: i, previous: value, val2: val2, val3: val3)
    let result = run(path: path + [i], value: newValue, remainingVal2: remainingVal2, remainingVal3: remainingVal3, descending: descending)
    if result != .failure { return result }
  }
  return .failure
}

//var positiveCache: [PositiveValues: Int] = [:]
//var negativeCache: [NegativeValues: Int] = [:]

//func process(input: Int, previous: Int, val2: Int, val3: Int) -> Int {
//  if val2 >= 0 {
//    let values = PositiveValues(input: input, previous: previous, val2: val2, val3: val3)
//    if positiveCache[values] == nil {
//      positiveCache[values] = processPositive(values)
//    }
//    return positiveCache[values]!
//  } else {
//    let values = NegativeValues(input: input, previous: previous, val3: val3)
//    if negativeCache[values] == nil {
//      negativeCache[values] = processNegative(values)
//    }
//    return negativeCache[values]!
//  }
//}

func process(input: Int, previous: Int, val2: Int, val3: Int) -> Int {
  if val2 >= 0 {
    return processPositive(PositiveValues(input: input, previous: previous, val2: val2, val3: val3))
  } else {
    return processNegative(NegativeValues(input: input, previous: previous, val3: val3))
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

func validPreviousValues(validOutput: Set<Int>, idx: Int, upto: Int) -> Set<Int> {
  let val2 = [-11, -14, -10,  0, -12, -12, -12,  8,  9, -11,  0,  5,  6, 12]
  let val3 = [  8,  13,   2,  7,  11,   4,  13, 13, 10,   1,  2, 14,  6, 14]

  var validPreviousValues = Set<Int>()
  for i in 1...9 {
    for j in 0...upto {
      let output = process(input: i, previous: j, val2: val2[idx], val3: val3[idx])
      if validOutput.contains(output) {
        validPreviousValues.insert(j)
      }
    }
  }
  return validPreviousValues
}

var validPreviousForPlace: [Int: Set<Int>] = [:]

public func partOneAndTwo() {
  let val2: ArraySlice = [-11, -14, -10,  0, -12, -12, -12,  8,  9, -11,  0,  5,  6, 12]
  let val3: ArraySlice = [  8,  13,   2,  7,  11,   4,  13, 13, 10,   1,  2, 14,  6, 14]

  var validOutput: Set<Int> = [0]
  for i in (0...13).reversed() {
    var upto: Int
    if val2[i] >= 0 {
      upto = (validOutput.max()! * 26 + 26)
    } else {
      upto = validOutput.max()! / 25
    }

    let validPrevious = validPreviousValues(validOutput: validOutput, idx: i, upto: upto)
    validPreviousForPlace[i] = validPrevious
    print("for digit \(i) - \(validPrevious.count) valid previous values in range \(validPrevious.min() ?? 0)...\(validPrevious.max() ?? 0)")
    validOutput = validPrevious
  }

  let largest = run(path: [], value: 0, remainingVal2: val2, remainingVal3: val3, descending: true)
  print("largest value: \(largest.value!)") // 92793949489995

  let smallest = run(path: [], value: 0, remainingVal2: val2, remainingVal3: val3, descending: false)
  print("smallest value: \(smallest.value!)") // 51131616112781
}
