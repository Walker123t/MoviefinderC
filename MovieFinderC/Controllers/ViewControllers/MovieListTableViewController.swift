//
//  MovieListTableViewController.swift
//  MovieFinderC
//
//  Created by Trevor Walker on 7/5/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var movies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let movie = movies[indexPath.row]
        cell.movieName.text = movie.title
        cell.movieRating.text = "\(movie.voteAverage)"
        cell.movieOverview.text = movie.overview
        MovieController.fetchImage(fromData: movie.imagePath) { (imageData) in
            guard let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        
        return cell
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetails"{
            guard let destination = segue.destination as? MovieDetailsViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            destination.movie = movies[indexPath.row]
        }
    }
}
extension MovieListTableViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, search != "" else {return}
        MovieController.fetchMovies(search) { (movie) in
            self.movies = movie
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
