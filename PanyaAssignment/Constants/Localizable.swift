// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum CreateAccount {
    /// EMAIL :
    internal static let emailTitle = L10n.tr("Localizable", "CreateAccount.EmailTitle")
    /// PASSWORD :
    internal static let passwordTitle = L10n.tr("Localizable", "CreateAccount.PasswordTitle")
    /// REGISTER
    internal static let registerButton = L10n.tr("Localizable", "CreateAccount.RegisterButton")
    /// By register you agree to Panya's Terms of Service and Privacy Policy
    internal static let terms = L10n.tr("Localizable", "CreateAccount.Terms")
    /// Create Account
    internal static let title = L10n.tr("Localizable", "CreateAccount.Title")
  }

  internal enum Global {
    /// OK
    internal static let ok = L10n.tr("Localizable", "Global.OK")
  }

  internal enum RoundStreak {
    /// Receive extra lives! Join the game for\nmore tha 5 consecutive rounds.\nThe more rounds joined, the more hearts given\n(join the game before the first question appears)\nMiss a single round and start over!
    internal static let description = L10n.tr("Localizable", "RoundStreak.Description")
    /// You have consecutively played: %d rounds
    internal static func playRound(_ p1: Int) -> String {
      return L10n.tr("Localizable", "RoundStreak.PlayRound", p1)
    }
    /// ROUND
    internal static let round = L10n.tr("Localizable", "RoundStreak.Round")
    /// ROUND STREAK
    internal static let title = L10n.tr("Localizable", "RoundStreak.Title")
    internal enum Description {
      /// more tha 5 consecutive rounds.
      internal static let hightlight1 = L10n.tr("Localizable", "RoundStreak.Description.Hightlight1")
      /// (join the game before the first question appears)
      internal static let hightlight2 = L10n.tr("Localizable", "RoundStreak.Description.Hightlight2")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
