//
//  ViewController.swift
//  Word Scambler
//
//  Created by Apo on 4/10/19.
//  Copyright © 2019 FuzzyBuckbeak. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var usedWords: [String] = []
    var allWords: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

extension ViewController {
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func refresh() {
        startGame()
    }
    
    @objc func promptAnswer() {
        let alertView = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        alertView.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertView] (action) in
            guard let answer = alertView?.textFields?[0].text else { return }
            self?.submit(answer)
            
        }
        
        alertView.addAction(submitAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func submit(_ value: String) {
        let lowercase = value.lowercased()
        
        let isPossibleValue = isPossible(word: lowercase)
        if case .valid =  isPossibleValue {
            let isOriginalValue = isOriginal(word: lowercase)
            if case .valid = isOriginalValue {
                let isRealValue = isReal(word: lowercase)
                if case .valid = isRealValue {
                    usedWords.insert(lowercase, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .fade)
                    return
                } else {
                    handleError(isRealValue)
                }
            } else {
                handleError(isOriginalValue)
            }
        } else {
            handleError(isPossibleValue)
        }
    }
}
