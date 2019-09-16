//
//  StatsViewController.swift
//  Project 1
//
//  Created by Athena Leong on 9/13/19.
//  Copyright © 2019 Athena. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var longestStreakDisplay: UILabel!
    @IBOutlet weak var homeDisplay: UIBarButtonItem!
    @IBOutlet weak var answerHistory0: UILabel!
    @IBOutlet weak var answerHistory1: UILabel!
    @IBOutlet weak var answerHistory2: UILabel!
    @IBOutlet weak var answerImage0: UIImageView!
    @IBOutlet weak var answerImage1: UIImageView!
    @IBOutlet weak var answerImage2: UIImageView!
    
    var score : Int = 0
    var streak : Int = 0
    var longestStreak : Int = 0
    var answerHistoryList = [Int]()
    var names = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        longestStreakDisplay.text = "\(longestStreak)"
        answerHistory0.text = (names[answerHistoryList[0]])
        answerHistory1.text = (names[answerHistoryList[1]])
        answerHistory2.text = (names[answerHistoryList[2]])
        answerImage0.image = getImageFor(name: names[answerHistoryList[0]])
        answerImage1.image = getImageFor(name: names[answerHistoryList[1]])
        answerImage2.image = getImageFor(name: names[answerHistoryList[2]])
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func homePressed(_ sender: Any) {
        self.performSegue(withIdentifier: "statstoPlay" , sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PlayViewController
        destinationVC.score = score
        destinationVC.longestStreak = longestStreak
        destinationVC.answerHistoryList = answerHistoryList.reversed()
        
    }
    
    func getImageFor(name: String) -> UIImage {
        let noWhitespace = name.components(separatedBy: .whitespaces).joined().lowercased()
        return UIImage(named: noWhitespace)!
    }
    

}
