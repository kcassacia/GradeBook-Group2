//
//  CategoryViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/26/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RNNotificationView


class CategoryViewController: UIViewController {

    @IBOutlet weak var WeightOfCategoryTextField: UITextField!
    @IBOutlet weak var NameOfCategoryTextField: UITextField!
    @IBAction func backdidtapped(_ sender: Any) {
        performSegue(withIdentifier: "categoryBackToMain", sender: self)
    }
    @IBOutlet weak var categoryTextField: UITextField!
    

    @IBOutlet weak var weightTextField: UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addCategorydidtapped(_ sender: Any) {
        print("add category did tapped")
        let userid = Firebase.Auth.auth().currentUser?.uid
        var name = categoryTextField.text
        guard let weight: Int? = Int(weightTextField.text!) else{return}
        let ref = Database.database().reference(fromURL: "https://gradebook-group2.firebaseio.com/")
        let value = ["weight":weight]
        ref.child("users").child(userid!).child("Category").child(name!).setValue(value)
        RNNotificationView.show(withImage: UIImage(named: "sambleIcon"),
                                title: "Congratulations!",
                                message: "You have successfully added a new category.",
                                duration: 2,
                                iconSize: CGSize(width: 22, height: 22), // Optional setup
            onTap: {
                print("Did tap notification")
        }
        )
        
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
