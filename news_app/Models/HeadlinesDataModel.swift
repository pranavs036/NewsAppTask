
import Foundation
class HeadlinesDataModel{
    var country: String?
    var newsArr:[Article] = []
    var pageSize: Int?
    var page = 1
    
    init(country:String,pagesize:Int) {
        self.pageSize=pagesize
        self.country=country
    }
    
    func fetchData( completion: @escaping ([Article],Int)->Void){
        let urlString:String = "https://newsapi.org/v2/top-headlines?page=\(page)&pageSize=\(pageSize!)&country=in&apiKey=\(apiKey)"
        dataFetching(urlString: urlString,completion: completion)
    }
    
    func dataFetching(urlString: String,completion: @escaping ([Article],Int)->Void) {
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
                 self.newsArr = array
                 self.page+=1
                 completion(self.newsArr,self.page)
                }catch{
                        print(error)
                  }
                  }
                
        })
        task.resume()
    }
 
}
