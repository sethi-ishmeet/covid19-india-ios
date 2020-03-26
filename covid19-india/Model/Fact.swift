struct Factoids: Codable {
    var factoids: [Fact]
}

struct Fact: Codable, Identifiable {
    var banner: String
    var id: String
}
