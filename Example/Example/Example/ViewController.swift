//
//  ViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/2/3.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView!
    private var dataList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initConfig()
        initElements()
    }
}

private extension ViewController {
    private func initElements() {
        self.tableView = UITableView()
        self.tableView.frame = CGRect(x: 0, y: 88, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100)
        self.tableView.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
    }
    
    private func initConfig() {
        self.dataList = ["EXAMPLE", "TEST"]
        self.navigationItem.title = "SKRegularText"
    }
}

private extension ViewController {
    private func toNestVC(_ index: Int) {
        if index > 0 {
            let testVC = TestViewController()
            self.show(testVC, sender: nil)
        } else {
            let exampleVC = ExampleViewController()
            self.show(exampleVC, sender: nil)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        toNestVC(indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.dataList[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        return cell
    }
}
