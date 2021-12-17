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
    
    private func with(operation: @escaping ([Int]) -> Int) -> OperatorPacket {
      .init(version: version, subPackets: subPackets, operation: operation)
    }
    
    func sum() -> Packet { self.with { $0.reduce(0, +) } }
    func product() -> Packet { self.with { $0.reduce(1, *) } }
    func min() -> Packet { self.with { $0.min()! } }
    func max() -> Packet { self.with { $0.max()! } }

    private func comparison(_ compare: @escaping (Int, Int) -> Bool) -> Packet { self.with { compare($0[0], $0[1]) ? 1 : 0 } }
    func greaterThan() -> Packet { comparison(>) }
    func lessThan() -> Packet { comparison(<) }
    func equal() -> Packet { comparison(==) }
  }
}

extension OperatorPacket {
  init (_ builder: Builder, operation: @escaping ([Int]) -> Int) {
    self.init(version: builder.version, subPackets: builder.subPackets, operation: operation)
  }
}
