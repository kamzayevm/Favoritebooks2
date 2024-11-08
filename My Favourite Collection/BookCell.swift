//
//  TableViewCell.swift
//  My Favourite Collection
//
//  Created by Mubarak Kamzayev on 29.10.2024.
//


import UIKit

///Паттерн делегат для того чтобы было легче обрабатывать кнопку
protocol BookCellDelegate: AnyObject {
    func didChangeFavouriteStatus(for book: Book)
}

class BookCell: UITableViewCell {
    
    weak var delegate: BookCellDelegate?
    var bookImageView = UIImageView()
    var bookTitleLabel = UILabel()
    var bookAuthorLabel = UILabel()
    var bookGenreLabel = UILabel()
    var bookFavouriteButton = UIButton(type: .system)
    
   
    var book: Book? {
        didSet{
            guard let book = book else {return}
            bookImageView.image = book.image
            bookTitleLabel.text = book.title
            bookAuthorLabel.text = "Автор: \(book.author)"
            bookGenreLabel.text = "Жанр: \(book.genre)"
            updateFavouriteButton()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(bookImageView)
        addSubview(bookTitleLabel)
        addSubview(bookAuthorLabel)
        addSubview(bookGenreLabel)
        addSubview(bookFavouriteButton)

        
        configureImageView()
        configureTitleLabel()
        configureAuthorLabel()
        configureGenreLabel()
        configureFavouriteButton()

        
        setImageConstraints()
        setTitleLabelConstraints()
        setAuthorLabelConstraints()
        setGenreLabelConstraints()
        setFavouriteButtonConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

         }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if bookFavouriteButton.frame.contains(point) {
            return bookFavouriteButton
        }

        return super.hitTest(point, with: event)
    }
    
//    func set(book: Book) {
//        bookImageView.image = book.image
//        bookTitleLabel.text = book.title
//        bookAuthorLabel.text = "Автор: \(book.author)"
//        bookGenreLabel.text = "Жанр: \(book.genre)"
//    }
    
    
    ///Configuration methods
    func configureImageView() {
        bookImageView.layer.cornerRadius = 10
        bookImageView.clipsToBounds = true
    }

    func configureTitleLabel() {
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.adjustsFontSizeToFitWidth = true
    }

    func configureAuthorLabel() {
        bookAuthorLabel.font = UIFont.systemFont(ofSize: 14)
        bookAuthorLabel.textColor = .darkGray
    }

    func configureGenreLabel() {
        bookGenreLabel.font = UIFont.systemFont(ofSize: 14)
        bookGenreLabel.textColor = .lightGray
    }
    
    func configureFavouriteButton(){
        bookFavouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        bookFavouriteButton.tintColor = .red
        bookFavouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        bookFavouriteButton.isUserInteractionEnabled = true
    }
    
    
    
    ///Objective-c functions
    @objc private func favouriteButtonTapped(){
        guard var book = book else {return}
        book.favourite.toggle()
        updateFavouriteButton()
        
        //Говорим делегату о том что состояние книги изменилось
        delegate?.didChangeFavouriteStatus(for: book)
    }
    
    func updateFavouriteButton(){
        if book?.favourite == true {
                bookFavouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                bookFavouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
    }

    
    
    
    ///Setup methods
    func setImageConstraints() {
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 179/281).isActive = true
    }

    func setTitleLabelConstraints() {
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        bookTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    func setAuthorLabelConstraints() {
        bookAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        bookAuthorLabel.topAnchor.constraint(equalTo: bookTitleLabel.bottomAnchor, constant: 5).isActive = true
        bookAuthorLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookAuthorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    func setGenreLabelConstraints() {
        bookGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        bookGenreLabel.topAnchor.constraint(equalTo: bookAuthorLabel.bottomAnchor, constant: 5).isActive = true
        bookGenreLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 20).isActive = true
        bookGenreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        bookGenreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    func setFavouriteButtonConstraints(){
        bookFavouriteButton.translatesAutoresizingMaskIntoConstraints = false
        bookFavouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        bookFavouriteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bookFavouriteButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bookFavouriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
