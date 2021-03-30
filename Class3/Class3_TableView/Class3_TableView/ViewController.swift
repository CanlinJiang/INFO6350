//
//  ViewController.swift
//  Class3_TableView
//
//  Created by little tree on 2/14/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource//!{
    
    @IBOutlet weak var tblView: UITableView!
    let names = ["Adams, John ",
                 "Adams, John Quincy ",
                 "Arthur, Chester Alan ",
                 "Biden, Joseph R. ",
                 "Buchanan, James ",
                 "Bush, George",
                 "Bush George W. ",
                 "Carter, Jimmy ",
                 "Cleveland, Grover ",
                 "Clinton, Bill ",
                 "Coolidge, Calvin ",
                 "Eisenhower, Dwight D.",
                 "Fillmore, Millard ",
                 "Ford, Gerald R. ",
                 "Garfield, James A. ",
                 "Grant, Ulysses S. ",
                 "Harding, Warren G. ",
                 "Harrison, Benjamin ",
                 "Harrison, William Henry",
                 "Hayes, Rutherford Birchard ",
                 "Hoover, Herbert ",
                 "Jackson, Andrew ",
                 "Jefferson, Thomas ",
                 "Johnson, Andrew ",
                 "Johnson, Lyndon B. ",
                 "Kennedy, John F. ",
                 "Lincoln, Abraham ",
                 "Madison, James ",
                 "McKinley, William ",
                 "Monroe, James ",
                 "Nixon, Richard M. ",
                 "Obama, Barack ",
                 "Pierce, Franklin ",
                 "Polk, James K. ",
                 "Reagan, Ronald ",
                 "Roosevelt, Franklin D. ",
                 "Roosevelt, Theodore ",
                 "Taft, William H. ",
                 "Taylor, Zachary ",
                 "Truman, Harry S. ",
                 "Trump, Donald J. ",
                 "Tyler, John ",
                 "Van Buren, Martin ",
                 "Washington, George ",
                 "Wilson, Woodrow "]
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self //!
        tblView.dataSource = self //!
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    
    
}

