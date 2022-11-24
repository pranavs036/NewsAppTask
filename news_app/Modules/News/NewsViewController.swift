
import UIKit
import SafariServices
//spacing
// CONSTANTS

//Check for glitch on reuse tableView cell for image
class NewsViewController:UIViewController{
    var selCategory:String?
    var keyWord:String?
    var newsArr:[Article] = []
    var newsTable = UITableView()
    var sourceFrom:String?
    
    //MARK:- VIEW LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        newsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchingData()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(newsTable)
        newsTable.translatesAutoresizingMaskIntoConstraints=false
        tableConstraints()
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(TableCell.self, forCellReuseIdentifier: "newsCell")
    }
    
    func fetchingData(){
        let newsData=NewsDataModel(selCategory: selCategory,keyWord: keyWord,sourcefrom:sourceFrom)
        newsData.fetchData(completion: { (newsData) in
            DispatchQueue.main.async {
               //newsArr=Article
              //  print(newsData)
                self.newsArr=newsData
                self.newsTable.reloadData()
                print("helo")
            }
        })
    }
    
    func tableConstraints() {
        NSLayoutConstraint.activate([
            newsTable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    
}

typealias NewsViewTableDelegate=NewsViewController
typealias NewsViewTableSource=NewsViewController

extension NewsViewTableDelegate: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // refactor code here
        guard let urlString = newsArr[indexPath.row].url else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let SafariScreen=SFSafariViewController(url: url)
        present(SafariScreen, animated: false)
    }
}

extension NewsViewTableSource: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! TableCell
        cell.set(cellArticle:newsArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
