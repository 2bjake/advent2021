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

func process(input: Int, previous: Int, val2: Int, val3: Int) -> Int {
  if val2 >= 0 {
    var next = previous / 26
    if previous % 26 - val2 != input {
      next = next * 26 + input + val3
    }
    return next
  } else {
    return previous * 26 + input + val3
  }
}

let val2 = [-11, -14, -10, 0, -12, -12, -12, 8, 9, -11, 0, 5, 6, 12]
let val3 = [8, 13, 2, 7, 11, 4, 13, 13, 10, 1, 2, 14, 6, 14]

func validPreviousValues(validOutput: Set<Int>, idx: Int, upto: Int) -> Set<Int> {
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
func populateValidPreviousValues() {
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
}

public func partOneAndTwo() {
  populateValidPreviousValues()

  let val2Slice = ArraySlice(val2)
  let val3Slice = ArraySlice(val3)

  let largest = run(path: [], value: 0, remainingVal2: val2Slice, remainingVal3: val3Slice, descending: true).value!
  print("largest value: \(largest)") // 92793949489995
  assert(largest == "92793949489995")

  let smallest = run(path: [], value: 0, remainingVal2: val2Slice, remainingVal3: val3Slice, descending: false).value!
  print("smallest value: \(smallest)") // 51131616112781
  assert(smallest == "51131616112781")
}
