import Foundation

struct AnalysisResult: Identifiable {
    let id = UUID()
    let commonName: String
    let scientificName: String
    let isVenomous: Bool
    let isSafe: Bool
    let whatToDo: String
    let whatNotToDo: String
}
