//
// ViewController.swift
// BullsEye
//
// Created by: FuzzyBuckBeak on 4/2/19
// Copyright © 2018 FuzzyBuckBeak. All rights reserved.

import UIKit
import Foundation

class ViewController: UIViewController {
    // MARK: - IBOutets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    
    // MARK: - Properties
    var sliderValue: Int = 0
    var targetValue: Int = 0
    var totalScore: Int = 0
    var roundValue: Int = 0
    
    // MARK: - Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        customizeSlider()
    }
    
    func startNewGame() {
        roundValue += 1
        targetValue = randomNumber()
        updateUI()
        sliderValue = slider.value.RoundedInt()
    }
    
    // MARK: - IBActions
    @IBAction func handleHitMe(_ sender: Any) {
        
        let details = scoreDetails()
        let alert = UIAlertController(title: "\(details.title)",
                                      message: "You Scored \(details.points)",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default) { (action) in
                                        self.startNewGame()
                                   }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func sliderChanged(_ slider: UISlider) {
        sliderValue = slider.value.RoundedInt()
    }
    
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
    }
    
    // MARK: - User Interface update
    private func updateUI() {
        target.text = targetValue.StringValue()
        slider.setValue(1, animated: true)
        score.text = totalScore.StringValue()
        round.text = roundValue.StringValue()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    private func updateTotalScore(_ points: Int) {
        totalScore += points
       
    }
    
    func customizeSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
     // MARK: - Helper methods
    func randomNumber() -> Int {
        return Int.random(in: 1 ... 100)
    }
    
    private func calculateScores() -> Int {
        return abs(targetValue - sliderValue)
    }
    
    private func scoreDetails() -> (title: String, points: Int) {
        let difference = calculateScores()
        var points: Int = 100 - difference
        var title: String = ""
        
        switch difference {
        case 0:
            title = "Perfect!"
            points += 100
        case 0 ..< 5:
            title = "Almost had it!"
            points += 50
        case 5 ..< 10:
            title = "Pretty Good!"
        default:
            title = "Not even close ..."
        }
        updateTotalScore(points)
        return (title, points)
    }
}

