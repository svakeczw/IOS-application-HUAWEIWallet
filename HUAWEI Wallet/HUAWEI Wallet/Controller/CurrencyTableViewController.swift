//
//  CurrencyTableViewController.swift
//  HUAWEI Wallet
//
//  Created by NIUHUIYUN on 2020/5/29.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class CurrencyTableViewController: UITableViewController {
    var currencyRate = CurrencyRate()
    var currencyDictionary = [String:Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyRate.getData()
        self.tableView.reloadData()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
       
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        if let currencyList: [String:Double] = UserDefaults.standard.dictionary(forKey: "currencyDictionary") as? [String : Double] {
        self.currencyDictionary = currencyList
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func refresh(sender:AnyObject)
    {
        // Updating data of tableView
        currencyRate.getData()
        if let currencyList: [String:Double] = UserDefaults.standard.dictionary(forKey: "currencyDictionary") as? [String : Double] {
        self.currencyDictionary = currencyList
        }
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        currencyRate.getData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.currencyDictionary.count
    }
    
    // Set the height of each cell to 100
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100.0
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyListCell", for: indexPath) as! CurrencyTableViewCell
        
        if self.currencyDictionary.count > 0 {
            let currencyDictionarySorted = currencyDictionary.sorted(by: { $0.value < $1.value })
            let curreny = currencyDictionarySorted[indexPath.row]
            cell.currencyType.text = curreny.key
            cell.currencyRate.text = String(format: "%.3f", curreny.value)
             if let img = UIImage(named: (curreny.key + ".image")) {
                cell.currencyImage.image = img
            }
        }
//        self.view.sendSubviewToBack(cell.myView)
//        cell.myView.layer.cornerRadius = cell.myView.frame.height / 2
        cell.currencyImage.layer.cornerRadius = cell.currencyImage.frame.height / 2
        
        return cell
    }
    
    // Add animation foe tableView
    // Reference: https://medium.com/@kannolee/give-tableviewcell-a-cool-animation-b7eb655f9746
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
            }
        }
        
        cell.frame.origin.x = -cell.frame.width
        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            cell.frame.origin.x = 0
        }, completion: nil)
    }
    

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


