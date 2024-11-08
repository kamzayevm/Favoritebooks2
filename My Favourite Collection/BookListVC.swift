//
//  BookListVC.swift
//  My Favourite Collection
//
//  Created by Mubarak Kamzayev on 29.10.2024.
//


import UIKit

class BookListVC: UIViewController{
    
    var showOnlyFavourites = false
    
    var tableView = UITableView()
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourite Books"
        view.backgroundColor = .white
        books = fetchData()
        configureTableView()
        configureFilterButton()
    }
    
    
    ///Configured delegates, row height, register cells, constraints
    func configureTableView(){
        view.addSubview(tableView)
        
        //set delegates
        setTableViewDelegates()
        
        //set row height
        tableView.rowHeight = 100
        
        //register cells
        tableView.register(BookCell.self, forCellReuseIdentifier: "BookCell")
        
        //set constaints
//        tableView.pin(to: view)
        tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureFilterButton() {
            let filterButton = UIButton(type: .system)
            filterButton.setTitle("Favourites", for: .normal)
            filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            filterButton.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(filterButton)
            
            
            NSLayoutConstraint.activate([
                filterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
        
        @objc func filterButtonTapped() {
            showOnlyFavourites.toggle()
            tableView.reloadData()
        }
}

///At least UITableView needs this to functions.
extension BookListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showOnlyFavourites ? books.filter { $0.favourite }.count : books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as! BookCell
        let book = showOnlyFavourites ? books.filter { $0.favourite }[indexPath.row] : books[indexPath.row]
        cell.delegate = self
        cell.book = book
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = books[indexPath.row]
        
        let viewController = ViewController(data: selectedData)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension BookListVC{
    
    func fetchData() -> [Book] {
        let book1 = Book(image: UIImage(named: "mockingbird")!, title: "To Kill a Mockingbird", author: "Harper Lee", genre: "Classic", favourite: false)
        let book2 = Book(image: UIImage(named: "1984")!, title: "1984", author: "George Orwell", genre: "Science Fiction", favourite: false)
        let book3 = Book(image: UIImage(named: "pp")!, title: "Pride and Prejudice", author: "Jane Austen", genre: "Classic", favourite: false)
        let book4 = Book(image: UIImage(named: "The Great Gatsby")!, title: "The Great Gatsby", author: "Jane Austen", genre: "Classic", favourite: false)
        let book5 = Book(image: UIImage(named: "Harry Potter and the Sorcerer’s Ston")!, title: "Harry Potter and the Sorcerer’s Stone", author: "J.K. Rowling", genre: "Fantasy", favourite: false)
        let book6 = Book(image: UIImage(named: "The Catcher in the Rye")!, title: "The Catcher in the Rye", author: "J.D. Salinger", genre: "Classic", favourite: false)
        let book7 = Book(image: UIImage(named: "The Lord of the Rings: The Fellowship of the Ring")!, title: "The Lord of the Rings: The Fellowship of the Ring", author: "J.R.R. Tolkien", genre: "Fantasy", favourite: true)
        let book8 = Book(image: UIImage(named: "The Hobbit")!, title: "The Hobbit", author: "J.R.R. Tolkien", genre: "Fantasy", favourite: true)
        let book9 = Book(image: UIImage(named: "The Da Vinci Code")!, title: "The Da Vinci Code", author: "Dan Brown", genre: "Classic", favourite: true)
        let book10 = Book(image: UIImage(named: "The Alchemist")!, title: "The Alchemist", author: "Paulo Coelho", genre: "Classic", favourite: false)
        
        return [book1, book2, book3, book4, book5, book6, book7, book8, book9, book10]
    }
}


extension BookListVC: BookCellDelegate {
    func didChangeFavouriteStatus(for book: Book) {
        if let index = books.firstIndex(where: { $0.title == book.title }) {
            books[index].favourite.toggle() 
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}

