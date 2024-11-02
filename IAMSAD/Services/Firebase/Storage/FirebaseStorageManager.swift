//
//  FirebaseStorageManager.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-11-02.
//

import Foundation
import FirebaseStorage

/// Manages Firebase Storage interactions.
actor FirebaseStorageManager {
    // MARK: - PROPERTIES
    
    /// The type of bucket being used (production or mock testing).
    let bucket: BucketTypes
    
    /// Reference to the Firebase storage service.
    /// It uses the bucket name URL to initialize the storage.
    lazy var storage: Storage = .storage(url: bucket.nameURL)
    
    /// Reference to the root of the storage service.
    lazy var storageRef: StorageReference = storage.reference()
    
    // MARK: - INITIALIZER
    
    /// Initializes a new instance of `FirebaseStorageManager` with the specified bucket type.
    ///
    /// - Parameter bucket: The type of bucket to use (production or mock testing).
    init(bucket: BucketTypes) {
        self.bucket = bucket
    }
    
    // MARK: FUNCTIONS
    
    // MARK: - getFullReference
    
    /// Gets the full reference to a specific folder in the Firebase storage.
    ///
    /// - Parameter reference: The folder reference within the bucket.
    /// - Returns: A `StorageReference` pointing to the full path of the specified folder.
    func getFullReference(to reference: BucketFolderReferences) async -> StorageReference {
        return reference.fullReference(storageRef: storageRef)
    }
    
    // MARK: - getFullReferenceURL
    /// Gets the download URL for a specific folder in the Firebase storage.
    ///
    /// This function retrieves the full storage reference to the specified folder and then fetches its download URL.
    ///
    /// - Parameter reference: The folder reference within the bucket.
    /// - Returns: A `URL` pointing to the download location of the specified folder.
    /// - Throws: An error if the URL could not be retrieved.
    func getFullReferenceURL(to reference: BucketFolderReferences) async throws -> URL {
        try await getFullReference(to: reference).downloadURL()
    }
    
}

/// Represents the different folder references within a Firebase storage bucket.
enum BucketFolderReferences: String {
    // Resources
    case resources = "Resources"
    case avatarIcons = "Avatar Icons"
    case animatedEmojies = "Animated Emojies"
    
    /// Gets the full reference to the folder within the storage.
    ///
    /// - Parameter storageRef: The root storage reference.
    /// - Returns: A `StorageReference` pointing to the full path of the folder.
    func fullReference(storageRef: StorageReference) -> StorageReference {
        switch self {
        case .resources:
            return storageRef.child(self.rawValue)
        case .avatarIcons:
            return Self.resources.fullReference(storageRef: storageRef).child(self.rawValue)
        case .animatedEmojies:
            return Self.resources.fullReference(storageRef: storageRef).child(self.rawValue)
        }
    }
}

/// Represents the different types of Firebase storage buckets.
enum BucketTypes {
    case production
    case mockTesting
    
    /// The URL of the bucket.
    var nameURL: String {
        switch self {
        case .production:
            return "gs://iamsad-production-bucket"
        case .mockTesting:
            return "gs://iamsad-mock-testing-bucket"
        }
    }
}
