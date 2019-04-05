//
// ViewController.swift
// ListImagesFileManager
//
// Created by: FuzzyBuckBeak on 4/4/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import UIKit

class ViewController: UITableViewController {
    var pictures: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func loadData() {
        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath else { fatalError("Cant find resource Path")}
        
        do {
            pictures = try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            print("Could not read contents of file");
        }
        
        print(pictures.sort())
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detail = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailedViewController {
            detail.selectedPicture = indexPath.row + 1
            detail.totalPicture = pictures.count
            detail.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(detail, animated: true)
        }
    }
}

