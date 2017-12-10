//
//  StudentViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/25/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import RNNotificationView


class StudentViewController: UIViewController {
    
    
    @IBAction func backdidtapped(_ sender: Any) {
    
        performSegue(withIdentifier: "studentBackToMain", sender: self)
        
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var IDTextFIeld: UITextField!
    
    @IBAction func addStudentdidtapped(_ sender: Any) {
        print("add student did tapped")
        let userid = Firebase.Auth.auth().currentUser?.uid
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/")
        //let userReference = ref.child("users").child(userid!)
        //var studentID: NSArray = []
     // let studentRef = ref.child().child(userid!)
        let name = nameTextField.text
        print(name)
        let id = IDTextFIeld.text
        print(id)
        let value = ["name":name]
        ref.child("users").child(userid!).child("Students").child(id!).setValue(value)
       // studentRef.updateChildValues(value)
       // let assignmentListRef = studentRef.child("AssignmentList")
        RNNotificationView.show(withImage: UIImage(named: "sambleIcon"),
                                title: "Congratulations!",
                                message: "You have successfully added a new student.",
                                duration: 2,
                                iconSize: CGSize(width: 22, height: 22), // Optional setup
            onTap: {
                print("Did tap notification")
        }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
