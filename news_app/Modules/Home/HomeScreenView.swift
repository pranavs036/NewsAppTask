
import UIKit

class HomeScreenView: UIViewController {
    struct Constants {
        static let cellIdentifier = "contactCell"
    }
    
    let myTitle:UILabel = {
       var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "News"
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        title.textColor = UIColor(hexString: "EF9A53")
        return title
    }()
    
    let mySearchField: UITextField = {
        var searchField = UITextField()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.backgroundColor = UIColor(hexString: "FFEFD6")
        searchField.layer.cornerRadius = 10
        searchField.textColor = .lightGray
        return searchField
    }()
    
    let mySearchButton: UIButton={
        var searchButton=UIButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        //MODULARITY
        let iconImg = UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        searchButton.setBackgroundImage(iconImg,for: .normal)
        return searchButton
    }()
    
    let midView = UIView()
    let myTableView = UITableView()
    let categories = ["business","entertainment","general","health","science","sports","technology"]
    var selectedCategory = "General"
    var myTimer: Timer?
    let tableTitle = "Categories"
    //MARK:- VIEW LIFECYCLE
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchField()
    }
    
    func setupSearchField(){
        mySearchButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        mySearchField.addTarget(self, action: #selector(pressed), for: .editingDidEndOnExit)
        mySearchField.addTarget(self, action: #selector(stillEditing), for: .editingChanged)
    }
    
    func setupView(){
        view.backgroundColor = UIColor.white

        view.addSubview(myTitle)
        view.addSubview(midView)
        view.addSubview(myTableView)
        midView.addSubview(mySearchField)
        midView.addSubview(mySearchButton)
        
        configureViews()
    }
    
    func configureViews(){
        midView.translatesAutoresizingMaskIntoConstraints=false
        myTableView.translatesAutoresizingMaskIntoConstraints=false
        
        topConstraints()
        midConstraints()
    }
    
    func setupTableView(){
        myTableView.dataSource = self
        myTableView.delegate = self
        //USE CONSTANTS
        myTableView.register(UITableViewCell.self,forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    @objc func stillEditing(){
        if let time = myTimer{
            time.invalidate()
        }
        if(mySearchField.text != ""){
            //MARK: - CHECK FOR CAPTURE LIST IN CLOUSURE
            myTimer=Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in
                self.pressed()
            })
        }
    }
    
    //MARK: - NAMING SHOULD BE DESCRIPTIVE
   @objc func pressed(){
        let sourceViewController = SourceViewController()
        sourceViewController.selectedCategory=selectedCategory
        sourceViewController.selectedKeyword=mySearchField.text
        self.navigationController?.pushViewController(sourceViewController, animated: false)
    }
  //TAKE IT ON TOP
    
}

typealias HomeScreenTableHandler=HomeScreenView
extension HomeScreenTableHandler:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        //MAKE CUSTOM CELL
        cell.textLabel?.text = categories[indexPath.row]
        cell.textLabel?.textColor = .lightGray
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory=categories[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //MAKE IT GENERIX
         tableTitle
    }
}

extension HomeScreenView{
    func topConstraints(){
        NSLayoutConstraint.activate([
            myTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant:10),
            myTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant:10),
        ])
    }
    
    func midConstraints(){
        NSLayoutConstraint.activate([
            midView.topAnchor.constraint(equalTo: myTitle.bottomAnchor,constant: 60),
            midView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 78),
            midView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            midView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03),
            
            mySearchField.leadingAnchor.constraint(equalTo: midView.leadingAnchor),
            mySearchField.topAnchor.constraint(equalTo: midView.topAnchor),
            mySearchField.widthAnchor.constraint(equalTo: midView.widthAnchor, multiplier: 0.7),
            mySearchField.bottomAnchor.constraint(equalTo: midView.bottomAnchor),
            
            mySearchButton.leadingAnchor.constraint(equalTo: mySearchField.trailingAnchor,constant:12),
            mySearchButton.topAnchor.constraint(equalTo: midView.topAnchor),
            
            myTableView.topAnchor.constraint(equalTo: midView.bottomAnchor,constant:20),
            myTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant:78),
            myTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            myTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
    }
}




