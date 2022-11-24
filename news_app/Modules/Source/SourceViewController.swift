import UIKit
//spacing
// CONSTANTS
class SourceViewController: UIViewController {
    var newsArr:[SourceData] = []
    var newsTable = UITableView()
    var selectedCategory:String?
    var selectedKeyword:String?
    struct Constants {
        static let cellIdentifer = "sourceCell"
    }
    var pageTitle:UILabel = {
        let pageTitle = UILabel()
        pageTitle.font = UIFont(name: pageTitle.font.familyName, size: 25)
        return pageTitle
    }()
    let newsViewController = NewsViewController()
    // MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        //NEVER FORCE UNWRAP
        guard let keyw = selectedKeyword else {
            return
        }
        guard let categ = selectedCategory else {
            return
        }
        title="\(keyw) in \(categ)"
        fetchingData()
    }
    
    func setupview() {
        view.backgroundColor = .white
        view.addSubview(pageTitle)
        view.addSubview(newsTable)
        
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(SourceCell.self, forCellReuseIdentifier: Constants.cellIdentifer)
        newsTable.translatesAutoresizingMaskIntoConstraints = false
  
        pageTitle.translatesAutoresizingMaskIntoConstraints = false
        newsTable.translatesAutoresizingMaskIntoConstraints = false
        tableConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newsTable.reloadData()
    }
    
    func fetchingData() {
        let sourceData=SourceDataModel(selCategory:selectedCategory)
        //CHECK FOR NESTED CLOUSURES
        sourceData.fetchData(completion: { (newsData) in
            DispatchQueue.main.async { [weak self] in
                self!.newsArr=newsData
                self!.newsTable.reloadData()
            }
        })
    }
    
    func tableConstraints() {
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            pageTitle.bottomAnchor.constraint(equalTo: newsTable.topAnchor),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            newsTable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    
}

typealias SourceTableDataSource = SourceViewController
typealias SourceTableDelegate = SourceViewController

extension SourceTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifer, for: indexPath) as! SourceCell
        cell.set(newDescp:newsArr[indexPath.row].description, newsText:newsArr[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension SourceTableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TRY INIT NewsViewController OUTSIDE FOR REUSABILITY
        newsViewController.sourceFrom = newsArr[indexPath.row].id
        newsViewController.keyWord = selectedKeyword
        self.navigationController?.pushViewController(newsViewController, animated: false)
    }
}
