//
//  HomeController.swift
//  AttendanceAppKing
//
//  Created by marvin evins on 5/6/20.
//  Copyright © 2020 websavantmedia. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    // time elements of app
    var seconds = 3000
    var timer = Timer()
    var calendar = Calendar.current
    
       //clock variables
    //note : later refactor into its own file
        var hrs = 0
        var min = 0
        var sec = 0
        var diffHrs = 0
        var diffSecs = 0
       //end clock variables
    
    
    @IBOutlet weak var clock: UILabel!
    
    @IBOutlet weak var date: UILabel!
    // end time elements of app.
    
    
    
    // colors
    var colors = [Color(name: "absent", uiColor: UIColor.red),
                  Color(name: "tardy", uiColor: UIColor.yellow),
                  Color(name: "present", uiColor: UIColor.green),
                ]
    
    //button overlay of cell
    
    
    
    //end button overlay of cell
    
    
    
    @IBOutlet weak var collection: UICollectionView!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var student = [Student]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        collection.dataSource = self
        collection.delegate = self
        
        parseStudentCSV()
        
        //begin  class clock text
        seconds = 3000
        clock.text = "00:00:00"
        
        //date
        // have to refactor this somewhere into its own file
        let dateNow = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        let dateTimeString = formatter.string(from: dateNow)
        date.text = "Date:  \(dateTimeString)"
        //end date
        
        
        
    }
    
    //for parsing csv file
    func parseStudentCSV(){
        let path = Bundle.main.path(forResource: "MOCK_DATA", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                //let id = Int(row["id"]!)!
                let first_name = row["first_name"]!
                let last_name = row["last_name"]!
                let email = row["email"]!
                let gender = row["gender"]!
                
                let stud = Student(first_name: first_name, last_name: last_name, email: email, gender: gender)
                
                student.append(stud)
                
                
            }
        }catch let err  as NSError{
            print(err.debugDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 30
     }
     
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCell", for: indexPath) as? StudentCell{
            
            let stud = student[indexPath.row]
            cell.configureCell(student:stud)
                   return cell
               }else{
                   return UICollectionViewCell()
               }
        
      
        

        
//        let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
//              selectedCell.contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
             
     }
    
    //changing color on touch and duration of time passeds
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        // will change color on color and time duration on touch

        if selectedCell.isSelected {
            
             if  min < 5{
            selectedCell.backgroundColor = UIColor.green
            }
            else if min > 5{
                selectedCell.backgroundColor = UIColor.yellow
                print("student is tardy")
                // and should add tardy to list of tardies
            }
            else if min > 45{
                selectedCell.backgroundColor = UIColor.red
                print("student is absent")
                //and should add absence to list of absences
            }
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 142, height: 142)
    }
    
    
    
    
    // time elements implementation
    
    // start button
    @IBAction func start(_ sender: UIButton) {
        //self.removeSavedData()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(HomeController.updateLabels(t:)), userInfo: nil, repeats: true)
        counter()
    }
    @objc func counter(){
        seconds -= 1
        clock.text = String(seconds)
        
        if(seconds == 0){
            timer.invalidate()
        }
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
        self.timer.invalidate()
//
//        clock.text = "time: \(timer.timeInterval)"
        
        //self.resetContent()
    }
    
    
    @IBAction func resumeBtn(_ sender: UIButton) {
        
        timer.fire()
        //self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeController.updateLabels(t:)), userInfo: nil, repeats: true)

    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        clock.text = "00:00:00"
    }
    
    
    func resetContent(){
        timer.invalidate()
        self.clock.text = "00:00:00"
        self.sec = 0
        self.min = 0
        self.hrs = 0
        
    }
    
    @objc func updateLabels(t: Timer){
        if (self.sec == 59){
            self.min += 1
            self.sec = 0
            if(self.min == 60){
                self.hrs += 1
                self.min = 0
            }
        }else{
            self.sec += 1
        }
        self.clock.text = String(format: "%02d : %02d :%02d", self.hrs, self.min, self.sec)
    }
    
    
    //get time difference
//    static func getTimeDifference(startDate: Date)-> ( Int, Int, Int){
//        let calendar = Calendar.current
//        let components = calendar.dateComponents(.hour, .minute, .second, from: startDate, to: Date())
//        return (components.hour!, components.minute!, components.second!)
//    }
    
    //refresh timer
    func refresh(hours: Int, mins: Int, secs: Int){
        self.hrs += hours
        self.min += mins
        self.sec += secs
        self.clock.text = String(format: "%02d : %02d :%02d", self.hrs, self.min, self.sec)
        self.timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: (#selector(HomeController.updateLabels(t:))), userInfo: nil, repeats: true)
    
    
    }
    
    
    //maybe I want to save the daat  -- I will come back and work on this.
    func removeSavedData(){
        if(UserDefaults.standard.object(forKey: "savedTime") as? Date) != nil{
            UserDefaults.standard.removeObject(forKey: "savedTime")
        }
    }
    
}
