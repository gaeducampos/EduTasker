//
//  GradeViewController.swift
//  EduTasker
//
//  Created by Gabriel Campos on 7/1/24.
//

import UIKit

class GradeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presentSessionExperiendAlert()
    }
    
}
