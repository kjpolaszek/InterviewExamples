class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.placeholder = "Login"
        loginTextField.delegate = self

        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self

        loginButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let login = loginTextField.text, login.count > 0 {
            if let password = passwordTextField.text, password.count > 0 {
                loginBy(login: login, password: password)
            } else {
                passwordTextField.becomeFirstResponder()
            }
        } else {
            loginButton.becomeFirstResponder()
        }
    }

    @objc func didTapLoginButton(_ sender: UIButton) {
        if let login = loginTextField.text, login.count > 0 {
            if let password = passwordTextField.text, password.count > 0 {
                self.view.endEditing(true)
                loginBy(login: login, password: password)
            } else {
                passwordTextField.becomeFirstResponder()
            }
        } else {
            loginButton.becomeFirstResponder()
        }
    }

    func loginBy(login: String, password: String) {
        loginButton.isEnabled = false
        loginTextField.isEnabled = false
        passwordTextField.isEnabled = false
        autorizationService.login(login, password) { response, error in
            self.loginButton.isEnabled = true
            self.loginTextField.isEnabled = true
            self.passwordTextField.isEnabled = true
            if let error = error {
                let alert = UIAlertController(title: "Login error", message: "Try another login or password", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
