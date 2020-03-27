struct BasicData: Codable {
    var timeSeries: [CasesTimeSeries]
    var stats: [KeyStats]
    var statewise: [StatewiseTally]
    
    enum CodingKeys: String, CodingKey {
        case timeSeries = "cases_time_series"
        case stats = "key_values"
        case statewise = "statewise"
    }
}

struct StatewiseTally: Codable {
    var delta: Delta
    var state: String
    var districts: [DistrictData] = []
    
    init(state: String, delta: Delta) {
        self.state = state
        self.delta = delta
        _confirmed = ""
        _active = ""
        _deaths = ""
        _recovered = ""
    }
    
    private var _confirmed: String
    public var confirmed: Int {
        get {
            return Int(_confirmed) ?? 0
        }
    }
    
    private var _active: String
    public var active: Int {
        get {
            return Int(_active) ?? 0
        }
    }
    
    private var _deaths: String
    public var deaths: Int {
        get {
            return Int(_deaths) ?? 0
        }
    }
    
    private var _recovered: String
    public var recovered: Int {
        get {
            return Int(_recovered) ?? 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _confirmed = "confirmed"
        case _active = "active"
        case _deaths = "deaths"
        case _recovered = "recovered"
        case delta = "delta"
        case state = "state"
    }
}

struct Delta: Codable {
    var confirmed: Int
    var active: Int
    var deaths: Int
    var recovered: Int
}

struct KeyStats: Codable {
    
    private var _confirmeddelta: String
    public var confirmedDelta: Int {
        get {
            return Int(_confirmeddelta) ?? 0
        }
    }
    
    private var _counterforautotimeupdate: String
    public var counterForAutoTimeUpdate: Int {
        get {
            return Int(_counterforautotimeupdate) ?? 0
        }
    }
    
    private var _deceaseddelta: String
    public var deceasedDelta: Int {
        get {
            return Int(_deceaseddelta) ?? 0
        }
    }
    
    private var _lastupdatedtime: String
    public var lastUpdatedTime: Int {
        get {
            return Int(_lastupdatedtime) ?? 0
        }
    }
    
    private var _recovereddelta: String
    public var recoveredDelta: Int {
        get {
            return Int(_recovereddelta) ?? 0
        }
    }
    
    private var _statesdelta: String
    public var statesDelta: Int {
        get {
            return Int(_statesdelta) ?? 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _confirmeddelta = "confirmeddelta"
        case _counterforautotimeupdate = "counterforautotimeupdate"
        case _deceaseddelta = "deceaseddelta"
        case _lastupdatedtime = "lastupdatedtime"
        case _recovereddelta = "recovereddelta"
        case _statesdelta = "statesdelta"
    }
}

struct CasesTimeSeries: Codable {
    private var _dailyconfirmed: String
    public var dailyConfirmed: Int {
        get {
            return Int(_dailyconfirmed) ?? 0
        }
    }
    
    private var _dailydeceased: String
    public var dailyDeceased: Int {
        get {
            return Int(_dailydeceased) ?? 0
        }
    }
    
    private var _dailyrecovered: String
    public var dailyRecovered: Int {
        get {
            return Int(_dailyrecovered) ?? 0
        }
    }
    
    private var date: String
    
    private var _totalconfirmed: String
    public var totalConfirmed: Int {
        get {
            return Int(_totalconfirmed) ?? 0
        }
    }
    
    private var _totaldeceased: String
    public var totalDeceased: Int {
        get {
            return Int(_totaldeceased) ?? 0
        }
    }
    
    private var _totalrecovered: String
    public var totalRecovered: Int {
        get {
            return Int(_totalrecovered) ?? 0
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _dailyconfirmed = "dailyconfirmed"
        case _dailydeceased = "dailydeceased"
        case _dailyrecovered = "dailyrecovered"
        case date = "date"
        case _totalconfirmed = "totalconfirmed"
        case _totaldeceased = "totaldeceased"
        case _totalrecovered = "totalrecovered"
    }
}
