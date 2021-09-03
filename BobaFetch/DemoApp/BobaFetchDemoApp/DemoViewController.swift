//
//  DemoViewController.swift
//  BobaFetchDemoApp
//
//  Created by Miguel Cuellar on 02/09/21.
//

import UIKit
import BobaFetch

class DemoViewController: UIViewController {
    
    @IBOutlet weak var searchTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BobaFetcher Demo App"
    }
    
    @IBAction func eyeColorAction(_ sender: Any) {
        BobaFetch.BobbaFetcher.getEyeColors(search: getSerchText()) { [weak self] eyesRequest in
            switch eyesRequest {
            case .failure(let error):
                print(error)
            case .success(let eyes):
                print(eyes)
                self?.displayResponse(message: eyes.description, title: "Eyes")
            }
        }
    }
    
    @IBAction func planetsAction(_ sender: Any) {
        BobaFetch.BobbaFetcher.getPlanets(search: getSerchText()) { [weak self] planetsRequest in
            switch planetsRequest {
            case .failure(let error):
                print(error)
            case .success(let planets):
                self?.displayResponse(message: planets.description, title: "Planets")
            }
        }
    }
    
    @IBAction func filmsAction(_ sender: Any) {
        
    }
    
    private func getSerchText() -> String? {
        guard let searchText = searchTxtField.text, searchText != "" else { return nil }
        return searchText
    }
    
    private func displayResponse(message: String, title: String = "") {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
