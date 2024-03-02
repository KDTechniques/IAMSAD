//
//  CrashlyticsManager.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

//import FirebaseCrashlytics
//import RevenueCat
//
//struct CrashlyticsManager {
//    // MARK: - FUNCTIONS
//    
//    // MARK: - initializeCrashlytics
//    /// This function is intended to be called when the app lock status changes and on app startup.
//    static func setUserProperties() async {
//        let customerInfo: CustomerInfo? = try? await Purchases
//            .shared
//            .customerInfo()
//        
//        Crashlytics.crashlytics().setUserID(customerInfo?.originalAppUserId ?? "No_Subscription_UserID/Nil")
//        
//        await Crashlytics.crashlytics().setCustomValue(
//            ContentViewModel.shared.appLockStatus.rawValue,
//            forKey: "app_lock_status"
//        )
//        
//        Crashlytics.crashlytics().setCustomValue(
//            customerInfo,
//            forKey: "revenueCat_customerInfo_object"
//        )
//    }
//    
//    // MARK: - sendNonFatalError
//    /// This function can be used for `guard let` statements before the early exit.
//    static func sendNonFatalError(_ fatalError: String) {
//        Crashlytics.crashlytics().log(fatalError)
//        Crashlytics.crashlytics().record(error: URLError.init(.unknown))
//    }
//}
