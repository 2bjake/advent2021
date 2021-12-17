import Extensions

enum Bit: Character {
  case zero = "0"
  case one = "1"
}

extension Int {
  init(_ source: [Bit]) {
    self.init(String(source.map(\.rawValue)), radix: 2)!
  }
}

func hexToBits(_ hexChar: Character) -> [Bit] {
  let hex = Int(hexChar, radix: 16)!
  let binaryStr = String(hex, radix: 2)
  let unpadded = binaryStr.compactMap(Bit.init)
  return repeatElement(.zero, count: 4 - unpadded.count) + unpadded
}

func versionSumFor(_ str: String) -> Int {
  var parser = BitsParser(str)
  let packet = parser.parsePacket()
  return packet.versionSum
}

func value(_ str: String) -> Int {
  var parser = BitsParser(str)
  let packet = parser.parsePacket()
  return packet.value
}

public func partOne() {
  assert(versionSumFor("8A004A801A8002F478") == 16)
  assert(versionSumFor("620080001611562C8802118E34") == 12)
  assert(versionSumFor("C0015000016115A2E0802F182340") == 23)
  assert(versionSumFor("A0016C880162017C3686B18A3D4780") == 31)
  assert(versionSumFor(input) == 927)
}

public func partTwo() {
  assert(value("C200B40A82") == 3)
  assert(value("04005AC33890") == 54)
  assert(value("880086C3E88112") == 7)
  assert(value("CE00C43D881120") == 9)
  assert(value("D8005AC2A8F0") == 1)
  assert(value("F600BC2D8F") == 0)
  assert(value("9C005AC2F8F0") == 0)
  assert(value("9C0141080250320F1802104A08") == 1)
  assert(value(input) == 1725277876501)
  print(value(input))
}
