//
//  ViewController.swift
//  Fifth Lesson
//
//  Created by Максим Окунеев on 14.07.2023.
//

import UIKit

//- Контроллер открывается не на весь экран. Ширина всегда 300pt.
//- По умолчанию выбран первый пункт с высотой 280pt. Если выбрать второй пункт - высота станет 150pt. Высота меняется анимировано.
//- Кнопка закрыть в правом верхнем углу закрывает контроллер.
//- Контроллер сверху привязан к центру кнопки треугольничком (см. видео).

class ViewController: UIViewController {
    
    lazy var presentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Present", for: .normal)
        button.addTarget(self, action: #selector(presentButtonTap), for: .touchUpInside)
        return button
    }()
    
    
    lazy var modalVC: ModalViewController = {
        let modalVC = ModalViewController()
        modalVC.modalPresentationStyle = .popover
        modalVC.preferredContentSize = CGSize(width: 300, height: 280)
        modalVC.modalDelegate = self
        
        return modalVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.addSubview(presentButton)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func presentButtonTap() {
        setupPopover()
        self.present(modalVC, animated: true, completion: nil)
    }
    
    func setupPopover() {
        let rect = CGRect(
            origin: CGPoint(x: self.view.frame.width / 2, y: self.presentButton.frame.maxY),
            size: CGSize(width: 1, height: 1)
        )
        let popOver = modalVC.popoverPresentationController
        
        popOver?.delegate = self
        popOver?.permittedArrowDirections = .up
        popOver?.sourceView = self.view
        
        popOver?.sourceRect = rect
    }
    
    func changePopOverHeight(segment: Int) {
        switch segment {
        case 0:
            modalVC.preferredContentSize = CGSize(width: 300, height: 280)
        default:
            modalVC.preferredContentSize = CGSize(width: 300, height: 150)
        }
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
    for controller: UIPresentationController,
        traitCollection: UITraitCollection)
        -> UIModalPresentationStyle {
            return .none
    }

}

extension ViewController: ModalViewControllerDelegate {
    func segmentChanged(value: Int) {
        changePopOverHeight(segment: value)
    }
}
