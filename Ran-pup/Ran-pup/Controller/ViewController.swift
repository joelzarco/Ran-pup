//
//  ViewController.swift
//  Ran-pup
//  Random dog picture downloaded from dog.ceo API, based on iOS networking with swift Udacity's Course
//  Created by Johel Zarco on 06/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    let titleLabel = UILabel()
    let dogImageView = UIImageView()
    let downloadButton = UIButton(type: .system)
    //let stringUrl : String = "https://dog.ceo/api/breeds/image/random"
    
    let margin : CGFloat = 10
    let spacing : CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    func style(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Random Pup!"
        titleLabel.textColor = .white
        
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
        
        view.addSubview(dogImageView)
        view.addSubview(downloadButton)
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin).isActive = true
        // dogImageView
        dogImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2*margin).isActive = true
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
        dataRequestWithCodable()
    }
    
    func dataRequestWithCodable(){
        
        let imageURL : URL = DogAPI.parseDogUrl(url: DogAPI.stringUrl)
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do{
                let imageData = try decoder.decode(DogImage.self, from: data)
                //print(imageData.message)
                // response loooks like:
                // DogImage(status: "success", message: "https://images.dog.ceo/breeds/doberman/n02107142_12182.jpg")
                // response is parsed directly into our defined model!!!
                let messageURL : String = imageData.message
                print(messageURL)
                self.downloadImage(responseURL: messageURL)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func downloadImage(responseURL : String){
        let imageURL : URL =  DogAPI.parseDogUrl(url: responseURL)
        let task = URLSession.shared.downloadTask(with: imageURL) { location, response, error in
            guard let location = location else {
                print("location is nill")
                return
            }
            let imageData = try! Data(contentsOf: location)
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.dogImageView.image = image
                self.downloadButton.configuration?.showsActivityIndicator = false
            }
        }
        task.resume()
    }

}

