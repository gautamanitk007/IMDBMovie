//
//  MovieCell.swift
//  Movie
//
//  Created by Gautam Singh on 4/12/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
    }
    func configure(viewModel: MovieListSceneDataModels.MovieViewModel) {
        //self.imgThumb.image = UIImage(named: "1024.png")
        self.lblMovieTitle.text = viewModel.movieTitle
        
    }
}
