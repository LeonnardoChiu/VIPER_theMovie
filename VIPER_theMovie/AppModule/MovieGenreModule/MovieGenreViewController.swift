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
    
    var genreList: [MovieGenreModel] = []
    
    var selectedGenre: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Genres"
        navigationItem.largeTitleDisplayMode = .never
        
        setUpBackButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "clear genres", style: .plain, target: self, action: #selector(clearGenresTapped))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.startRequestGenres()
    }
    
    func setUpBackButton() {
        let backbutton = UIButton(type: .custom)
        
        backbutton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    @objc func clearGenresTapped() {
        selectedGenre.removeAll()
        tableView.reloadData()
    }
    
    @objc func backTapped() {
        presenter?.passGenre(selectedGenre: selectedGenre, navigationController: navigationController!)
    }
}

extension MovieGenreViewController: PresenterToViewMovieGenreProtocol {
    func showGenreList(genreList: [MovieGenreModel]) {
        self.genreList = genreList
        tableView.reloadData()
    }
    
}

extension MovieGenreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        
        cell.textLabel?.text = genreList[indexPath.row].name
        cell.accessoryType = .none
        cell.selectionStyle = .none
        
        if selectedGenre.count != 0 {
            for genre in selectedGenre {
                if genre == "\(genreList[indexPath.row].id!)" {
                    cell.accessoryType = . checkmark
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            for (i, genre) in selectedGenre.enumerated() {
                if genre == "\(genreList[indexPath.row].id!)" {
                    selectedGenre.remove(at: i)
                }
            }
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            selectedGenre.append("\(genreList[indexPath.row].id!)")
        }
    }
    
    
}
