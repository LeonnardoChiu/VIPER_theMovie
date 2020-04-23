//
//  MovieViewController.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 20/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presentor:ViewToPresenterProtocol?
    
    let searchBar = UISearchBar()
    
    var movieList:[MovieModel] = []
    
    var pageNumber = 1
    
    var fetchMoreMovie = false
    
    var selectedGenre: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "theMovie"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Genre", style: .plain, target: self, action: #selector(genreTapped))
        
        initSearchBar()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        presentor?.startRequestMovie(page: pageNumber, genres: "")
        
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initSearchBar() {
        // set the search bar view
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search by Movie"
        searchBar.sizeToFit()
    }
    
    @objc func genreTapped() {
        
    }
    
}

extension MovieViewController: PresenterToViewProtocol {
    func showMovie(movieArray: [MovieModel]) {
        self.movieList.append(contentsOf: movieArray)
        self.tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movieList.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieListCell
            
            cell.imageView?.image = movieList[indexPath.row].movie_image
            cell.titleLabel.text = movieList[indexPath.row].title
            cell.genresLabel.text = movieList[indexPath.row].genres
            cell.voteLabel.text = "\(movieList[indexPath.row].vote_average ?? 0)/10"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.activityIndicator.hidesWhenStopped = true
            cell.activityIndicator.startAnimating()
            cell.noResultLabel.alpha = 0
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = movieList[indexPath.row].id!
        
        presentor?.showMovieDetail(movieID: movieID, navigationController: navigationController!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height + 4 {
            if !fetchMoreMovie {
                pageNumber += 1
                fetchMoreMovie = true
                tableView.reloadSections(IndexSet(integer: 1), with: .none)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                    if self.searchBar.text == "" {

                        self.presentor?.startRequestMovie(page: self.pageNumber, genres: "")
                    }
                    else {
                        
                        self.presentor?.searchMovie(page: self.pageNumber, keyword: self.searchBar.text!)
                    }
                    self.fetchMoreMovie = false
                })
            }
        }
    }
    
}

extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(MovieViewController.reload), object: nil)
        self.perform(#selector(MovieViewController.reload), with:
            nil, afterDelay: 0.5)
    }
    
    @objc func reload() {
        guard let searchBarText = searchBar.text else { return }

        pageNumber = 1
        movieList.removeAll()
        tableView.reloadData()
        if searchBarText == "" {
            
            presentor?.startRequestMovie(page: pageNumber, genres: "")
            return
        }

        presentor?.searchMovie(page: pageNumber, keyword: searchBarText)
        
    }
}

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
        
}

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultLabel: UILabel!
}
