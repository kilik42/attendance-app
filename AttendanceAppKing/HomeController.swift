//
//  HomeController.swift
//  AttendanceAppKing
//
//  Created by marvin evins on 5/6/20.
//  Copyright © 2020 websavantmedia. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
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
        
        
    }
    
    //for parsing csv file
    
    func parseStudentCSV(){
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 30
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCell", for: indexPath) as? StudentCell{
            
            let student = Student(first_name: "dave", last_name: "donald", id: "3", email: "geraldman", gender: "M", tardy: 5, absence: 9)
            cell.configureCell(student:student)
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


}
