//
//  Testing.swift
//  IAMSAD
//
//  Created by Mr. Kavinda Dilshan on 2024-11-02.
//

import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct Testing: View {
    @State private var url: URL?
    
    let storageManager: FirebaseStorageManager = .init(bucket: .mockTesting)
    
    var body: some View {
        var fullReference: StorageReference {
            get async {
                await storageManager.getFullReference(to: .avatarIcons).child("Animals/Animals_1.png")
            }
        }
        
       
        VStack {
            WebImage(url: self.url)
                .resizable()
                .placeholder {
                    Rectangle()
                        .fill(.red)
                }
                .scaledToFit()
                .frame(width: 50, height: 50)
                .task {
                    do {
                        let url: URL =  try await fullReference.downloadURL()
                        print(url.description)
                        self.url = url
                    } catch {
                        print("Something went wrong: \(error.localizedDescription)")
                    }
                }
        }
    }
}

#Preview {
    Testing()
}
