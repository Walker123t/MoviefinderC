//
//  MovieDetailsViewController.swift
//  MovieFinderC
//
//  Created by Trevor Walker on 7/5/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UILabel!
    //MARK: - Properties
    var movie: Movie? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    //MARK: - Functions
    func updateViews(){
        guard let movie = movie else {return}
        name.text = movie.title
        rating.text = "Rating: \(movie.voteAverage)"
        overview.text = movie.overview
        MovieController.fetchImage(fromData: movie.imagePath) { (imageData) in
            guard let image = UIImage(data: imageData) else {return}
            DispatchQueue.main.async {
                self.movieImage.image = image
            }
        }
    }
}
