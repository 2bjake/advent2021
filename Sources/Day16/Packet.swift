protocol Packet {
  var version: Int { get }
  var versionSum: Int { get }
  var value: Int { get }
}

struct LiteralPacket: Packet {
  var version: Int
  var versionSum: Int { version }
  var value: Int
}

struct OperatorPacket: Packet {
  var version: Int
  var versionSum: Int { version + subPackets.map(\.versionSum).reduce(0, +) }
  var value: Int { operation(subPackets.map(\.value)) }

  var subPackets: [Packet] = []
  var operation: ([Int]) -> Int
}

extension OperatorPacket {
  struct Builder {
    private(set) var version: Int
    private(set) var subPackets: [Packet]
    
    init(version: Int, subPackets: [Packet]) {
      self.version = version
      self.subPackets = subPackets
    }
    
    func with(_ operation: @escaping ([Int]) -> Int) -> OperatorPacket {
      OperatorPacket(version: version, subPackets: subPackets, operation: operation)
    }
    
    var sum: Packet { self.with { $0.reduce(0, +) } }
    var product: Packet { self.with { $0.reduce(1, *) } }
    var min: Packet { self.with { $0.min()! } }
    var max: Packet { self.with { $0.max()! } }
    var greaterThan: Packet { self.with { $0[0] > $0[1] ? 1 : 0 } }
    var lessThan: Packet { self.with { $0[0] < $0[1] ? 1 : 0 } }
    var equal: Packet { self.with { $0[0] == $0[1] ? 1 : 0 } }
  }
}

extension OperatorPacket {
  init (_ builder: Builder, operation: @escaping ([Int]) -> Int) {
    self.init(version: builder.version, subPackets: builder.subPackets, operation: operation)
  }
}
