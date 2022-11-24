import UIKit
import SafariServices
class HeadlinesViewController: UIViewController {
    var newsArr:[Article] = []
    var newsTable = UITableView(frame: .zero)
    var headlineTitle = UILabel()
    var page:Int?
    var pageSize:Int?
    let newsData = HeadlinesDataModel(country: "in",pagesize: 10)
    var isLoadingList:Bool = false
    struct Constants {
        static let cellIdentifier = "newsCell"
    }
    //MARK:- VIEW LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        newsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSize=10
        setupview()
        title = "Headlines"
        fetchingData()
    }
    
    func setupview() {
        view.backgroundColor = .white
        view.addSubview(newsTable)
        newsTable.translatesAutoresizingMaskIntoConstraints=false

        newsTable.delegate=self
        newsTable.dataSource=self
        newsTable.register(TableCell.self, forCellReuseIdentifier: Constants.cellIdentifier )
        
        tableConstraints()
    }
    
    func fetchingData() {
        //cant use weak self here
        newsData.fetchData(completion: {(newsData,page) in
            DispatchQueue.main.async {
                print(newsData)
                self.newsArr.append(contentsOf: newsData)
                self.newsTable.reloadData()
                self.page = page
                self.isLoadingList = false
          }
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            fetchingData()
        }
    }
    
    func tableConstraints() {
        NSLayoutConstraint.activate([
            
            newsTable.topAnchor.constraint(equalTo: view.topAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    
}


typealias HeadlinesTableDataSource = HeadlinesViewController

extension HeadlinesTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
            headerView.backgroundColor = .white
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 0, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "Headlines"
            label.font = .systemFont(ofSize: 25)
            label.textColor = .black

            headerView.addSubview(label)

            return headerView
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! TableCell
        cell.set(cellArticle:newsArr[indexPath.row])
        return cell
    }
}

typealias HeadlinesTableDelegate = HeadlinesViewController

extension HeadlinesTableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlString = newsArr[indexPath.row].url else {
            return
        }
        guard let url = URL(string: urlString)else{
            return
        }
        let SafariScreen = SFSafariViewController(url: url)
        present(SafariScreen, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
