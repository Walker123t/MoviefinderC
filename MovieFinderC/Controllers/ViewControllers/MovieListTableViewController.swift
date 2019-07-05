//
//  MovieListTableViewController.swift
//  MovieFinderC
//
//  Created by Trevor Walker on 7/5/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    //Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //properties
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting searcbar delegate
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //setting up cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        //setting our current movie
        let movie = movies[indexPath.row]
        
        //setting the cell data
        cell.movieName.text = movie.title
        cell.movieRating.text = "\(movie.voteAverage)"
        cell.movieOverview.text = movie.overview
        
        //grabbing/setting image
        MovieController.fetchImage(fromData: movie.imagePath) { (imageData) in
            guard let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        return cell
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //checking which segue we are using
        if segue.identifier == "showMovieDetails"{
            //making sure our destination and index path exist
            guard let destination = segue.destination as? MovieDetailsViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            //sending over the selected movie
            destination.movie = movies[indexPath.row]
        }
    }
}
extension MovieListTableViewController: UISearchBarDelegate{
    //setting up search thing that goes when searched
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //making sure search bar wasn't empty
        guard let search = searchBar.text, search != "" else {return}
        //fetching movie
        MovieController.fetchMovies(search) { (movie) in
            self.movies = movie
            //reloading data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
