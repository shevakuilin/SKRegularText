//
//  TestViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/2/3.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initConfig()
    }
    
}

private extension TestViewController {
    private func initConfig() {
        self.title = "Test"
        self.view.backgroundColor = .white
    }
}
