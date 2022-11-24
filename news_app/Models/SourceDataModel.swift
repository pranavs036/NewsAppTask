
import Foundation
//spacing
// CONSTANTS
class SourceDataModel {
    var selCategory: String?
    var newsArr:[SourceData] = []
    
    init(selCategory: String?) {
        self.selCategory = selCategory
    }
    
    func fetchData( completion: @escaping ([SourceData])->Void) {
        
        var urlString:String
        if let categ = selCategory {
            urlString = "https://newsapi.org/v2/top-headlines/sources?language=en&category=\(categ)&apiKey=\(apiKey)"
        }
        else{
            urlString = "https://newsapi.org/v2/top-headlines/sources?language=en&category=general&apiKey=\(apiKey)"
        }
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data{
                do{
                    let ArticleOverview = try decoder.decode(SourceModel.self, from: data)
                    let ArticleArray = ArticleOverview.sources
                    guard let array = ArticleArray else {
                        return
                    }
                    self.newsArr = array
                    completion(self.newsArr)
                }catch{
                    print(error)
                }
            }
            
        })
        task.resume()
    }
    
}
