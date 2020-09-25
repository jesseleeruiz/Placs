//
//  SearchViewController.swift
//  Placs
//
//  Created by Jesse Ruiz on 8/31/20.
//  Copyright © 2020 Jesse Ruiz. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    weak var mainTabBarController: UITabBarController!
    
    var allCities = [City]()
    var matchingCities = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let capitalsURL = Bundle.main.url(forResource: "capitals", withExtension: "json"),
            let contents = try? Data(contentsOf: capitalsURL) else { return }
        
        let cities = JSON(contents).arrayValue
        
        for city in cities {
            let coords = CLLocationCoordinate2D(latitude: city["lat"].doubleValue, longitude: city["lon"].doubleValue)
            
            let newCity = City(name: city["name"].stringValue,
                               country: city["country"].stringValue,
                               coordinates: coords)
            
            allCities.append(newCity)
        }
        allCities.sort()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let city = matchingCities[indexPath.row]
        
        cell.textLabel?.text = city.formattedName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let map = mainTabBarController.viewControllers?.first as? ViewController else { return }
        
        let city = matchingCities[indexPath.row]
        map.focus(on: city)
        
        mainTabBarController.selectedIndex = 0
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text else { return }
        
        if search.isEmpty {
            // No text - Return all cities
            matchingCities = allCities
        } else {
            // Run search
            matchingCities = allCities.filter { $0.matches(search) }
        }
        tableView.reloadData()
    }
}
