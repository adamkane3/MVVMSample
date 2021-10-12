//
//  MovieTableViewCell.swift
//  ReduceeeIt
//
//  Created by Adam Kane on 12/10/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieRuntimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(movie: Movie) {
        movieTitleLabel.text = movie.name
        movieRuntimeLabel.text = "Runtime: \(movie.runningTimeMinutes)"
    }
}
