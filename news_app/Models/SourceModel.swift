

struct SourceModel:Codable{
    let status:String?
    let sources:[SourceData]?
}

struct SourceData:Codable{
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}
