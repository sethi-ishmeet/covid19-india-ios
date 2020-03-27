import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var basicData = BasicData(timeSeries: [CasesTimeSeries](), stats: [KeyStats](), statewise: [StatewiseTally]())
    @Published var fact = (banner: "", index: -1)
    private var facts = [Fact]()
    
    private var timer: Timer?
    private var refreshTimer: Timer?
    
    @Published var totalRow: StatewiseTally?
    
    func fetchData() {
        let apiService = APIService()
        
        let basicEndPoint : String = "\(AppSettings.apiBaseUrl)/data.json"
        apiService.get(url: basicEndPoint) { (data: BasicData?, error:Error?) in
            guard let details = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.basicData = details
                
                let total = self.basicData.statewise.filter { (state) -> Bool in
                    state.state == "Total"
                }.first
                
                self.basicData.statewise.removeAll { $0.state == "Total" }
                
                self.basicData.statewise.sort { $0.confirmed > $1.confirmed }
                
                if let totalRow = total {
                    self.totalRow = totalRow
                    self.totalRow?.delta.recovered = details.stats.first?.recoveredDelta ?? 0
                }
                
                if self.refreshTimer == nil {
                    self.startRefreshTimer()
                }
                
                self.getDistrictData()
            }
        }
    }
    
    func getFacts() {
        let apiService = APIService()
        let factEndPoint : String = "\(AppSettings.apiBaseUrl)/website_data.json"
        
        apiService.get(url: factEndPoint) { (data: Factoids?, error:Error?) in
            guard let details = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.startBannerTimer()
                self.facts = details.factoids
            }
        }
    }
    
    func getDistrictData() {
        let apiService = APIService()
        let endPoint : String = "\(AppSettings.apiBaseUrl)/state_district_wise.json"
        
        apiService.get(url: endPoint) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
                
                guard let result = dictionary else {
                    return
                }
                
                for (index, state) in self.basicData.statewise.enumerated() {
                    
                    let districtData = (result[state.state] as? Dictionary<String, Any>)?["districtData"] as? Dictionary<String, Any>
                    
                    if let stateDistricts = districtData {
                        
                        stateDistricts.forEach { (key, value) in
                            let confirmed = (value as? Dictionary<String, Any>)?["confirmed"] as? Int
                            let district = DistrictData(name: key, confirmed: confirmed ?? 0)
                            
                            DispatchQueue.main.async {
                                self.basicData.statewise[index].districts.append(district)
                            }
                        }
                    }
                }
            }
            catch {
                
            }
            
        }
    }
    private func startRefreshTimer() {
        if refreshTimer != nil {
            refreshTimer?.invalidate()
        }
        
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.fetchData()
        }
    }
    
    private func startBannerTimer() {
        DispatchQueue.main.async {
            self.fact = (self.facts.first?.banner ?? "", 0)
        }
        
        if timer != nil {
            timer?.invalidate()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            var index = self.fact.index + 1
            
            if index >= self.facts.count {
                index = 0
            }
            
            DispatchQueue.main.async {
                self.fact = (banner: self.facts[index].banner, index: index)
            }
        }
    }
}
