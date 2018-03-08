//
//  PageCell.swift
//  vakomsWeatherApp
//
//  Created by Roman Malasnyak on 3/6/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet{
            guard let page = page else { return }
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.cityName, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: color])
            
            attributedText.append(NSAttributedString(string: "\n\nTemperature is \(page.temperature)Kv", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: color]))
            attributedText.append(NSAttributedString(string: "\n\nWind speed is \(page.windSpeed)m p/h", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
            
            //textView.text = page.cityName + "\n\n" + String(page.temperature) + "\n\n" + String(page.windSpeed)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTextField()
        setUpView()
    }
    
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "image.png")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE TEXT FOR NOW"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTextField() {
        addSubview(textView)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setUpView() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true 
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    
    
}
