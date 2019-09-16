//
//  PlayViewController.swift
//  Project 1
//
//  Created by Athena Leong on 9/13/19.
//  Copyright © 2019 Athena. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var scoreDisplay: UILabel!
    @IBOutlet weak var statsDisplay: UIBarButtonItem!
    @IBOutlet weak var timerDisplay: UILabel!
    @IBOutlet weak var timerControl: UIButton!
    
    
    let names = ["Aady Pillai", "Aarushi Agrawal", "Aayush Tyagi", "Abhinav Kejriwal", "Aditya Yadav", "Ajay Merchia", "Anand Chandra", "Andres Medrano", "Andrew Santoso", "Angela Dong", "Anika Bagga", "Anik Gupta", "Anita Shen", "Anjali Thakrar", "Anmol Parande", "Ashwin Aggarwal", "Ashwin Kumar", "Athena Leong", "Austin Davis", "Ayush Kumar", "Brandon David", "Candace Chiang", "Candice Ye","Charles Yang", "Daniel Andrews", "Divya Tadimeti", "DoHyun Cheon", "Eric Kong", "Ethan Wong", "Imran Khaliq", "Izzie Lau", "Jacqueline Zhang", "Japjot Singh", "Joey Hejna", "Justin Kim", "Kanyes Thaker", "Karen Alarcon", "Katniss Lee", "Kayli Jiang", "Kiana Go", "Leon Kwak", "Lewis Zhang", "Matthew Locayo", "Max Emerling", "Max Miranda", "Melanie Cooray", "Michelle Mao", "Mohit Katyal", "Mudabbir Khan", "Natasha Wong", "Neha Nagabothu", "Nikhar Arora", "Noah Pepper", "Patrick Yin", "Paul Shao", "Radhika Dhomse", "Sai Yandapalli", "Salman Husain", "Samantha Lee", "Shaina Chen", "Sharie Wang", "Shaurya Sanghvi", "Shiv Kushwah", "Shomil Jain", "Shubha Jagannatha", "Shubham Gupta", "Sinjon Santos", "Srujay Korlakunta", "Stephen Jayakar", "Tyler Reinecke", "Vaibhav Gattani", "Varun Jhunjhunwalla", "Victor Sun", "Vidya Ravikumar", "Vineeth Yeevani", "Will Oakley","Xin Yi Chen", "--- ---"]
    
    let members = 77
    let noOfButtons = 4


    //setUp
    var correctNum : Int?
    var wrongNum1 : Int?
    var wrongNum2 : Int?
    var wrongNum3 : Int?
    var correctButton : Int?
    var score = 0
    var buttonList : [UIButton]!
    var buttonPressed: Int?
    var originalColor: UIColor!
    
    //timer
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false

    // longest streak
    var longestStreak = 0
    var streak = 0
    
    //answer_history
    var answerHistoryList = [77,77,77]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonList = [button1, button2, button3, button4]
        originalColor = button1.backgroundColor
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func startGame(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.setUp()
        }
    }
    
    func resetGame(){
        resetButtonColors()
        scoreUpdate()
        resetTimer()
       
    }
    
    func resetButtonColors(){
        for button in buttonList{
            button.backgroundColor = originalColor
        }
    }
    
    func resetTimer(){
        timer.invalidate()
        seconds = 6
        isTimerRunning = false
    }
    
    func setStreak(){
        if streak > longestStreak{
            longestStreak = streak
        }
    }

    func setUp(){
        
        //generate question & answers
        //resetButtonColors()
        //scoreUpdate()
        resetButtonColors()
        scoreUpdate()
        resetTimer()
        setStreak()
        var randomTuple = randomGenerator()
        correctNum = randomTuple.0
        wrongNum1 = randomTuple.1
        wrongNum2 = randomTuple.2
        wrongNum3 = randomTuple.3
        correctButton = Int(arc4random_uniform(UInt32(noOfButtons)))
        answerHistoryList.append(correctNum!)
        
        //set up image
        imageView.image = getImageFor(name: names[correctNum!])
       
        //set up options
        var wrongNums = [wrongNum1,wrongNum2,wrongNum3]
        buttonList[correctButton!].setTitle(names[correctNum!], for: .normal)
        buttonList.remove(at: correctButton!)
        for i in 0...(noOfButtons - 2){
            buttonList[i].setTitle(names[wrongNums[i]!], for: .normal)
        }
        buttonList = [button1, button2, button3, button4] //reset
        
        //start timer
        runTimer()
    
    }
    
    
    @IBAction func button0Pressed(_ sender: Any) {
        buttonPressed = 0
        if correctButton == 0{
            score += 1
            streak += 1
            changeGreenColor()
        }
        else {
            streak = 0
            changeRedColor()
        }
        startGame()
    }
    

    @IBAction func button1Pressed(_ sender: Any) {
        buttonPressed = 1
        if correctButton == 1{
            score += 1
            streak += 1
            changeGreenColor()
        }
        else {
            streak = 0
            changeRedColor()
        }
        startGame()
    }

    
    @IBAction func button2Pressed(_ sender: Any) {
        buttonPressed = 2
        if correctButton == 2{ 
            score += 1
            streak += 1
            changeGreenColor()
        }
        else{
            streak = 0
            changeRedColor()
        }
        startGame()
    }
    
    
    @IBAction func button3Pressed(_ sender: Any) {
        buttonPressed = 3
        if correctButton == 3{
            score += 1
            streak += 1
            changeGreenColor()
        }
        else{
            streak = 0
            changeRedColor()
        }
        startGame()
    }
    
    func scoreUpdate(){
        scoreDisplay.text = "Score : \(score)"
    }
    
    
    @IBAction func statsPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "playtoStats" , sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StatsViewController
        destinationVC.score = score
        destinationVC.streak = streak
        destinationVC.longestStreak = longestStreak
        destinationVC.answerHistoryList = answerHistoryList.reversed()
        destinationVC.names = names
    }
    
    func getImageFor(name: String) -> UIImage {
        let noWhitespace = name.components(separatedBy: .whitespaces).joined().lowercased()
        return UIImage(named: noWhitespace)!
    }
    
    // Generate 4 random numbers
    func randomGenerator() -> (Int?, Int?, Int?, Int?){
        var previousNum = [Int]()
        var num : Int = 0
        for _ in 0...3 {
            while true {
                num = Int(arc4random_uniform(UInt32(members)))
                if !previousNum.contains(num){
                    previousNum.append(num)
                    break
                }
            }
        }
        return (previousNum[0], previousNum[1], previousNum[2], previousNum[3])
    }
    
    func changeGreenColor() {
        buttonList[buttonPressed!].backgroundColor = UIColor.green
    }
    
    func changeRedColor() {
        buttonList[buttonPressed!].backgroundColor = UIColor.red
    }
    
    // timer
    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(PlayViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds
        timerDisplay.text = "\(seconds):00" //This will update the label.
        if seconds == 1{
            startGame()
        }
    }

    @IBAction func timerPressed(_ sender: Any) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }
    }
}

        
        




