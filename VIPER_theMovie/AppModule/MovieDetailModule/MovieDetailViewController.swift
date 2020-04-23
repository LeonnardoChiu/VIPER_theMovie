//
//  MovieDetailViewController.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 22/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var runtimeLabel: UILabel!
    
    var presentor:ViewToPresenterMovieDetailProtocol?
    
    var movieID: Int?
    
    var movieDetailResponse: MovieDetailModel?
    
    var movieReviews: [MovieReviewModel] = []
    
    var pageNumber = 1
    
    var fetchMoreReview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Movie Detail"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        presentor?.startRequestMovieDetail(movieID: movieID!)
        presentor?.startRequestMovieReview(movieID: movieID!, page: pageNumber)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        presentor?.getTrailerVideo(movieID: movieID!)
    }

}

extension MovieDetailViewController: PresenterToViewMovieDetailProtocol {
    
    
    func showMovieDetail(movieDetail: MovieDetailModel) {
        movieDetailResponse = movieDetail
        imgView.image = movieDetailResponse?.backdrop_image
        titleLabel.text = movieDetailResponse?.original_title
        taglineLabel.text = movieDetailResponse?.tagline
        overviewLabel.text = movieDetailResponse?.overview
        ratingLabel.text = "Rating: \(movieDetailResponse?.vote_average ?? 0)/10"
        
        if movieDetailResponse?.genres?.count == 0 {
            genresLabel.text = "Genres: -"
        }
        else{
            var genres:[String] = []
            for genre in movieDetailResponse!.genres! {
                genres.append(genre.name!)
            }
            
            genresLabel.text = "Genres: \(genres.joined(separator: ", "))"
        }
        
        if movieDetailResponse?.status == "Released" {
            statusLabel.text = "Status: \(movieDetailResponse!.status!) at \(movieDetailResponse!.release_date!)"
        }
        else {
            statusLabel.text = "Status: \(movieDetailResponse!.status!)"
        }
        
        if movieDetailResponse?.runtime != nil {
            runtimeLabel.text = "Runtime: \(movieDetailResponse!.runtime!) min"
        }
        else{
            runtimeLabel.text = "Runtime: -"
        }
    }
    
    
    func showMovieReview(movieReview: [MovieReviewModel]) {
        self.movieReviews.append(contentsOf: movieReview)
        self.tableView.reloadData()
    }
    
    func showMovieTrailer(movieVideo: [MovieVideoModel]) {
        if movieVideo.count == 0 { return }
        let key = movieVideo[0].key!
        
        guard let url = URL(string: "\(youtubeBaseURL)\(key)") else { return }
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
    
    func fetchNextPage(){
        pageNumber += 1
        presentor?.startRequestMovieReview(movieID: movieID!, page: pageNumber)
        fetchMoreReview = false
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movieReviews.count == 0 {
            return 1
        }
        else{
            return movieReviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        
        if movieReviews.count == 0 {
            cell.detailTextLabel?.alpha = 0
            cell.textLabel?.text = "No Review"
        }
        else{
            cell.detailTextLabel?.alpha = 1
            cell.textLabel?.text = movieReviews[indexPath.row].author
            cell.detailTextLabel?.text = "\(movieReviews[indexPath.row].content!)\n\n"
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height + 4 {
            if !fetchMoreReview {
                fetchMoreReview = true
                fetchNextPage()
            }
        }
    }
    
}
