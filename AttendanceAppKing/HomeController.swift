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
    
    
    @IBOutlet weak var clock: UILabel!
    
    @IBOutlet weak var date: UILabel!
    // end time elements of app.
    
    
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
        clock.text = "50 minutes"
        
        //date
        
        let dateNow = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        let dateTimeString = formatter.string(from: dateNow)
        date.text = "Date:  \(dateTimeString)"
        
        
        
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
         
     }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 142, height: 142)
    }
    
    
    
    
    // time elements implementation
    
    // start button
    @IBAction func start(_ sender: Any) {
        
        timer = Timer.scheduledTimer(timeInterval: 3000, target: self, selector: #selector(HomeController.counter), userInfo: nil, repeats: true)
    }
    @objc func counter(){
        seconds -= 1
        clock.text = String(seconds)
        
        if(seconds == 0){
            timer.invalidate()
        }
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
        timer.invalidate()
        
        clock.text = "time: \(String(seconds))"
        
        //to reset timer
        //seconds = 3000
    }
    
    
    @IBAction func resetBtn(_ sender: Any) {
        seconds = 3000
        clock.text = "3000"
    }
    
}
