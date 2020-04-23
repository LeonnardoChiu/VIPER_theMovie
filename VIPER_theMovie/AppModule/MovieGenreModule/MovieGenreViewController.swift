//
//  MovieGenreViewController.swift
//  VIPER_theMovie
//
//  Created by Leonnardo Benjamin Hutama on 23/04/20.
//  Copyright © 2020 Leonnardo Benjamin Hutama. All rights reserved.
//

import UIKit

class MovieGenreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ViewToPresenterMovieGenreProtocol?
    
    var selectedGenre: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieGenreViewController: PresenterToViewMovieGenreProtocol {
    
}
