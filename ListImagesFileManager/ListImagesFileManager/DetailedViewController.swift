//
// DetailedViewController.swift
// ListImagesFileManager
//
// Created by: FuzzyBuckBeak on 4/4/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.



/*****************************************************************************************************************************





*****************************************************************************************************************************/

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var selectedImage: String?
    var selectedPicture: Int = 0
    var totalPicture: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detailImage = selectedImage {
            image.image = UIImage(named: detailImage)
        }
        // Do any additional setup after loading the view.
        title = "\(selectedPicture) of \(totalPicture)"
        navigationItem.largeTitleDisplayMode = .never
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
