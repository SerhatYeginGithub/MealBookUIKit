//
//  Controller+Ext.swift
//  MealBookUIKit
//
//  Created by serhat on 4.10.2024.
//

import UIKit

import UIKit

extension UIViewController {
    private var activityIndicator: UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }
    
    func showActivity() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            
            // Eğer zaten bir gösterge varsa, onu yeniden kullanıyoruz
            if self.view.subviews.contains(where: { $0 is UIActivityIndicatorView }) {
                return
            }
            
            let indicator = self.activityIndicator
            self.view.addSubview(indicator)
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            indicator.startAnimating()
        }
    }
    
    func removeActivity() {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            
            if let indicator = self.view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
