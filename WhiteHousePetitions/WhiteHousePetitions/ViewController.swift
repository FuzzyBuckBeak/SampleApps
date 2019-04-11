//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Apo on 4/10/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions: [Petition] = []
    var filtered: [Petition] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsTapped))
        let filter = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterTapped))
        let clearFilter =  UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearFilterTapped))
        navigationItem.leftBarButtonItems = [filter, clearFilter]
        title = "Petitions"
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController {
    func getData() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        APIManager.getPetitions(url: urlString) { [weak self] (petitionData, error) in
            if let data = petitionData?.results {
                self?.petitions = data
                self?.filtered = data
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(ac, animated: true)
                }
            }
        }
    }
    
    @objc func creditsTapped() {
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterTapped() {
        let ac = UIAlertController(title: "Filter", message: "Enter the petition to filter by", preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Submit", style: .default) { [weak ac, weak self] action in
            guard let filteredValue = ac?.textFields?[0].text else { return }
            self?.submit(filteredValue)
        }
        ac.addAction(action)
        present(ac, animated: true)
        filtered = petitions
    }
    
    func submit(_ value: String) {
        filtered = petitions.filter { (petition) -> Bool in
            petition.body.localizedLowercase.contains(value.localizedLowercase)
        }
        tableView.reloadData()
    }
    
    @objc func clearFilterTapped() {
        filtered = petitions
        tableView.reloadData()
    }
}

