//
//  GradeViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/26/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase

class GradeViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{

    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var StudentPickerView: UIPickerView!
    @IBOutlet weak var selectassignmentLabel: UILabel!
    @IBOutlet weak var selectStudentLabel: UILabel!
    @IBAction func backdidtapped(_ sender: Any) {
        performSegue(withIdentifier: "GradeBackToMain", sender: self)
    }
    @IBOutlet weak var AssignmentPickerView: UIPickerView!
    let foods = ["apple","orange","banana","peas"]
    var assignments = [String]()
    var studentIDs = [String]()
    let userid = Firebase.Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Assignments")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.assignments.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        let StuRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        StuRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.studentIDs.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        self.AssignmentPickerView.reloadAllComponents()
        self.StudentPickerView.reloadAllComponents()
        
        
       
    }
    @IBAction func submitButtondidtapped(_ sender: Any) {
        let score = Int(textBox.text!)
        let scoreValue = ["score":score]
        let assignmentRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students").child(selectStudentLabel.text!).child("Assignments").child(selectassignmentLabel.text!)
        assignmentRef.updateChildValues(scoreValue)
    }
    
    @IBAction func SelectAssignmentdidtapped(_ sender: Any) {
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Assignments")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.assignments.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        let StuRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        StuRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.studentIDs.append(key)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        print("assignemts is here:",assignments)
          self.StudentPickerView.reloadAllComponents()
        self.AssignmentPickerView.reloadAllComponents()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == StudentPickerView{
            let title = studentIDs[row]
            print("pickerview title for row",title)
            return title
        }
        else if pickerView == AssignmentPickerView{
            let title = assignments[row]
            print("pickerview title for row",title)
            return title
        }
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows = assignments.count
        if pickerView == StudentPickerView{
            countRows = studentIDs.count
            }
        print("pickerview number of Rows in conponent",countRows)
        return countRows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == AssignmentPickerView{
            print("pickerview set text",assignments[row])
            selectassignmentLabel.text = assignments[row]
        }
        else if pickerView == StudentPickerView{
            print("pickerview set text",studentIDs[row])
            selectStudentLabel.text = studentIDs[row]
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
