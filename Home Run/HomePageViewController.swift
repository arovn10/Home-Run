//
//  HomePageViewController.swift
//  Home Run
//
//  Created by Alec Rovner on 11/13/23.
//

import Foundation
import UIKit

class HomePageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // You can customize as needed
        setupUI()
        
        // Additional setup
    }
    private func setupUI() {
        // App Name
            let appNameLabel = UILabel()
            appNameLabel.text = "Home Run"
            appNameLabel.textAlignment = .center
            appNameLabel.font = UIFont.boldSystemFont(ofSize: 24) // Increased font size
            appNameLabel.textColor = UIColor.black // Changed text color for visibility
            view.addSubview(appNameLabel)
            appNameLabel.translatesAutoresizingMaskIntoConstraints = false

            // Slogan
            let sloganLabel = UILabel()
            sloganLabel.text = "Your one-stop destination for student housing!"
            sloganLabel.textAlignment = .center
            sloganLabel.font = UIFont.systemFont(ofSize: 18) // Increased font size
            sloganLabel.textColor = UIColor.black // Changed text color for visibility
            view.addSubview(sloganLabel)
            sloganLabel.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for labels
        // Constraints
            NSLayoutConstraint.activate([
                appNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                sloganLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
                sloganLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

    }
}
