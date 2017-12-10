//
//  AssignmentViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/26/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import FirebaseAuth
import RNNotificationView
import Firebase

class AssignmentViewController: UIViewController {

    @IBAction func backdidtapped(_ sender: Any) {
        performSegue(withIdentifier: "assignmentBackToMain", sender: self)
    }
    
   
    @IBOutlet weak var pointsPossibleTextField: UITextField!
    @IBOutlet weak var assignmentTextField: UITextField!
    
    @IBAction func addAssignmentdidtapped(_ sender: Any) {
        print("add assignment did tapped")
        let userid = Firebase.Auth.auth().currentUser?.uid
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/")
        //let userReference = ref.child("users").child(userid!)
        var studentID: NSArray = []
        // let studentRef = ref.child().child(userid!)
        let assignment = assignmentTextField.text
        print(assignment)
        let pointsPossible = pointsPossibleTextField.text
        print(pointsPossible)
        let value = ["assignment":assignment]
        ref.child("users").child(userid!).child(pointsPossible!).setValue(value)
        // studentRef.updateChildValues(value)
        // let assignmentListRef = studentRef.child("AssignmentList")
        RNNotificationView.show(withImage: UIImage(named: "sambleIcon"),
                                title: "Congratulations!",
                                message: "You have successfully added a new assignment.",
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
