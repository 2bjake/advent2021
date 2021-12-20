import Extensions
import Foundation

enum Bit: Character {
  case zero = "0"
  case one = "1"
}

enum Pixel: Character {
  case dark = "."
  case light = "#"

  var bit: Bit { self == .dark ? .zero : .one }
  var flip: Pixel { self == .dark ? .light : .dark }
}

extension Int {
  init(_ source: [Bit]) {
    self.init(String(source.map(\.rawValue)), radix: 2)!
  }
}

func sorter(lhs: Position, rhs: Position) -> Bool {
  if lhs.row == rhs.row {
    return lhs.col < rhs.col
  } else {
    return lhs.row < rhs.row
  }
}

extension Position: CustomStringConvertible {
  public var description: String { "(\(row),\(col))"}
}

func enhancedPixel(at position: Position, in picture: [[Pixel]], using algo: [Pixel], fillPixel: Pixel) -> Pixel {
  let positions = position.adjacentPositions(includingDiagonals: true) + [position]
  let pixels = positions.sorted(by: sorter).map {
    picture.element(at: $0) ?? fillPixel
  }
  return algo[Int(pixels.map(\.bit))]
}

func growPicture(_ picture: [[Pixel]], fillPixel: Pixel) -> [[Pixel]]{
  let row = Array(repeating: Pixel.dark, count: picture.numberOfColumns + 2)
  var newPicture = Array(repeating: row, count: picture.numberOfRows + 2)

  for newPos in newPicture.allPositions {
    let originalPos = newPos - (1, 1)
    newPicture[newPos] = picture.element(at: originalPos) ?? fillPixel
  }
  return newPicture
}

func enhance(times: Int) {
  let parts = input.components(separatedBy: "\n\n")
  let algo = parts[0].compactMap(Pixel.init)
  var curPicture = parts[1].split(separator: "\n").map { $0.compactMap(Pixel.init) }

  for i in 0..<times {
    let fillPixel = i % 2 == 0 ? Pixel.dark : .light
    curPicture = growPicture(curPicture, fillPixel: fillPixel)

    let row = Array(repeating: Pixel.dark, count: curPicture.numberOfColumns)
    var newPicture = Array(repeating: row, count: curPicture.numberOfRows)

    for pos in curPicture.allPositions {
      newPicture[pos] = enhancedPixel(at: pos, in: curPicture, using: algo, fillPixel: fillPixel)
    }
    curPicture = newPicture
  }

  let dotCount = curPicture.joined().count { $0 == .light }
  print(dotCount)
}

public func partOne() {
  enhance(times: 2) // 5057
}

public func partTwo() {
  enhance(times: 50) // 18502
}
