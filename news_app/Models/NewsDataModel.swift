
import Foundation
// Refactor News Data model
class NewsDataModel{
    var selCategory:String?
    var keyWord:String?
    var sourcefro:String?
    var newsArr:[Article]=[]
    
    init(selCategory: String? = nil, keyWord: String? = nil,sourcefrom:String?) {
        self.selCategory = selCategory
        self.keyWord = keyWord
        self.sourcefro=sourcefrom
    }
    
    func fetchData( completion: @escaping ([Article])->Void){
        
        var urlString:String
        let urlStart = "https://newsapi.org/v2/everything?apiKey=\(apiKey)"
        if let keyW = keyWord{
           // refactor
            if let currSource=sourcefro{
                urlString="\(urlStart)&q=\(keyW)&sources=\(currSource)"
            }
            else {
                urlString="\(urlStart)&q=\(keyW)"
            }
        }else{
            if let currSource=sourcefro{
                urlString="\(urlStart)&sources=\(currSource)"
            }
            else{
                urlString=urlStart
            }
        }
        dataFetching(urlString: urlString,completion: completion)
    }

    func dataFetching(urlString: String,completion: @escaping ([Article])->Void ) {
        let url=URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            let decoder = JSONDecoder()
            
            if let data = data{
                do{
                    let ArticleOverview = try decoder.decode(ArticleModel.self, from: data)
                    let ArticleArray = ArticleOverview.articles
                    guard let array = ArticleArray else {
                        return
                    }
                    self.newsArr=array
                    completion(self.newsArr)
                    
                }catch{
                    print(error)
                }
            }
            
        })
        task.resume()
    }
 
}
