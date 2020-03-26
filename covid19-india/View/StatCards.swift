import SwiftUI

struct StatCards: View {
    
    var stats: Array<StatCardViewModel>
    
    var body: some View{
        HStack {
            ForEach(stats, id: \.title) { stat in
                Stat(title: stat.title, value: stat.value)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 70, maxHeight: 70, alignment: .center)
    }
}

fileprivate struct Stat: View {
    
    var title: String
    
    var value: Double
    
    var body: some View{
        VStack {
            Text(title).font(.caption)
                .foregroundColor(.gray)
            Text(value.format())
                .font(.title)
        }
        .padding(.horizontal)

    }
}

extension Int {
    func format() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: self as NSNumber) ?? "-"
    }
}


extension Double {
    func format() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: self as NSNumber) ?? "-"
    }
}
