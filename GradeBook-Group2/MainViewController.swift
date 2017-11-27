//
//  MainViewController.swift
//  GradeBook-Group2
//
//  Created by Yilin Zhao on 11/18/17.
//  Copyright © 2017 Yilin Zhao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var StudentButton: UIButton!
    
    @IBOutlet weak var CategoryButton: UIButton!
    @IBOutlet weak var AssignmentButton: UIButton!
    @IBOutlet weak var GradeButton: UIButton!
    @IBOutlet weak var ReportButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set border color and width
        // Do any additional setup after loading the view.
        StudentButton.layer.borderWidth=2.0
        StudentButton.layer.borderColor=UIColor.blue.cgColor
        CategoryButton.layer.borderWidth=2.0
        CategoryButton.layer.borderColor=UIColor.blue.cgColor
        AssignmentButton.layer.borderWidth=2.0
        AssignmentButton.layer.borderColor=UIColor.blue.cgColor
        GradeButton.layer.borderWidth=2.0
        GradeButton.layer.borderColor=UIColor.blue.cgColor
        ReportButton.layer.borderWidth=2.0
        ReportButton.layer.borderColor=UIColor.blue.cgColor
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StudentDidTapped(_ sender: Any) {
        print("student did tapped")
        performSegue(withIdentifier: "toStudent", sender: self)
    }
    @IBAction func CategoryDidTapped(_ sender: Any) {
        print("category did tapped")
        performSegue(withIdentifier: "toCategory", sender: self)
    }
    @IBAction func AssignmentDidTapped(_ sender: Any) {
        print("Assignment did tapped")
        performSegue(withIdentifier: "toAssignment", sender: self)
    }
    @IBAction func GradeDidTapped(_ sender: Any) {
        print("Grade did tapped")
        performSegue(withIdentifier: "toGrade", sender: self)
    }
    @IBAction func ReportDidTapped(_ sender: Any) {
        print("report did tapped")
        performSegue(withIdentifier: "toReport", sender: self)
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
