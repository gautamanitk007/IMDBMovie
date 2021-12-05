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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
    }
    func configure(viewModel: MovieListSceneDataModels.MovieViewModel) {
        self.lblMovieTitle.text = viewModel.movieTitle
        guard let urlString = viewModel.movieThumUrl else { return}
        self.imgThumb.download(url: urlString, mode: .scaleAspectFill)
    }
}
