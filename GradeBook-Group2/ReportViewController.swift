//
//  ReportViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/26/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase

class ReportViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var reportLabel: UILabel!
    
    @IBOutlet weak var studentPicker: UIPickerView!
    @IBOutlet weak var assignmentPicker: UIPickerView!
    var studnetList = [String]()
    var assignmentList = [String]()
    var selectedStudent = String()
    var selectedAssignment = String()
    let userid = Firebase.Auth.auth().currentUser?.uid
    @IBAction func backdidtapped(_ sender: Any) {
        performSegue(withIdentifier: "reportBackToMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Assignments")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.assignmentList.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        let StuRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        StuRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.studnetList.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        self.assignmentPicker.reloadAllComponents()
        self.studentPicker.reloadAllComponents()

        // Do any additional setup after loading the view.
    }

    @IBAction func assignmentdidtapped(_ sender: Any) {
        print("assignment tapped works")
        var grades = [NSInteger]()
        print(selectedAssignment)
        let AssignmentRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        AssignmentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let newSnap = snap.childSnapshot(forPath: "Assignments").childSnapshot(forPath: self.selectedAssignment)
                let key = newSnap.key
                print("here")
                print(newSnap)
                let dictionary = newSnap.value as![String:Any]
                grades.append(dictionary["score"] as! NSInteger)
                print("key = \(key)  value = \(dictionary["score"] as! NSInteger)")
               }
            print(grades)
            grades = grades.sorted()
             print("try to print grade")
            var total = 0
            for g in grades{
                total = total + g
            }
            self.reportLabel.text = "Max: \(grades.last ?? 0) Min: \(grades.first ?? 0) Mean: \(total/grades.count)"
        })
       
        
    }
    
    @IBAction func studentdidtapped(_ sender: Any) {
        print("studentdidtapped works")
        print(selectedStudent)
        var totalPossible = 0
        var actualScore = 0
        let AssignmentRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Assignments")
        AssignmentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
              
                let dictionary = snap.value as![String:Any]
                totalPossible = totalPossible + (dictionary["Max"] as! NSInteger)
               
               
            }
            print(totalPossible)
        })
        let studentRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students").child(selectedStudent).child("Assignments")
        studentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let dictionary = snap.value as![String:Any]
                actualScore = actualScore + (dictionary["score"] as! NSInteger)
                let key = snap.key
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
            var overall = actualScore*100/totalPossible
            var letter = String()
            if(overall/10==9 || overall/10 == 10){
                letter = "A"
            }
            else if(overall/10 == 8){
                letter = "B"
            }
            else if(overall/10 == 7){
                letter = "C"
            }
            else if(overall/10 == 6){
                letter = "D"
            }
            else {letter = "F"}
            self.reportLabel.text = "overall: \(overall) %  \(letter)"
        })
        let newStudentRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        
        
    }
    @IBAction func Loaddidtapped(_ sender: Any) {
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Assignments")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.assignmentList.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        let StuRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        StuRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.studnetList.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        print("assignemts is here:",assignmentList)
        self.studentPicker.reloadAllComponents()
        self.assignmentPicker.reloadAllComponents()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == studentPicker{
            let title = studnetList[row]
            print("pickerview title for row",title)
            return title
        }
        else if pickerView == assignmentPicker{
            let title = assignmentList[row]
            print("pickerview title for row",title)
            return title
        }
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = assignmentList.count
        if pickerView == studentPicker{
            countRows = studnetList.count
        }
        print("pickerview number of Rows in conponent",countRows)
        return countRows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == assignmentPicker{
            print("pickerview set text",assignmentList[row])
            selectedAssignment = assignmentList[row]
        }
        else if pickerView == studentPicker{
            print("pickerview set text",studnetList[row])
            selectedStudent = studnetList[row]
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
