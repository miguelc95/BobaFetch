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
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.title = "BobaFetcher Demo App"
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @IBAction func eyeColorAction(_ sender: Any) {
        activityIndicator.startAnimating()
        BobbaFetcher.getEyeColors(search: getSerchText()) { [weak self] eyesRequest in
            switch eyesRequest {
            case .failure(let error):
                self?.displayResponse(message: error.description, title: "Error")
            case .success(let eyes):
                self?.displayResponse(message: eyes.description, title: "Eyes")
            }
        }
    }
    
    @IBAction func planetsAction(_ sender: Any) {
        activityIndicator.startAnimating()
        BobbaFetcher.getPlanets(search: getSerchText(), sample: true) { [weak self] planetsRequest in
            switch planetsRequest {
            case .failure(let error):
                self?.displayResponse(message: error.description, title: "Error")
            case .success(let planets):
                self?.displayResponse(message: planets.description, title: "Planets")
            }
        }
    }
    
    @IBAction func filmsAction(_ sender: Any) {
        activityIndicator.startAnimating()
        BobbaFetcher.getFilms(search: getSerchText()) { [weak self] planetsRequest in
            switch planetsRequest {
            case .failure(let error):
                self?.displayResponse(message: error.description, title: "Error")
            case .success(let films):
                self?.displayResponse(message: films.description, title: "Films")
            }
        }
    }
    
    private func getSerchText() -> String? {
        guard let searchText = searchTxtField.text, searchText != "" else { return nil }
        return searchText
    }
    
    private func displayResponse(message: String, title: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.present(alert, animated: true)
        }
    }
}
