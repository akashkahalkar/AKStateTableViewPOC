//
//  ViewController.swift
//  StateTableViewPOC
//
//  Created by Akash kahalkar on 26/11/18.
//  Copyright © 2018 Akashka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statetableView: StateTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showData(_ sender: Any) {
        statetableView.setState(state: .with(image: "noData", title: "No Data Available", buttonTitle: "Retry", action: {
            self.statetableView.setState(state: .dataAvailable)
        }))
    }
    
    @IBAction func showNWError(_ sender: Any) {
        statetableView.setState(state: .with(image: "noNetwork",
                                             title: "Not Connected to Network",
                                             buttonTitle: "Retry", action: {
            self.statetableView.setState(state: .dataAvailable)
        }))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (tableView as! StateTableView).currentState {
        
        case .dataAvailable:
            return 5
        default:
            tableView.separatorStyle = .none
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "test Data"
        return cell
    }
    
    
}

