private func hexToBits(_ hexChar: Character) -> [Bit] {
  let hex = Int(hexChar, radix: 16)!
  let binaryStr = String(hex, radix: 2)
  let unpadded = binaryStr.compactMap(Bit.init)
  return repeatElement(.zero, count: 4 - unpadded.count) + unpadded
}

private extension Int {
  init(_ source: [Bit]) {
    self.init(String(source.map(\.rawValue)), radix: 2)!
  }
}

private enum Bit: Character {
  case zero = "0"
  case one = "1"
}

struct BitsParser {
  private var bits: [Bit]

  private init(_ bits: [Bit]) {
    self.bits = bits.reversed()
  }

  init(_ source: String) {
    let b: [[Bit]] = source.map(hexToBits)
    bits = Array(b.joined().reversed())
  }

  mutating func parsePacket() -> Packet {
    let version = Int(consume(3))
    let type = Int(consume(3))

    if type == 4 {
      return parseLiteral(version: version)
    }

    let builder = OperatorPacket.Builder(version: version, subPackets: parseSubPackets())

    switch type {
      case 0: return builder.sum
      case 1: return builder.product
      case 2: return builder.min
      case 3: return builder.max
      case 5: return builder.greaterThan
      case 6: return builder.lessThan
      case 7: return builder.equal
      default: fatalError()
    }
  }

  private mutating func consume(_ k: Int) -> [Bit] {
    let suffix = bits.suffix(k)
    bits.removeLast(k)
    return suffix.reversed()
  }

  private mutating func parseLiteral(version: Int) -> Packet {
    var shouldContinue: Bool
    var valueBits = [Bit]()
    repeat {
      let next = consume(5)
      shouldContinue = next[0] == .one
      valueBits.append(contentsOf: next[1...])
    } while shouldContinue

    return LiteralPacket(version: version, value: Int(valueBits))
  }

  private mutating func parseSubPackets() -> [Packet] {
    if consume(1).only == .zero {
      return parseTypeZeroSubPackets()
    } else {
      return parseTypeOneSubPackets()
    }
  }

  private mutating func parseTypeZeroSubPackets() -> [Packet] {
    var subPackets = [Packet]()
    let subBitCount = Int(consume(15))
    var subParser = BitsParser(consume(subBitCount))
    while !subParser.bits.isEmpty {
      subPackets.append(subParser.parsePacket())
    }
    return subPackets
  }

  private mutating func parseTypeOneSubPackets() -> [Packet] {
    var subPackets = [Packet]()
    let subPacketCount = Int(consume(11))
    for _ in 0..<subPacketCount {
      subPackets.append(parsePacket())
    }
    return subPackets
  }
}
