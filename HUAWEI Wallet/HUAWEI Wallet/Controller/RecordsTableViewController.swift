//
//  RecordsTableViewController.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class RecordsTableViewController: UITableViewController {
    
    //var recordList = [Record]()
    var model: AddRecordModel = Facade.share.model.addRecordModel
    let style: Style = Style.myApp
    var coverImageView = UIImageView()
    var sectionNumber:Int = 1
    var sectionArray : [Int] = [Int]()
    //var recordSection = [[Record]()]
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return style.preferredStatusBarStyle
    }
    
    @IBAction func addButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test data
//        recordSave(Id: 1, Name: "test-record-1", Money: 100, Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 2, Name: "test-record-2", Money: 150, Currency: currency_2, Date: Date(), Direction: 0)
//        recordSave(Id: 3, Name: "test-record-3", Money: 200, Currency: currency_3, Date: Date(), Direction: 1)
//        recordSave(Id: 4, Name: "test-record-4", Money: 250, Currency: currency_3, Date: Date(), Direction: 0)
        
//        recordSave(Id: 5, Name: "test-record-5", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_3, Date: Date(), Direction: 1)
//        recordSave(Id: 6, Name: "test-record-6", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_3, Date: Date(), Direction: 1)
//        recordSave(Id: 7, Name: "test-record-7", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_3, Date: Date(), Direction: 1)
//        recordSave(Id: 8, Name: "test-record-8", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_3, Date: Date(), Direction: 1)
//        recordSave(Id: 9, Name: "test-record-9", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_3, Date: Date(), Direction: 1)
//        recordSave(Id: 10, Name: "test-record-10", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_2, Date: Date(), Direction: 1)
//        recordSave(Id: 11, Name: "test-record-11", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_2, Date: Date(), Direction: 1)
//        recordSave(Id: 12, Name: "test-record-12", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_2, Date: Date(), Direction: 1)
//        recordSave(Id: 13, Name: "test-record-13", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_2, Date: Date(), Direction: 1)
//        recordSave(Id: 14, Name: "test-record-13", Money: Double(arc4random_uniform(UInt32(900))+100), Currency: currency_2, Date: Date(), Direction: 1)
//        recordSave(Id: 15, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 16, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 17, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 18, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 19, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 20, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 1)
//        recordSave(Id: 21, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 0)
//        recordSave(Id: 22, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 0)
//        recordSave(Id: 23, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 0)
//        recordSave(Id: 24, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 0)
//        recordSave(Id: 25, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_1, Date: Date(), Direction: 0)
//        recordSave(Id: 26, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_2, Date: Date(), Direction: 0)
//        recordSave(Id: 27, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_2, Date: Date(), Direction: 0)
//        recordSave(Id: 28, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_2, Date: Date(), Direction: 0)
//        recordSave(Id: 29, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_2, Date: Date(), Direction: 0)
//        recordSave(Id: 30, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_2, Date: Date(), Direction: 0)
//        recordSave(Id: 31, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_3, Date: Date(), Direction: 0)
//        recordSave(Id: 32, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_3, Date: Date(), Direction: 0)
//        recordSave(Id: 33, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_3, Date: Date(), Direction: 0)
//        recordSave(Id: 34, Name: "test-record-14", Money: Double(arc4random_uniform(UInt32(900))+100) , Currency: currency_3, Date: Date(), Direction: 0)
        
        tableView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        recordRetrieve()
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        // MARK: 报错请注释
        sectionUpdate()
       
        
        tableView.reloadData()
    }
    
    // MARK: test function ( real function please code in Model )
    func recordSave(Id: Int, Name: String, Money: Double, Currency: Currency, Date: Date, Direction: Int) {
        
        let recordTesting = Record(id: Id, name: Name, money: Money, currency: Currency, date: Date, direction: Direction)
        model.recordList.append(recordTesting)
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(recordTesting, forKey: "recordSave\(recordTesting.id)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //record和US存储的不一样!!
    func recordRetrieve()  {
        let userDefaults = UserDefaults.standard
        var i = 0
       
        while i < model.recordList.count{
        do {
            _ = try userDefaults.getObject(forKey: "recordSave\(i+1)", castTo: Record.self)
            //print(recordRead)
           
        } catch {
            print(error.localizedDescription)
         
        }
            i += 1
        }
        
            
            
        
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNumber
        //return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionArray == [] {
            return 0
        }
        else {
            return sectionArray[section]
        }
        //return model.recordList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return Date().dayRepresentation()
        default:
            return Date().dayRepresentation()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = HWRecordHeaderView()
        if model.recordList.count > 0{
            headerView.newsetup(with: HWRecordHeaderViewModel(title: model.recordSection[section][0].date.dayRepresentation(), spending: ""))
//        headerView.setup(with: HWRecordHeaderViewModel(
//            title: recordSection[section][0].date.dayRepresentation() ,
//            spending: recordSection[section][0].money.recordPresenter(
////                for: model.recordList[section].direction,
//                for: recordSection[section][0].direction,
//                formatting: false, currency: recordSection[section][0].currency
//        ))
//            )
//        return headerView
            return headerView
        }
        else{
            return nil
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordTableViewCell else {
            assertionFailure("Cell not found: RecordTableViewCell")
            return UITableViewCell()
        }
        
        //var record = model.recordList[indexPath.row]
        let record = model.recordSection[indexPath.section][indexPath.row]
        if record.direction == 1 {
            cell.amountLabel.textColor = UIColor.myAppGreen
            cell.amountLabel.text = record.money.recordPresenter(for: record.direction, formatting: false, currency: record.currency)
        } else {
            cell.amountLabel.textColor = UIColor.myAppBlack
            cell.amountLabel.text = record.money.recordPresenter(for: record.direction, formatting: false, currency: record.currency)
        }
        cell.icon.image = UIImage(systemName: "\(record.currency.icon)")
        cell.titleLabel.text = record.name
        

        // Configure the cell...

        return cell
    }
    
    // delete record
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //model.recordList.remove(at: indexPath.row)
            
            let index = model.recordListSorted.firstIndex(where: {$0.id == model.recordSection[indexPath.section][indexPath.row].id})
            let inde = model.recordList.firstIndex(where: {$0.id == model.recordSection[indexPath.section][indexPath.row].id})
            model.recordListSorted.remove(at: index!)
            model.recordList.remove(at: inde!)
//            model.recordList.remove(at: model.recordSection[indexPath.section][indexPath.row].id-1)
            model.recordSection[indexPath.section].remove(at:indexPath.row)
            sectionUpdate()
            tableView.reloadData()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = model.recordSection[indexPath.section][indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DisplayRecord") as! DisplayRecordViewController
        let index = model.recordListSorted.firstIndex(where: {$0.id == record.id})
        controller.currentUid = String(index! + 1)
        navigationController?.pushViewController(controller, animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddRecordViewController" {
            let vc = segue.destination as! AddRecordViewController
            vc.recordNumber = model.recordList.count
            
        }
    }
    
    //第一次登陆
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if model.recordList.count == 0 {
            let coverImage = UIImage(named: "AddFirstRecord")!
            coverImageView.image = coverImage
            coverImageView.contentMode = .scaleAspectFit
            coverImageView.frame = CGRect(x: 20, y: 5, width: tableView.frame.width-20, height: 300)
            view.addSubview(coverImageView)

        } else {
            DispatchQueue.main.async {
                self.coverImageView.removeFromSuperview()
            }
        }
    }
    
    func sectionUpdate() {
        model.recordListSorted = model.recordList.sorted(by:
            {$0.date < $1.date}
        )
        model.recordSection=[]
        var i = 1
               sectionNumber = 1
               sectionArray.removeAll()
               guard model.recordList.count > 0 else { return }
               sectionArray.append(1)
               if model.recordList.count > 1{
                   while i < model.recordList.count {
                       if model.recordListSorted[i].date.dayRepresentation() == model.recordListSorted[i-1].date.dayRepresentation() {
                           //print(sectionArray)
                           sectionArray[sectionArray.count-1] += 1
                       } else {
                           sectionNumber += 1
                           sectionArray.append(1)
                       }
                       i += 1
                   }
               }
//        print(sectionArray)
//        print(sectionNumber)
//        print(model.recordSection.count)
//        print(model.recordList.count)
        var j = 0
        var recordNo = 0
//        for _ in 0...sectionNumber {
//            var row = [Record]()
//        }
//        recordSection.append(row)
        while j < sectionNumber {
            var k = 0
            
            var row = [Record]()
            while k < sectionArray[j] {
                row.append(model.recordListSorted[recordNo])
                recordNo += 1
                k += 1
                
            }
            model.recordSection.append(row)
            j += 1
        }
//        print(model.recordSection)
//        print(model.recordSection.count)
//        print(model.recordListSorted)
        
    }
    
    

  

}
