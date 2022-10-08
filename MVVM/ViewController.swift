//
//  ViewController.swift
//  MVVM
//
//  Created by Артем Галай on 4.10.22.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: GreetingViewModelProtocol! {
        didSet {
            viewModel.greetingDidChange = { [unowned self]  viewModel in
                self.nameLabel.text = viewModel.greeting
            }
        }
    }

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var myButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.setTitle("Press", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let person = Person(name: "Tim", surname: "Cook")
        viewModel = GreetingViewModel(person: person )
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(myButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            myButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func buttonTapped() {
        viewModel.showGreeting()
    }
}
