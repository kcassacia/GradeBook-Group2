//
//  AssignmentViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/26/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase

class AssignmentViewController: UIViewController {

    @IBOutlet weak var PossibleGradeTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func backdidtapped(_ sender: Any) {
        performSegue(withIdentifier: "assignmentBackToMain", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let userid = Firebase.Auth.auth().currentUser?.uid
        var list = [String]()
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        ref.observe(.childAdded) { (snapshot) in
            let post = snapshot.value as?String
            if let actualPost = post {
                list.append(actualPost)
                print("reached view did load")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAssignmentdidtapped(_ sender: Any) {
        print("add assignment did tapped")
        let userid = Firebase.Auth.auth().currentUser?.uid
        let name = nameTextField.text
        let category = categoryTextField.text
        guard let possibleGrade: Int? = Int(PossibleGradeTextField.text!) else{return}
        print("reached createing list")
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Students")
        print("reached creating ref")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                let assignmentValue = ["category":category,"max":possibleGrade] as [String : Any]
                ref.child(key).child("Assignments").child(name!).setValue(assignmentValue)
                let value = snap.value
                print("key = \(key)  value = \(value!)")
            }
        })
        let userRef = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/").child("users").child(userid!).child("Assignments")
        
        var assigmentValue = ["Category":category,"Max":possibleGrade] as [String : Any]
        userRef.child(name!).setValue(assigmentValue)
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
