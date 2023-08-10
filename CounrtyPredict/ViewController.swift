//
//  ViewController.swift
//  CounrtyPredict
//
//  Created by Olzhas Zhakan on 10.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let myButton: UIButton = {
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.clipsToBounds = true
        return button
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.text = "покажется здесь"
        label.numberOfLines = 0
        return label
    }()
    
    let myText: UITextField = {
        let text = UITextField()
        text.placeholder = "Name"
        text.borderStyle = .line
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myButton)
        view.addSubview(myLabel)
        view.addSubview(myText)
        
        myText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(400)
            $0.left.right.equalToSuperview().inset(25)
        }
        myLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.left.right.equalToSuperview().inset(25)
        }
        myButton.snp.makeConstraints {
            $0.top.equalTo(myText).offset(100)
            $0.left.right.equalToSuperview().inset(25)
        }
        
    }
    
    @objc func buttonTapped() {
        guard let name = myText.text else { return }
        guard let url = URL(string: "https://api.nationalize.io/?name=\(name)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in
            if let data = data {
                let decoder = JSONDecoder()
                if let decoderData = try? decoder.decode(Welcome.self, from: data) {
                    DispatchQueue.main.async {
                        self.myLabel.text = "Name: \(decoderData.name), counrty: \(decoderData.country[0].countryID)"
                    }
                }
            }
        }
           task.resume()
    }
}


