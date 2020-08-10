//
//  MainTabBarViewController.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    var startGame = true
    var currencyRate = CurrencyRate()
    var currencyDictionary = [String:Double]()
    
    //life cycle will appear-> second tab
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      currencyRate.getData()
//       UserDefaults.standard.set(currencyDictionary, forKey: "currencyDictionary")

        if startGame == true {
            startGame = false
            self.selectedIndex = 1
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.showSplashView()
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    private func showSplashView() {
        guard UserDefaults.standard.bool(forKey: "introduced") == false ||
                HWAppConfig.isSnapshot else {
                    return
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let splashVC = storyboard.instantiateViewController(
                withIdentifier: "splashController"
                ) as? SplashViewController else {
                return
            }
            if HWAppConfig.isSnapshot {
                //Facade.share.model.addSampleData()
            }
            present(splashVC, animated: false)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


