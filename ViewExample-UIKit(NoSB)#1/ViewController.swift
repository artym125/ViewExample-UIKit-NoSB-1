//
//  ViewController.swift
//  ViewExample-UIKit(NoSB)#1
//
//  Created by Ostap Artym on 27.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Main")
        setCircle()
        setImage()
        setText()
        setVariants()
        setButton()
    }
    
    //MARK: Circles
    private func setCircle() {
        let circle1 = createCircle(frame: CGRect(x: -24, y: -30, width: 100, height: 100))
        let circle2 = createCircle(frame: CGRect(x: view.frame.width-130, y: 100, width: 60, height: 60))
        let circle3 = createCircle(frame: CGRect(x: -60, y: circle2.frame.maxY + 30, width: 260, height: 260))
        let circle4 = createCircle(frame: CGRect(x: view.frame.width - 95, y: circle3.frame.maxY + 40, width: 55, height: 55))
        let circle5 = createCircle(frame: CGRect(x: 55, y: circle4.frame.maxY + 50, width: 95, height: 95))
        let circle6 = createCircle(frame: CGRect(x: view.frame.width - 50, y: circle5.frame.maxY + 100, width: 60, height: 60))
        
        [circle1,circle2,circle3,circle4,circle5,circle6].forEach { item in
            view.addSubview(item)
        }
    }
    
    private func createCircle(frame:CGRect) ->UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor(named: "Circle")
        circle.frame = frame
        circle.layer.cornerRadius = frame.width/2
        return circle
    }
    
    //MARK: Image
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ImageOne")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        // Size
        image.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        image.widthAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        return image
    }()
    
    private func setImage(){
        view.addSubview(image)
        // Constraint
        image.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: Label
    
    private func createLabel(size: CGFloat, weight: UIFont.Weight, text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        return label
    }
    //Stack with text
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private func setText(){
        view.addSubview(textStack)
        let pageTitle = createLabel(size: 30, weight: .bold, text: "Додаток та всі його функції безкоштовні")
        let pageSubtitle = createLabel(size: 17, weight: .regular, text: "Всі кошти йдуть на покращення та підтримку проекта")
        
        textStack.addArrangedSubview(pageTitle)
        textStack.addArrangedSubview(pageSubtitle)
        
        NSLayoutConstraint.activate([
            textStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    //MARK: Bottom Stack of 3 view
    private func createPayVariant(variant: PayVariants) -> UIView {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVariants(sender: )))
        
        let payView = UIView()
        payView.translatesAutoresizingMaskIntoConstraints = false
        payView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        payView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        payView.layer.cornerRadius = 20
        payView.tag = variant.rawValue
        payView.addGestureRecognizer(tapGesture)
        
        switch variant {
        case .small:
            payView.backgroundColor = UIColor(named: "FirstColor")
            payView.layer.borderWidth = 2
            payView.layer.borderColor = UIColor.white.cgColor
        case .medium:
            payView.backgroundColor = UIColor(named: "SecondColor")
            
        case .big:
            payView.backgroundColor = UIColor(named: "ThirdColor")
        }
        
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.alignment = .center
        
        let summLabel = createLabel(size: 31, weight: .bold, text: "\(variant.rawValue)")
        let summDiscription = createLabel(size: 15, weight: .light, text: "гривень")
        
        vStack.addArrangedSubview(summLabel)
        vStack.addArrangedSubview(summDiscription)
        
        payView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: payView.topAnchor, constant: 20),
            vStack.bottomAnchor.constraint(equalTo: payView.bottomAnchor, constant:-23),
            vStack.leadingAnchor.constraint(equalTo: payView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: payView.trailingAnchor, constant: -10)
        ])
        return payView
    }
    
    private func setVariants() {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 0
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hStack)
        PayVariants.allCases.forEach { item in
            hStack.addArrangedSubview(createPayVariant(variant: item))
        }
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 60),
            hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func selectVariants(sender: UIGestureRecognizer) {
        PayVariants.allCases.forEach { variant in
            if let sView = self.view.viewWithTag(variant.rawValue) {
                sView.layer.borderWidth = 0
                sView.layer.borderColor = .none
            }
            
            if let selectTag = sender.view?.tag {
                if let selectedView = self.view.viewWithTag(selectTag) {
                    selectedView.layer.borderWidth = 2
                    selectedView.layer.borderColor = UIColor.white.cgColor
                    self.selectPrice = selectTag
                }
            }
                
        }
    }
    
    private lazy var selectPrice = 250
    
    //MARK: Button
    
    private lazy var payButton: UIButton = {
       let button = UIButton(primaryAction: payButtonAction)
        button.setTitle("Підтримати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
    }()
    
    private lazy var payButtonAction = UIAction { _ in
        print(self.selectPrice)
    }
    
    private func setButton() {
        view.addSubview(payButton)
        payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

}

enum PayVariants: Int, CaseIterable  {
    case small = 250
    case medium = 500
    case big = 1000
}

#Preview {
    ViewController()
}
