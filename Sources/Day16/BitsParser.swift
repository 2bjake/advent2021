struct BitsParser {
  var bits: [Bit]

  init(_ bits: [Bit]) {
    self.bits = bits
  }

  init(_ source: String) {
    let b: [[Bit]] = source.map(hexToBits)
    bits = Array(b.joined().reversed())
  }

  func printBits() {
    print(String(bits.reversed().map(\.rawValue)))
  }

  mutating func consume(_ k: Int) -> [Bit] {
    let suffix = bits.suffix(k)
    bits.removeLast(k)
    return suffix.reversed()
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

  mutating func parseLiteral(version: Int) -> Packet {
    var shouldContinue: Bool
    var valueBits = [Bit]()
    repeat {
      let next = consume(5)
      shouldContinue = next[0] == .one
      valueBits.append(contentsOf: next[1...])
    } while shouldContinue

    return LiteralPacket(version: version, value: Int(valueBits))
  }

  mutating func parseSubPackets() -> [Packet] {
    if consume(1).only == .zero {
      return parseTypeZeroSubPackets()
    } else {
      return parseTypeOneSubPackets()
    }
  }

  mutating func parseTypeZeroSubPackets() -> [Packet] {
    var subPackets = [Packet]()
    let subBitCount = Int(consume(15))
    var subParser = BitsParser(consume(subBitCount).reversed()) // TODO: this is a little weird and error prone...
    while !subParser.bits.isEmpty {
      subPackets.append(subParser.parsePacket())
    }
    return subPackets
  }

  mutating func parseTypeOneSubPackets() -> [Packet] {
    var subPackets = [Packet]()
    let subPacketCount = Int(consume(11))
    for _ in 0..<subPacketCount {
      subPackets.append(parsePacket())
    }
    return subPackets
  }
}
