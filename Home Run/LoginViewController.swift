import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let userTypePicker = UIPickerView()
    let goButton = UIButton(type: .system)
    let userTypes = ["Student", "Landlord", "Manager", "Admin"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        // User Type Picker
        userTypePicker.delegate = self
        userTypePicker.dataSource = self
        userTypePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTypePicker)

        // Go Button
        goButton.setTitle("Go", for: .normal)
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goButton)

        // Layout Constraints
        NSLayoutConstraint.activate([
            userTypePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userTypePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goButton.topAnchor.constraint(equalTo: userTypePicker.bottomAnchor, constant: 20),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func goButtonTapped() {
        let selectedUserTypeIndex = userTypePicker.selectedRow(inComponent: 0)
        let selectedUserType = userTypes[selectedUserTypeIndex]

        // Logic to navigate to specific login page based on selected user type
        navigateToLoginPage(forUserType: selectedUserType)
    }

    private func navigateToLoginPage(forUserType userType: String) {
        let viewController: UIViewController
        switch userType {
        case "Student":
            viewController = StudentLoginViewController()
        case "Landlord":
            viewController = LandlordLoginViewController()
        case "Manager":
            viewController = ManagerLoginViewController()
        case "Admin":
            viewController = AdminLoginViewController()
        default:
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }


    // UIPickerViewDataSource and UIPickerViewDelegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row]
    }
}
