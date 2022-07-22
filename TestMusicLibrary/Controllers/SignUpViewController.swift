//
//  SignUpViewController.swift
//  TestMusicLibrary
//
//  Created by Panchenko Oleg on 07.07.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First Name"
        return textField
    }()
   
    private let firstNameValidLabel = RequiredValidLabel()
    
    private let secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second Name"
        return textField
    }()
    
    private let secondNameValidLabel = RequiredValidLabel()
    private let ageValidLabel = RequiredValidLabel()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let phoneValidLabel = RequiredValidLabel()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        return textField
    }()
    
    private let emailValidLabel = RequiredValidLabel()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        return textField
    }()

    private let passwordValidLabel = RequiredValidLabel()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var topStackView = UIStackView()
    private var bottomStackView = UIStackView()
    private let datePicker = UIDatePicker()
    
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
        
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupDelegate()
        setupDatePicker()
        setConstraints()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        title = "Sign Up"
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        topStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                      firstNameValidLabel,
                                                      secondNameTextField,
                                                      secondNameValidLabel],
                                        axis: .vertical,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        bottomStackView = UIStackView(arrangedSubviews: [ageValidLabel,
                                                         phoneNumberTextField,
                                                         phoneValidLabel,
                                                         emailTextField,
                                                         emailValidLabel,
                                                         passwordTextField,
                                                         passwordValidLabel],
                                      axis: .vertical,
                                      spacing: 10,
                                      distribution: .fillProportionally)
        
        backgroundView.addSubview(topStackView)
        backgroundView.addSubview(datePicker)
        backgroundView.addSubview(bottomStackView)
        backgroundView.addSubview(registrationLabel)
        backgroundView.addSubview(signUpButton)
    }
    
    private func setupDelegate() {
        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = UIColor.systemBackground.cgColor
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    //MARK: - SignUpButtonTapped
    @objc private func signUpButtonTapped() {
        
        let firstNameText = firstNameTextField.text ?? ""
        let secondNameText = secondNameTextField.text ?? ""
        let phoneText = phoneNumberTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        
        
        if firstNameText.isValid(validType: nameValidType)
            && secondNameText.isValid(validType: nameValidType)
            && emailText.isValid(validType: emailValidType)
            && passwordText.isValid(validType: passwordValidType)
            && phoneText.count == 18
            && ageIsValid() == true {
            
            DataBase.shared.saveUser(firstName: firstNameText,
                                     secondName: secondNameText,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText,
                                     age: datePicker.date)
            registrationLabel.text = "Registration complete"
        } else {
            registrationLabel.text = "Registration"
            alert(title: "Error", message: "Fill in all the fields and \nyour age must be 18+")
        }
    }
    
//MARK: - SetTextField
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.7749049067, green: 0, blue: 0.006918687373, alpha: 1)
        }
    }
    
    //MARK: - Format Number
    private func formatPhoneNumber(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber,options: [], range: range, withTemplate: "")
        
        let maxNumberCount = 11
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        
        if number.count == 17 {
            phoneValidLabel.text = "Phone is valid"
            phoneValidLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            phoneValidLabel.text = "Phone is not valid"
            phoneValidLabel.textColor = #colorLiteral(red: 0.7749049067, green: 0, blue: 0.006918687373, alpha: 1)
        }
        
        return "+" + number
    }
    
    
    //MARK: - Age Validation
    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)
    }
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let fullString = (textField.text ?? "") + string
        
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameValidLabel,
                                              validType: nameValidType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z characters, min 1 character",
                                              string: string,
                                              range: range)
        case secondNameTextField: setTextField(textField: secondNameTextField,
                                              label: secondNameValidLabel,
                                              validType: nameValidType,
                                              validMessage: "Second Name is valid",
                                              wrongMessage: "Only A-Z characters, min 1 character",
                                              string: string,
                                              range: range)
        case emailTextField: setTextField(textField: emailTextField,
                                              label: emailValidLabel,
                                              validType: emailValidType,
                                              validMessage: "Email is valid",
                                              wrongMessage: "Email is not valid",
                                              string: string,
                                              range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                              label: passwordValidLabel,
                                              validType: passwordValidType,
                                              validMessage: "Password is valid",
                                              wrongMessage: "Password is not valid.",
                                              string: string,
                                              range: range)
        case phoneNumberTextField: phoneNumberTextField.text = formatPhoneNumber(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        default:
            break
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Notification Keyboard Show/Hide
extension SignUpViewController {
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height / 2)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}

//MARK: - Set Constraints
extension SignUpViewController {
    
    private func setConstraints() {
        
        scrollView.pinToSuperview()
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            topStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 200)
            ])
        
        NSLayoutConstraint.activate([
            registrationLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            registrationLabel.bottomAnchor.constraint(equalTo: topStackView.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            datePicker.widthAnchor.constraint(equalToConstant: 100),
            datePicker.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            bottomStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 30),
            signUpButton.widthAnchor.constraint(equalToConstant: 300),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
