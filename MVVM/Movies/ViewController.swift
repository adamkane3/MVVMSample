//
//  ViewController.swift
//  ReduceeeIt
//
//  Created by Adam Kane on 24/09/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var moviesTableView: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var moviesViewModel: MoviesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesViewModel = MoviesViewModel()
        
        moviesTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        moviesViewModel.stateChangeHandler = {
            [self] change in
            DispatchQueue.main.async {
                switch change {
                case .none: break
                case .moviesChanged: DispatchQueue.main.async { self.moviesTableView.reloadData() }
                case .fetchStateChanged: self.setLoadingViewVisible(moviesViewModel.state.fetching)
                }
            }
        }
        moviesViewModel.fetchMovies()
    }
    
    func setLoadingViewVisible(_ loading: Bool) {
        loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = !loading
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.state.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.setup(movie: moviesViewModel.state.movies[indexPath.row])
        return cell
    }
}
