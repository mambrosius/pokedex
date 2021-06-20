//
//  UIViewExtension.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 19/06/2021.
//

import UIKit

enum ConstraintType {
    case top(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case bottom(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case leading(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case trailing(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerX(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case centerY(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case height(anchor: NSLayoutDimension? = nil, constant: CGFloat = 0)
    case width(anchor: NSLayoutDimension? = nil, constant: CGFloat = 0)
}

extension UIView {
    
    @discardableResult
    func setConstraints(_ constraintTypes: [ConstraintType]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraintTypes.forEach { constraintType in
            let constraint: NSLayoutConstraint
            
            switch constraintType {
            case .top(anchor: let anchor, constant: let constant):
                constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
            case .bottom(anchor: let anchor, constant: let constant):
                constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
            case .leading(anchor: let anchor, constant: let constant):
                constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
            case .trailing(anchor: let anchor, constant: let constant):
                constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
            case .centerX(anchor: let anchor, constant: let constant):
                constraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
            case .centerY(anchor: let anchor, constant: let constant):
                constraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
            case .height(anchor: let anchor, constant: let constant):
                if let anchor = anchor {
                    constraint = heightAnchor.constraint(equalTo: anchor, constant: constant)
                } else {
                    constraint = heightAnchor.constraint(equalToConstant: constant)
                }
            case .width(anchor: let anchor, constant: let constant):
                if let anchor = anchor {
                    constraint = widthAnchor.constraint(equalTo: anchor, constant: constant)
                } else {
                    constraint = widthAnchor.constraint(equalToConstant: constant)
                }
            }
            
            constraint.isActive = true
            constraints.append(constraint)
        }
        
        return constraints
    }
    
    func addDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5
    }
}
