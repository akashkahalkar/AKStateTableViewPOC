//
//  StateTableView.swift
//  StateTableViewPOC
//
//  Created by Akash kahalkar on 26/11/18.
//  Copyright © 2018 Akashka. All rights reserved.
//

import UIKit

public enum TableViewStates {
    case dataAvailable
    case with(image: String?, title: String, buttonTitle: String, action: ()->Void)
    case unknown
}

public class StateTableView: UITableView {
    
    var actionButton = UIButton()
    var buttonAction: (() -> Void)?
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var mainStackView = UIStackView()
    let limeColor = UIColor(red: 0.40, green: 0.60, blue: 0.20, alpha: 1.0)
    
    var currentState: TableViewStates = .unknown
    
    public func setState(state: TableViewStates) {
        self.currentState = state
        
        reloadData()
        
        switch state {
            
        case .dataAvailable:
            setupForData()
        case .with(let image, let title, let buttonTitle, let action):
            setupWith(image: image, title: title, buttonTitle: buttonTitle, action: action)
        case .unknown:
            ()
        }
    }
    
    func setupForData() {
        backgroundColor = UIColor.white
        isScrollEnabled = true
        mainStackView.isHidden = true
    }
    
    /// setup tableview state with given elements
    ///
    /// - Parameters:
    ///   - image: optional image name
    ///   - title: description title
    ///   - buttonTitle: optional title description
    ///   - action: action for button
    
    fileprivate func setupWith(image: String?, title: String?, buttonTitle: String, action: @escaping ()->Void) {
    
        isScrollEnabled = false
        setupStack()
        setupImage(imageName: image)
        setupTitle(title: title)
        setupButton(buttonTitle: buttonTitle, action: action)
    }
    
    fileprivate func setupStack() {
        
        mainStackView.spacing = 5.0
        mainStackView.isHidden = false
        mainStackView.axis  = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution  = .equalSpacing
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.widthAnchor.constraint(equalToConstant: self.frame.width - 20)
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    fileprivate func setupImage(imageName: String?) {
        
        if let imgName = imageName, let image = UIImage(named: imgName) {
            
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = limeColor.withAlphaComponent(0.5)
            //add image to main stack
            mainStackView.addArrangedSubview(imageView)
        }
    }
    
    fileprivate func setupButton(buttonTitle: String?, action: @escaping ()->Void) {
        
        if let buttonTitle = buttonTitle {
            
            buttonAction = action
            actionButton.layer.borderWidth = 1.0
            actionButton.layer.cornerRadius = 5.0
            actionButton.setTitle(buttonTitle, for: .normal)
            actionButton.setTitleColor(limeColor, for: .normal)
            actionButton.layer.borderColor = limeColor  .cgColor
            actionButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
            actionButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
            //autolayout contraints
            actionButton.translatesAutoresizingMaskIntoConstraints = false
            actionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0).isActive = true
            //add action button to main stack
            mainStackView.addArrangedSubview(actionButton)
        }
    }
    
    @objc func buttonTapped( _ sender: UIButton) {
        
        guard let action = self.buttonAction else {
            print("Action not Found")
            return
        }
        action()
    }

    fileprivate func setupTitle(title: String?) {
        
        if let title = title {
            
            titleLabel.text = title
            titleLabel.textColor = UIColor.gray.withAlphaComponent(0.8)
            //autolayout contraints
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50.0).isActive = true
            //add title label to main stack
            mainStackView.addArrangedSubview(titleLabel)
        }
    }
}

