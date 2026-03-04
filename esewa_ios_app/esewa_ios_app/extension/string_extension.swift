//
//  string_extension.swift
//  esewa_ios_app
//
//  Created by Sachhyam Kaji Shakya on 04/03/2026.
//

extension String{
//    checks password requirements for validation
    func isValidPassword() -> Bool {
          guard self.count >= 8 else { return false }
          let hasUpper = self.contains(where: \.isUppercase)
          let hasLower = self.contains(where: \.isLowercase)
          let hasDigit = self.contains(where: \.isNumber)
          let hasSpecial = self.contains(where: { "!@#$%^&*()_+={}[]:\";'|\\<,>.?/-".contains($0) })
          return hasUpper && hasLower && hasDigit && hasSpecial
      }
}
