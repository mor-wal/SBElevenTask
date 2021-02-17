import Foundation

class User {
    private var login: String
    private var password: String
    var error = ""
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    public func validation() -> Bool {
        return self.validationLogin() && self.validationPassword()
    }
    
    private func validationLogin() -> Bool {
        if self.login.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .regularExpression, range: nil, locale: nil) == nil {
            self.error = "Логин должен быть корректной почтой"
            return false
        }
        return true
    }
    
    private func validationPassword() -> Bool {
        if self.password.count < 6 {
            self.error = "Пароль должен быть длиной не менее 6 символов"
            return false
        }
        if self.password.range(of: ".*[0-9]+.*", options: .regularExpression, range: nil, locale: nil) == nil {
            self.error = "Пароль должен содержать минимум одну цифру"
            return false
        }
        if self.password.range(of: ".*[a-z]+.*", options: .regularExpression, range: nil, locale: nil) == nil {
            self.error = "Пароль должен содержать минимум одну букву"
            return false
        }
        if self.password.range(of: ".*[A-Z]+.*", options: .regularExpression, range: nil, locale: nil) == nil {
            self.error = "Пароль должен содержать минимум одну букву в верхнем регистре"
            return false
        }
        return true
    }
}
