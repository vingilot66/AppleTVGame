//
//  HighScoresTableViewController.swift
//  Assignment2Game
//
//  Created by Christopher Reynolds on 2019-11-27.
//  Copyright © 2019 Christopher Reynolds. All rights reserved.
//

import UIKit

class HighScoresTableViewController: UITableViewController {
    
    let getData = GetData()
    var timer : Timer!
    @IBOutlet var myTable : UITableView!
    @IBOutlet var myImage : UIImageView?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.refreshTable), userInfo: nil, repeats: true)
        
        getData.jsonParser()
    }
    
    @objc func refreshTable(){
        if (getData.dbData?.count)! > 0
        {
            self.myTable.reloadData()
            self.timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image: UIImage = UIImage(named: "space3.jpg")!
        myImage = UIImageView(image: image)
        myImage?.alpha = 0.45
        myImage?.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        
        self.view.addSubview(myImage!)
        self.view.sendSubviewToBack(myImage!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if getData.dbData != nil{
            return(getData.dbData?.count)!
        }else{
                return 0
            
        }
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? MyDataTableViewCell ?? MyDataTableViewCell(style: .default, reuseIdentifier: "myCell")

        // Configure the cell...

        let row = indexPath.row
        let rowData = (getData.dbData?[row])! as NSDictionary
        
        cell.myLogo.image = UIImage(named: "enterprise2.png")
        cell.myScore.text = rowData["Score"] as? String
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
