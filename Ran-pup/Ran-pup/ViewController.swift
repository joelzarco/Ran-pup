//
//  ViewController.swift
//  Ran-pup
//  Random dog picture downloaded from dog.ceo API, based on iOS networking with swift
//  Created by Johel Zarco on 06/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    let dogImageView = UIImageView()
    let downloadButton = UIButton(type: .system)
    let stringUrl : String = "https://dog.ceo/api/breeds/image/random"
    
    let margin : CGFloat = 10
    let spacing : CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style(){
        
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        dogImageView.contentMode = .scaleAspectFit
        dogImageView.image = UIImage(named: "wagner")
        dogImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        dogImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
        
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.configuration = .filled()
        downloadButton.configuration?.imagePadding = 8
        downloadButton.setTitle("Download", for: [])

    }
    
    func layout(){
        // dogImageView
        view.addSubview(dogImageView)
        view.addSubview(downloadButton)
        dogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacing).isActive = true
        dogImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: margin).isActive = true
        dogImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin).isActive = true
        //downloadButton
        downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadButton.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: spacing).isActive = true
        downloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing).isActive = true
        downloadButton.addTarget(self, action: #selector(buttonPressed), for: .primaryActionTriggered)
    }
    
    @objc func buttonPressed(sender : UIButton){
        print("button pressed")
        downloadButton.configuration?.showsActivityIndicator = true
    }

}

