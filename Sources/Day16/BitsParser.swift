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
    var result = [Bit]()
    while result.count < k {
      result.append(bits.removeLast())
    }
    return result
  }

  mutating func parsePacket() -> AnyPacket {
    let version = Int(consume(3))
    let type = Int(consume(3))

    var packet: AnyPacket
    switch type {
      case 4:
        packet = parseLiteral(version: version)
      default:
        packet = parseOperator(version: version, type: type)
    }
    return packet
  }

  mutating func parseLiteral(version: Int) -> AnyPacket {
    var shouldContinue: Bool
    var valueBits = [Bit]()
    repeat {
      let next = consume(5)
      shouldContinue = next[0] == .one
      valueBits.append(contentsOf: next[1...])
    } while shouldContinue

    return AnyPacket(Literal(version: version, value: Int(valueBits)))
  }

  mutating func parseOperator(version: Int, type: Int) -> AnyPacket {
    let lengthTypeId = consume(1).only
    if lengthTypeId == .zero {
      return parseTypeZeroOperator(version: version, type: type)
    } else {
      return parseTypeOneOperator(version: version, type: type)
    }
  }

  mutating func parseTypeZeroOperator(version: Int, type: Int) -> AnyPacket {
    var op = Operator(version: version, type: type)
    let subBitCount = Int(consume(15))
    var subParser = BitsParser(consume(subBitCount).reversed())
    while !subParser.bits.isEmpty {
      op.subPackets.append(subParser.parsePacket())
    }
//    let startingBitCount = bits.count
//    while bits.count > startingBitCount - subBitCount {
//      op.subPackets.append(parsePacket())
//    }
    return AnyPacket(op)
  }

  mutating func parseTypeOneOperator(version: Int, type: Int) -> AnyPacket {
    var op = Operator(version: version, type: type)
    let subPacketCount = Int(consume(11))
    for _ in 0..<subPacketCount {
      op.subPackets.append(parsePacket())
    }
    return AnyPacket(op)
  }
}
