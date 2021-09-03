//
//  DemoViewController.swift
//  BobaFetchDemoApp
//
//  Created by Miguel Cuellar on 02/09/21.
//

import UIKit
import BobaFetch

class DemoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BobaFetch.BobbaFetcher.getEyeColors() { eyes in
            switch eyes {
            case .failure(let error):
                print(error)
            case .success(let eyes):
                print(eyes)
            }
        }
        
    }
    
}
