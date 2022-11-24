

struct ArticleModel: Codable{
    let status:String?
    let totalResults:Int?
    let articles:[Article]?
    
}

struct Article: Codable{
    let source:Source?
    let author:String?
    let title:String?
    let description:String?
    let content:String?
    let publishedAt:String?
    let url:String?
    let urlToImage:String?
    
}

struct Source:Codable{
    let id:String?
    let name:String?
}
