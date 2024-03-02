//
//  AnalyticsManager.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-01-08.
//

//import FirebaseAnalytics
//import RevenueCat
//
//struct AnalyticsManager {
//    //MARK: - FUNCTIONS
//    
//    // MARK: - initializeAnalytics
//    /// This function is intended to be called when the app lock status changes and on app startup.
//    static func setUserProperties() async {
//        let customerInfo: CustomerInfo? = try? await Purchases
//            .shared
//            .customerInfo()
//
//        Analytics.setUserID(customerInfo?.originalAppUserId ?? "No_Subscription_UserID/Nil")
//        
//        await Analytics.setUserProperty(
//            ContentViewModel.shared.appLockStatus.rawValue,
//            forName: "app_lock_status"
//        )
//        
//        Analytics.setUserProperty(
//            customerInfo?.description,
//            forName: "revenueCat_customerInfo_object"
//        )
//    }
//    
//    // MARK: - logEvent
//    /// This function gets called multiple times to log almost every single user interaction event.
//    /// When analyzing the analytics logs, we can truly understand the user's behavior.
//    /// We don't create custom logs with just a string whenever we want.
//    /// Instead, we have a log catalog for each event in the `LogEventTypes` enum, and we choose the appropriate one when needed.
//    static func logEvent(event: LogEventTypes, params: [String: Any]? = nil) {
//        Analytics.logEvent(event.rawValue, parameters: params)
//    }
//    
//    // MARK: - logRecommendedEvent
//    /// This function is only used to log recommended events by Firebase.
//    static func logRecommendedEvent(event: String, params: [String: Any]? = nil) {
//        Analytics.logEvent(event, parameters: params)
//    }
//    
//    // MARK: - handleAnalytics
//    static func handleAnalytics(_ isOn: Bool) {
//        Analytics.setAnalyticsCollectionEnabled(isOn)
//        print("Analytics: \(isOn ? "Enabled ✅" : "Disabled ❎")")
//    }
//}
