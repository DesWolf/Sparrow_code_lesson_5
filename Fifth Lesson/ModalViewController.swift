//
//  ModalViewController.swift
//  Fifth Lesson
//
//  Created by Максим Окунеев on 14.07.2023.
//

import UIKit

protocol ModalViewControllerDelegate {
    func segmentChanged(value: Int)
}

class ModalViewController: UIViewController {
    var modalDelegate: ModalViewControllerDelegate?
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl (items: ["280px","150px"])
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
    
        return segmentControl
    }()
    
    lazy var closeButton: UIButton = {
        var button = UIButton(type: .close)
        button.setImage(.init(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        
        return button
    }()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        self.view.addSubview(segmentControl)
        self.view.addSubview(closeButton)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: segmentControl.centerYAnchor, constant: 0),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
           switch (segmentedControl.selectedSegmentIndex) {
           case 0:
               modalDelegate?.segmentChanged(value: 0)
           case 1:
               modalDelegate?.segmentChanged(value: 1)
           default:
               break
           }
       }
    
    @objc func closeButtonTap() {
        self.dismiss(animated: true)
    }
}
