//
//  ListTableVC.swift
//  TheWeather
//
//  Created by admin on 11/14/21.
//

import UIKit


class ListTableVC: UITableViewController {
    
    
    
    let emptyCity = Weather()
    var cityArray = [Weather]()
    var filterCityArray = [Weather]()
    
    var nameCityArray = ["Москва", "Пенза", "Хабаровск", "Красноярск", "Новосибирск", "Омск", "Екатеринбург", "Томск", "Сочи", "Уфа"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard searchController.searchBar.text != nil else { return false }
        return true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chechedArray()
        addCity()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
    
    }
    
    func chechedArray() {
        if cityArray.isEmpty {
            cityArray = Array(repeating: emptyCity, count: nameCityArray.count)
        }
    }
    
    @IBAction func pressAddButton(_ sender: Any) {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { (city) in
            self.nameCityArray.append(city)
            self.cityArray.append(self.emptyCity)
            self.addCity()
        }
        
        
    }

    
    
    func addCity() {
        getCityWeather(cityArray: self.nameCityArray) { (index, weather) in
            self.cityArray[index] = weather
            self.cityArray[index].name = self.nameCityArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCityArray.count
        }
       
        return cityArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        
        var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = cityArray[indexPath.row]
        }
       
        cell.configure(weather: weather)
        return cell
    }
    
    // MARK: - Delete Cell
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completeionHandler) in
            let editingRow = self.nameCityArray[indexPath.row]
            
            if let index = self.nameCityArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.cityArray.remove(at: index)
                }
            
            }
            tableView.reloadData()
        }
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: - Navigation to DetailVC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                let filter = filterCityArray[indexPath.row]
                let destVC = segue.destination as! DetailVC
                destVC.weatherModel = filter
                
            } else {
                
                let cityWeather = cityArray[indexPath.row]
                let destVC = segue.destination as! DetailVC
                destVC.weatherModel = cityWeather
            }
            
            
        }
    }
}
extension ListTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String){
        
        filterCityArray = cityArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
