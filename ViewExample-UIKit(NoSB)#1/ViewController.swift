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
    }
    //MARK: Circles
    private func setCircle() {
        let circle1 = createCircle(frame: CGRect(x: -24, y: -30, width: 100, height: 100))
        let circle2 = createCircle(frame: CGRect(x: view.frame.width-130, y: 100, width: 60, height: 60))
        let circle3 = createCircle(frame: CGRect(x: -60, y: circle2.frame.maxY - 5, width: 260, height: 260))
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


}

#Preview {
    ViewController()
}
