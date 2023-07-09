//
//  ViewController.swift
//  MarathonUIKitThirdTask
//
//  Created by Anastasiia Perminova on 08.07.2023.
//

import UIKit

class ViewController: UIViewController {

    lazy var size: CGFloat = 100

    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self, action: #selector(makeSome), for: .valueChanged)
        slider.addTarget(self, action: #selector(autoslide), for: .touchUpInside)
        return slider
    }()

    lazy var square: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 6
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slider)
        view.addSubview(square)
        square.frame = CGRect(x: 0.0, y: 0.0, width: size, height: size)


        slider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        square.frame.origin.y = 190 - slider.frame.height
        square.frame.origin.x = 14
    }

    @objc func makeSome(_ sender: UISlider){
        let valueSlider = CGFloat(sender.value)
        let scalePercent = (1 + (valueSlider / 2))
        let newWidth = size * scalePercent

        let endX = slider.frame.width + view.layoutMargins.left - newWidth / 2
        let startX = (slider.frame.origin.x + newWidth / 2)

        let newViewX = endX * valueSlider + startX * (1 - valueSlider)
        square.center.x = newViewX
        let rotationTransform = CGAffineTransform.init(rotationAngle: CGFloat.pi/2 * valueSlider)
        let scaledTransform = CGAffineTransform.identity.scaledBy(x: scalePercent, y: scalePercent)
        square.transform = CGAffineTransformConcat(rotationTransform, scaledTransform)

    }

    @objc func autoslide(_ sender: UISlider){
        UIView.animate(withDuration: 1) {
            sender.setValue(sender.maximumValue, animated: true)
            sender.sendActions(for: .valueChanged)
        }
    }
}

