import UIKit
//spacing
// CONSTANTS
class SourceCell: UITableViewCell{
    
    var newsText:String?
    var cellDescription:String?
    
    var newsTitle:UILabel={
        var newsTitle=UILabel()
        newsTitle.lineBreakMode = .byWordWrapping
        newsTitle.numberOfLines = 0
        newsTitle.font = UIFont(name: newsTitle.font.familyName, size: 15)
        return newsTitle
    }()
    
    var newsDescp:UILabel={
        var newsDescp=UILabel()
        newsDescp.numberOfLines = 2
        newsDescp.textColor = .darkGray
        newsDescp.font = UIFont(name: newsDescp.font.familyName, size: 15)
        return newsDescp
    }()
    
    required init?(coder: NSCoder) {
        fatalError("hello")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    func setupView(){
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        newsDescp.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(newsTitle)
        addSubview(newsDescp)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            newsTitle.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,constant: -2),
            newsTitle.topAnchor.constraint(equalTo: topAnchor,constant:0),
            
            newsDescp.topAnchor.constraint(equalTo: newsTitle.bottomAnchor,constant: 3),
            newsDescp.leadingAnchor.constraint(equalTo: leadingAnchor,constant:10),
            newsDescp.bottomAnchor.constraint(equalTo: bottomAnchor),
            newsDescp.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    //NAMING
    func set(newDescp:String?,newsText:String?){
        let newsDescription=newDescp ?? "No Description"
        let newsTitl=newsText ?? "No Title"
        newsDescp.text = newsDescription
        newsTitle.text = newsTitl
        
    }
}
