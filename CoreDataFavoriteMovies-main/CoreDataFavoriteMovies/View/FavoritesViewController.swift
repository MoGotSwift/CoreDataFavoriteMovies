//
//  FavoritesViewController.swift
//  CoreDataFavoriteMovies
//
//  Created by Parker Rushton on 11/3/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var backgroundView: UIView!
    let movieController = MovieController.shared
    
    var favoriteMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoriteMovies = movieController.fetchFavoriteMovies()
        print(self.favoriteMovies)
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func setUpTableView() {
        tableView.backgroundView = backgroundView
        tableView.register(UINib(nibName: MovieTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let movieAtIndex = favoriteMovies[indexPath.row]
        movieCell.update(with: movieAtIndex) {
            self.unfavoriteMovie(at: indexPath)
        }
        return movieCell
    }
    
    private func unfavoriteMovie(at indexPath: IndexPath) {
        let movieToRemove = favoriteMovies[indexPath.row]
        movieController.unfavoriteMovie(movieToRemove)
        favoriteMovies.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
