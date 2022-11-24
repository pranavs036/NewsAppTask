import UIKit

//Naming for file
class TableCell: UITableViewCell {
    
    var newsImage = UIImageView()
    
    var newsAuthor: UILabel = {
        var newsAuthor = UILabel()
        newsAuthor.font = UIFont(name: newsAuthor.font.familyName, size: 15)
        return newsAuthor
    }()
    
    var newsTitle: UILabel = {
        var newsTitle = UILabel()
        newsTitle.lineBreakMode = .byWordWrapping
        newsTitle.numberOfLines = 0
        newsTitle.font=UIFont(name: newsTitle.font.familyName, size: 15)
       return newsTitle
    }()
    
    var newsDescp: UILabel = {
        var newsDescp=UILabel()
        newsDescp.numberOfLines = 2
        newsDescp.textColor = .darkGray
        newsDescp.font=UIFont(name: newsDescp.font.familyName, size: 15)
       return newsDescp
    }()
    
    required init?(coder: NSCoder) {
          fatalError("hello")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupview()
        setupConstraints()
        setupShadow()
    }
    
    func setupShadow() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func setupview() {
        addSubview(newsImage)
        addSubview(newsTitle)
        addSubview(newsAuthor)
        addSubview(newsDescp)
        
        newsImage.translatesAutoresizingMaskIntoConstraints=false
        newsTitle.translatesAutoresizingMaskIntoConstraints=false
        newsAuthor.translatesAutoresizingMaskIntoConstraints=false
        newsDescp.translatesAutoresizingMaskIntoConstraints=false
        
        newsAuthor.textColor = .lightGray
        newsImage.contentMode = .scaleAspectFit
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            newsImage.heightAnchor.constraint(equalToConstant: 60),
            newsImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            newsImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            
            newsTitle.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor,constant: 10),
            newsTitle.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor,constant: -2),
            newsTitle.topAnchor.constraint(equalTo: topAnchor,constant:10),
            
            newsAuthor.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor,constant: 10),
            newsAuthor.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -2),
            
            newsDescp.topAnchor.constraint(equalTo: newsTitle.bottomAnchor,constant: 3),
            newsDescp.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor,constant:10),
            newsDescp.bottomAnchor.constraint(equalTo: newsAuthor.topAnchor),
            newsDescp.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
  
    
    func set(cellArticle: Article) {
        //refactor
        guard let urlString = cellArticle.urlToImage else {
         return
        }
        
        guard let url = URL(string: urlString) else{
         return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
           if let data = data {
             DispatchQueue.main.async {
                self?.newsImage.image = UIImage(data: data)
                }
            }
        }
        
        dataTask.resume()
        
        newsTitle.text = cellArticle.title!
        
        let authorText = cellArticle.source?.name ?? "Unkown Author"
        newsAuthor.text = authorText
        
        let newsDescrition = cellArticle.description ?? "News Reported"
        newsDescp.text = newsDescrition
    }
}
