//
//  MoviesViewModel.swift
//  ReduceeeIt
//
//  Created by Adam Kane on 24/09/2021.
//

import Foundation

struct MoviesState {
    var movies: [Movie] = []
    var fetching: Bool = false
}

extension MoviesState {
    enum Change {
        case none
        case fetchStateChanged
        case moviesChanged
    }
    
    mutating func setFetching(fetching: Bool) -> Change {
        self.fetching = fetching
        return .fetchStateChanged
    }
    
    mutating func reloadMovies(movies: [Movie]) -> Change {
        self.movies = movies
        return .moviesChanged
    }
}

class MoviesViewModel {
    private(set) var state = MoviesState()
    
    var stateChangeHandler: ((MoviesState.Change) -> Void)?
    
    func fetchMovies() {
        let fetchStateChange = state.setFetching(fetching: true)
        stateChangeHandler?(fetchStateChange)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) { [self] in
            let reloadChange = self.state.reloadMovies(movies: [Movie(id: 1, name: "The Mask", runningTimeMinutes: 123),
                                                                Movie(id: 2, name: "The Mask 2", runningTimeMinutes: 65)])
            stateChangeHandler?(reloadChange)
            
            let fetchStateChange = state.setFetching(fetching: false)
            stateChangeHandler?(fetchStateChange)
        }
    }
}
