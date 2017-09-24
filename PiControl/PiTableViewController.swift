//
//  PiTableViewController.swift
//  PiControl
//
//  Created by Andreas Bachmaier on 26.05.15.
//  Copyright (c) 2015 Andreas Bachmaier. All rights reserved.
//

import UIKit

class PiTableViewController: UITableViewController  {
    
    var menu: [(title: String, urlString: String)] = [
        ("Pi Blog", "http://pi.bachmaier.cc/wordpress/"),
        ("ownCloud", "http://pi.bachmaier.cc/owncloud/"),
        ("Temperatur", "http://pi.bachmaier.cc/temp.html"),
        ("Status", "http://pi.bachmaier.cc/cpu.php"),
        ("RPi Monitor", "http://srv.bachmaier.cc:8888/status.html"),
        ("phpMyAdmin", "http://pi.bachmaier.cc/phpmyadmin/")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel!.text = menu[(indexPath as NSIndexPath).row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tvMain: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showUrl", sender: indexPath)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let row = ((sender as! IndexPath) as NSIndexPath).row
        if let url = URL(string: menu[row].urlString),
            let webVC = segue.destination as? PiWebViewController {
                webVC.title = menu[row].title
                webVC.setMyUrl(url)
        }
    }
    
}
